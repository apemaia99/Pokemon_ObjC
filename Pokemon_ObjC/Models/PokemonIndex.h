//
//  PokemonIndex.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 31/07/22.
//

#import <Foundation/Foundation.h>
#import "PokemonAnchor.h"

@interface PokemonIndex : NSObject

@property unsigned int count;
@property(nullable) NSURL *next;
@property(nullable) NSURL *previous;
@property(nullable) NSArray<PokemonAnchor *> *anchors;

+ (instancetype _Nonnull) initFromData:(NSData * _Nonnull)data;

- (void) getCurrentInfo;

@end



