//
//  service.h
//  githubApp
//
//  Created by Brandao, Camillo on 09/10/17.
//  Copyright © 2017 Brandao, Camillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface service : NSObject
-(NSData *)getService:(int*)endPoint;
-(NSMutableArray *)getServicePullRequests:(NSString*)urlPull;
@end
