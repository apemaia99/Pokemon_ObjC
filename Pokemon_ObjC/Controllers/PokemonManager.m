//
//  PokemonManager.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 02/08/22.
//

#import "PokemonManager.h"

@interface PokemonManager ()

@property(nonnull, readwrite) NSMutableArray<Pokemon *> *pokemonList;
@property(nullable, readwrite) NSMutableArray<Pokemon *> *pokemonFiltered;
@property(nullable) PokemonIndex *pokemonIndex;

- (void)getDataByUrl:(NSURL *)url completion:(void (^ _Nonnull)(NSData * _Nullable data))completionHandler;
- (void)getPokemons:(void (^ _Nonnull)(void))completionHandler;

@end

@implementation PokemonManager

+ (instancetype)init {
    
    PokemonManager *newInstance = [PokemonManager alloc];
    newInstance.pokemonList = [[NSMutableArray alloc] init];
    newInstance.pokemonFiltered = [[NSMutableArray alloc] init];
    
    return newInstance;
}

- (void)getDataByUrl:(NSURL *)url completion:(void (^ _Nonnull)(NSData * _Nullable data))completionHandler {
    
    [NetworkService fetchObjectByUrl:url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            completionHandler(data);
        } else {
            NSLog(@"Error: %@ - (PokemonManager: getDataByUrl)", error.localizedDescription);
            completionHandler(nil);
        }
    }];
}

- (void)getPokemons:(void (^ _Nonnull)(void))completionHandler {
    
    if (!self.pokemonIndex) {
        NSLog(@"Missing pokemon index");
        return;
    }
    
    dispatch_group_t fetchingAnchors = dispatch_group_create();
    
    for (PokemonAnchor *pokemonAnchor in self.pokemonIndex.anchors) {
        
        dispatch_group_enter(fetchingAnchors);
        
        [self getDataByUrl:pokemonAnchor.url completion:^(NSData * _Nullable data) {
            [self.pokemonList addObject:[Pokemon initFromData:data]];
            dispatch_group_leave(fetchingAnchors);
        }];
    }
    
    dispatch_group_notify(fetchingAnchors, dispatch_get_main_queue(), ^{
        completionHandler();
    });
}

- (void)loadFirstTimeWithCompletion:(void (^ _Nonnull)(void))completionHandler {
    [self getDataByUrl:[NSURL URLWithString:@"https://pokeapi.co/api/v2/pokemon/"] completion:^(NSData * _Nullable data) {
        self.pokemonIndex = [PokemonIndex initFromData:data];
        [self getPokemons:^{
            [self sortListByMode:standard];
            completionHandler();
        }];
    }];
}

- (void)loadMoreWithCompletion:(void (^ _Nonnull)(void))completionHandler {
    
    if (!self.pokemonIndex) {
        NSLog(@"Error: missing pokemon index - (PokemonManager: loadMore)");
        return;
    }
    
    if (!self.pokemonIndex.next) {
        NSLog(@"Error: next url not valid - (PokemonManager: loadMore)");
        return;
    }
    
    [self getDataByUrl:self.pokemonIndex.next completion:^(NSData * _Nullable data) {
        self.pokemonIndex = [PokemonIndex initFromData:data];
        [self getPokemons:^{
            completionHandler();
        }];
    }];
}

- (void)sortListByMode:(OrderMode)mode {
    
    NSSortDescriptor *sortRule;
    
    switch (mode) {
        case standard:
            sortRule = [[NSSortDescriptor alloc] initWithKey:@"ID" ascending:YES];
            break;
        case alphabetical:
            sortRule = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            break;
        case reverse:
            sortRule = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
            break;
        default:
            break;
    }
    [self.pokemonList sortUsingDescriptors:@[sortRule]];
}

- (void)filterListByText:(NSString *_Nonnull)text {
    
    
    
    NSPredicate *p = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        Pokemon *hit = (Pokemon *)evaluatedObject;
        
        return [hit.name localizedCaseInsensitiveContainsString:text];
    }];
    
    [self.pokemonFiltered removeAllObjects];
    [self.pokemonFiltered addObjectsFromArray:[self.pokemonList filteredArrayUsingPredicate:p]];
}

@end
