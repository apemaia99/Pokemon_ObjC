//
//  NetworkService.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 30/07/22.
//

#import "NetworkService.h"

@implementation NetworkService

+ (void)fetchObjectByUrl:(NSURL * _Nonnull)url
              completion:(void (^ _Nonnull)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    
    [[NSURLSession.sharedSession dataTaskWithURL:url
                               completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (error || httpResponse.statusCode != 200)
            completionHandler(nil, error);
        
        completionHandler(data, nil);
        
    }] resume];
}

@end
