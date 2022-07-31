//
//  NetworkService.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 30/07/22.
//

#import "NetworkService.h"

@implementation NetworkService

+ (void)fetchDataAsDictionaryByUrl:(NSURL * _Nonnull)url
                        completion:(void (^ _Nonnull)(NSDictionary * _Nullable data, NSError * _Nullable error))completionHandler {
    
    [[NSURLSession.sharedSession dataTaskWithURL:url
                               completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (error || httpResponse.statusCode != 200) {
            completionHandler(nil, error);
        }
        
        NSError *serializationError = nil;
        
        NSDictionary *serialized = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&serializationError];
        
        if (serializationError) {
            completionHandler(nil, error);
        }
        
        completionHandler(serialized, nil);
        
    }] resume];
    
}

+ (void)fetchDataAsArrayByUrl:(NSURL * _Nonnull)url
                   completion:(void (^ _Nonnull)(NSArray * _Nullable data, NSError * _Nullable error))completionHandler {
    
    [[NSURLSession.sharedSession dataTaskWithURL:url
                               completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (error || httpResponse.statusCode != 200) {
            completionHandler(nil, error);
        }
        
        NSError *serializationError = nil;
        
        NSArray *serialized = [NSJSONSerialization JSONObjectWithData:data
                                                              options:0
                                                                error:&serializationError];
        
        if (serializationError) {
            completionHandler(nil, error);
        }
        
        completionHandler(serialized, nil);
        
    }] resume];
    
}

@end
