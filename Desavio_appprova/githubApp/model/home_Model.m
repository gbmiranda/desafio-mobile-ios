//
//  home_Model.m
//  githubApp
//
//  Created by Brandao, Camillo on 18/10/17.
//  Copyright © 2017 Brandao, Camillo. All rights reserved.
//

#import "home_Model.h"
#import "service.h"

@implementation home_Model
{
    BOOL isPageRefreshing;
    int pageCount;
    service *getData;
}

- (id)init {
    self = [super init];
    if (self) {
        getData = [[service alloc] init];
    }
    return self;
}

-(NSMutableArray *)getRecords:(int*)page
{
    
    NSDictionary *jsonDict = (NSDictionary *) [getData getService:page];
    self.items = [jsonDict objectForKey:@"items"];
    return self.items;
}

-(NSMutableArray *)getAvatar
{
//    NSDictionary *jsonDict = (NSDictionary *) [getData getService:page];
//    self.items = [jsonDict objectForKey:@"items"];
    return nil;
}

-(NSMutableArray *)nextPage:(int*)page
{
    NSDictionary *jsonDict = (NSDictionary *) [getData getService:page];
    NSArray *dataFinal= [jsonDict valueForKey:@"items"];
    self.items=[NSMutableArray arrayWithArray:_items];
    [self.items addObjectsFromArray:dataFinal];
    
    return self.items;
}


@end
