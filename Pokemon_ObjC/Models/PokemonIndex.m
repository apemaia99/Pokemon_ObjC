//
//  PokemonIndex.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 31/07/22.
//

#import "PokemonIndex.h"

@interface PokemonIndex ()

@property(readwrite) unsigned int count;
@property(readwrite, nullable) NSURL *next;
@property(readwrite, nullable) NSURL *previous;
@property(readwrite, nullable) NSArray<PokemonAnchor *> *anchors;

@end

@implementation PokemonIndex

+ (instancetype _Nonnull) initFromData:(NSData * _Nonnull)data {
    
    PokemonIndex *newIstance = [[PokemonIndex alloc] init];
    
    NSError *serializationError = nil;
    NSDictionary *serialized = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
    
    if (serializationError) {
        printf("SERIALIZATION ERROR\n");
        return nil;
    }
    
    newIstance.count = [[serialized objectForKey:@"count"] intValue];
    
    if (![[serialized objectForKey:@"next"] isKindOfClass:[NSNull class]])
        newIstance.next = [NSURL URLWithString:[serialized objectForKey:@"next"]];
    
    if (![[serialized objectForKey:@"previous"] isKindOfClass:[NSNull class]])
        newIstance.previous = [NSURL URLWithString:[serialized objectForKey:@"previous"]];
    
    NSMutableArray *temporaryAnchors = [[NSMutableArray alloc] init];
    
    for (NSDictionary *anchor in [serialized objectForKey:@"results"]) {
        [temporaryAnchors addObject:[PokemonAnchor initWithName:[anchor objectForKey:@"name"]
                                                            url:[NSURL URLWithString:[anchor objectForKey:@"url"]]
                                    ]];
    }
    
    newIstance.anchors = [[NSArray alloc] initWithArray:temporaryAnchors];
    
    return newIstance;
}

- (void) getCurrentInfo {
    NSLog(@"%d", _count);
    NSLog(@"%@", _previous);
    NSLog(@"%@", _next);
    for (PokemonAnchor *anchor in _anchors) {
        NSLog(@"%@", anchor.name);
        NSLog(@"%@", anchor.url);
    }
};

@end

