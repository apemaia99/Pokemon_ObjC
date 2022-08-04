//
//  Pokemon.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 02/08/22.
//

#import <Foundation/Foundation.h>
#import "PokemonAnchor.h"
#import "PokemonSprites.h"

@interface Pokemon : NSObject

@property(readonly) unsigned int ID;
@property(readonly, nonnull) NSString *name;
@property(readonly, nonnull) NSArray<PokemonAnchor *> *moves;
@property(readonly, nonnull) PokemonSprites *sprites;
@property(readonly) unsigned int height;
@property(readonly) unsigned int weight;

+ (instancetype _Nullable)initFromData:(NSData * _Nonnull)data;
- (void)getCurrentInfo;

@end
