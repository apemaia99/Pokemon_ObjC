//
//  PokemonSprites.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 02/08/22.
//

#import "PokemonSprites.h"

@interface PokemonSprites ()

@property(readwrite, nonnull) NSURL *front_default;

@end

@implementation PokemonSprites

+ (instancetype _Nonnull) initFromDictionary:(NSDictionary * _Nonnull)dictionary {
    
    PokemonSprites *newInstance = [[PokemonSprites alloc] init];
    
    newInstance.front_default = [dictionary objectForKey:@"front_default"];
    
    return newInstance;
}

@end
