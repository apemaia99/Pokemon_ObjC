//
//  PokemonAnchor.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 01/08/22.
//

#import <Foundation/Foundation.h>
#import "PokemonAnchor.h"

@implementation PokemonAnchor

+ (instancetype) initWithName:(NSString * _Nonnull)name url:(NSURL * _Nonnull)url {
    
    PokemonAnchor *newInstance = [[PokemonAnchor alloc] init];
    
    newInstance.name = name;
    newInstance.url = url;
    
    return newInstance;
}

@end
