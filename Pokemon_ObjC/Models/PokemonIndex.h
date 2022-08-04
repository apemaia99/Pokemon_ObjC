//
//  PokemonIndex.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 31/07/22.
//

#import <Foundation/Foundation.h>
#import "PokemonAnchor.h"

@interface PokemonIndex : NSObject

@property(readonly) unsigned int count;
@property(readonly, nullable) NSURL *next;
@property(readonly, nullable) NSURL *previous;
@property(readonly, nullable) NSArray<PokemonAnchor *> *anchors;

+ (instancetype _Nonnull) initFromData:(NSData * _Nonnull)data;
- (void) getCurrentInfo;

@end
