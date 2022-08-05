//
//  NetworkService.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 30/07/22.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

+ (instancetype _Nonnull)sharedInstance;

+ (void)fetchObjectByUrl:(NSURL * _Nonnull)url
              completion:(void (^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))completionHandler;

- (void)fetchObjectByUrlWithCache:(NSURL * _Nonnull)url
              completion:(void (^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))completionHandler;

@end
