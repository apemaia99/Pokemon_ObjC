//
//  PokemonAnchor.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 01/08/22.
//

#import "PokemonAnchor.h"

@interface PokemonAnchor ()

@property(readwrite, nonnull) NSString *name;
@property(readwrite, nonnull) NSURL *url;

@end

@implementation PokemonAnchor

+ (instancetype) initWithName:(NSString * _Nonnull)name url:(NSURL * _Nonnull)url {
    
    PokemonAnchor *newInstance = [[PokemonAnchor alloc] init];
    
    newInstance.name = name;
    newInstance.url = url;
    
    return newInstance;
}

@end
