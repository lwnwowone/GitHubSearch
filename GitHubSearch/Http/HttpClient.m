//
//  HttpClient.m
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "HttpClient.h"
#import "HttpUtil.h"

@implementation HttpClient

-(ActionResult<NSString *> *)getWithURLString:(NSString *)urlString query:(NSDictionary *)quertDic{
    NSString *queryStr = [HttpUtil queryStringFromDictionary:quertDic];
    urlString = [NSString stringWithFormat:@"%@?%@", urlString, queryStr];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return [self sendRequest:request];
}

-(ActionResult<NSString *> *)sendRequest:(NSURLRequest *)request{
    __block ActionResult<NSString *> *httpResult = [ActionResult new];
    httpResult.errorMsg = @"unhandled http request error";
    NSLog(@"------------------- http request will start -------------------");
    NSLog(@"request.url = %@", request.URL);
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"------------------- http request will finish -------------------");
        if (error == nil) {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            long httpStatusCode = [httpResponse statusCode];
            if(200 == httpStatusCode){
                httpResult.isSucceeded = true;
                httpResult.statusCode = httpStatusCode;
                httpResult.data = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
            else{
                httpResult.statusCode = httpStatusCode;
                httpResult.errorMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
        else {
            httpResult.errorMsg = [error localizedDescription];
        }
        dispatch_semaphore_signal(sem);
    }];
    
    [dataTask resume];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"request.status = %ld", httpResult.statusCode);
//    NSLog(@"request.response = %@", httpResult.data);
    NSLog(@"------------------- http request did finish -------------------");

    return httpResult;
}

@end

