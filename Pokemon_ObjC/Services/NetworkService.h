//
//  NetworkService.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 30/07/22.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

+ (void)fetchDataAsDictionaryByUrl:(NSURL * _Nonnull)url
                        completion:(void (^ _Nonnull)(NSDictionary * _Nullable data, NSError * _Nullable error))completionHandler;

+ (void)fetchDataAsArrayByUrl:(NSURL * _Nonnull)url
                   completion:(void (^ _Nonnull)(NSArray * _Nullable data, NSError * _Nullable error))completionHandler;

@end
