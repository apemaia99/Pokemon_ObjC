//
//  PokemonSprites.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 02/08/22.
//

#import <Foundation/Foundation.h>

@interface PokemonSprites : NSObject

@property(readonly, nonnull) NSURL *front_default;

+ (instancetype _Nonnull) initFromDictionary:(NSDictionary * _Nonnull)dictionary;

@end
