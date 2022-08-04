//
//  Pokemon.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 02/08/22.
//

#import "Pokemon.h"

@interface Pokemon ()

@property(readwrite) unsigned int ID;
@property(readwrite, nonnull) NSString *name;
@property(readwrite, nonnull) NSArray<PokemonAnchor *> *moves;
@property(readwrite, nonnull) PokemonSprites *sprites;
@property(readwrite) unsigned int height;
@property(readwrite) unsigned int weight;

@end

@implementation Pokemon

+ (instancetype _Nullable)initFromData:(NSData * _Nonnull)data {
    
    Pokemon *newInstance = [[Pokemon alloc] init];
    
    NSError *serializationError = nil;
    NSDictionary *serialized = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
    
    if (serializationError) {
        printf("SERIALIZATION ERROR\n");
        return nil;
    }
    
    newInstance.ID = [[serialized objectForKey:@"id"] intValue];
    newInstance.name = [serialized objectForKey:@"name"];
    newInstance.height = [[serialized objectForKey:@"height"] intValue];
    newInstance.weight = [[serialized objectForKey:@"weight"] intValue];
    newInstance.sprites = [PokemonSprites initFromDictionary:[serialized objectForKey:@"sprites"]];
    
    NSMutableArray *temporaryAnchors = [[NSMutableArray alloc] init];
    
    for (NSDictionary *moveAnchor in [serialized objectForKey:@"moves"]) {
        [temporaryAnchors addObject:[PokemonAnchor initWithName:[[moveAnchor objectForKey:@"move"] objectForKey:@"name"]
                                                            url:[NSURL URLWithString:[[moveAnchor objectForKey:@"move"] objectForKey:@"url"]]
                                    ]];
    }
    
    newInstance.moves = [[NSArray alloc] initWithArray:temporaryAnchors];
    
    return newInstance;
}

- (void)getCurrentInfo {
    NSLog(@"%d", _ID);
    NSLog(@"%@", _name);
    NSLog(@"%d", _height);
    NSLog(@"%d", _weight);
    for (PokemonAnchor *moveAnchor in _moves) {
        NSLog(@"%@", moveAnchor.name);
        NSLog(@"%@", moveAnchor.url);
    }
}

@end
