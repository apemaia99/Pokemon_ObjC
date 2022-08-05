//
//  NetworkService.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 30/07/22.
//

#import "NetworkService.h"

@interface NetworkService ()

@property NSMutableDictionary<NSURL *, NSData *> *cache;

@end

@implementation NetworkService

+ (instancetype)sharedInstance {
    
    static NetworkService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkService alloc] init];
        sharedInstance.cache = [[NSMutableDictionary alloc] init];
    });
    return sharedInstance;
}

+ (void)fetchObjectByUrl:(NSURL * _Nonnull)url
              completion:(void (^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    
    [[NSURLSession.sharedSession dataTaskWithURL:url
                               completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (error || httpResponse.statusCode != 200) {
            completionHandler(nil, error);
        } else {
            completionHandler(data, nil);
        }
    }] resume];
}

- (void)fetchObjectByUrlWithCache:(NSURL * _Nonnull)url
                       completion:(void (^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    
    if ([self.cache objectForKey:url]) {
        completionHandler([self.cache objectForKey:url], nil);
    } else {
        [NetworkService fetchObjectByUrl:url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (error) {
                completionHandler(nil, error);
            } else {
                [self.cache setObject:data forKey:url];
                completionHandler(data, nil);
            }
        }];
    }
}

@end
