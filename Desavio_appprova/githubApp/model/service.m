//
//  service.m
//  githubApp
//
//  Created by Brandao, Camillo on 09/10/17.
//  Copyright © 2017 Brandao, Camillo. All rights reserved.
//

#import "service.h"
#import "AFNetworking.h"
#define BASE_URL @"https://api.github.com/search/repositories?q=language:Java&sort=stars&page="

@implementation service
{
    NSArray *dataResponse;
}

-(NSData *)getService:(int*)page
{
    NSString *urlFinal = BASE_URL;
    urlFinal = [urlFinal stringByAppendingString:[NSString stringWithFormat: @"%ld", page]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:urlFinal parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Sucess");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        
    }];
    
    
    [manager.operationQueue addOperation:operation];
    [manager.operationQueue waitUntilAllOperationsAreFinished];
    
    
    return [operation responseObject];

}

-(NSMutableArray *)getServicePullRequests:(NSString*)urlPull
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:urlPull parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Sucess");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        
    }];
    
    
    [manager.operationQueue addOperation:operation];
    [manager.operationQueue waitUntilAllOperationsAreFinished];

    NSLog(@"Data no service %@", [operation responseObject]);
    return [operation responseObject];
    
    
}

@end
