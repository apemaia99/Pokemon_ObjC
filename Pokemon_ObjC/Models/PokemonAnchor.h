//
//  PokemonAnchor.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 31/07/22.
//

#import <Foundation/Foundation.h>

@interface PokemonAnchor : NSObject

@property(readonly, nonnull) NSString *name;
@property(readonly, nonnull) NSURL *url;

+ (instancetype _Nonnull) initWithName:(NSString * _Nonnull)name url:(NSURL * _Nonnull)url;

@end
