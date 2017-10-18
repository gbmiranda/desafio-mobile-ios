//
//  detail_Model.m
//  githubApp
//
//  Created by Brandao, Camillo on 18/10/17.
//  Copyright © 2017 Brandao, Camillo. All rights reserved.
//

#import "detail_Model.h"
#import "service.h"

@implementation detail_Model
{
    service *getData;
}

- (id)init {
    self = [super init];
    if (self) {
        getData = [[service alloc] init];
    }
    return self;
}


-(NSMutableArray *)getData:(NSString*)urlPull{
    
    self.items = [getData getServicePullRequests:urlPull];
    
    NSLog(@"items aqui %@", [getData getServicePullRequests:urlPull]);
    return self.items;
}
@end
