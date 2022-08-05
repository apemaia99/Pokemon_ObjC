//
//  PokemonManager.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 02/08/22.
//

#import <Foundation/Foundation.h>
#import "NetworkService.h"
#import "PokemonIndex.h"
#import "Pokemon.h"

@interface PokemonManager : NSObject

typedef NS_ENUM(NSInteger, OrderMode) {
    standard = 0,
    alphabetical = 1,
    reverse = 2
};

+ (instancetype _Nullable)init;
- (void)loadFirstTimeWithCompletion:(void (^ _Nonnull)(void))completionHandler;
- (void)loadMoreWithCompletion:(void (^ _Nonnull)(void))completionHandler;
- (void)sortPokemonsByMode:(OrderMode)mode;
- (void)filterPokemonsByText:(NSString *_Nonnull)text;
- (NSArray *_Nullable)allPokemons;
- (NSArray *_Nullable)filteredPokemons;

@end
