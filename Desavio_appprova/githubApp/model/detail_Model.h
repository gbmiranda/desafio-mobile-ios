//
//  detail_Model.h
//  githubApp
//
//  Created by Brandao, Camillo on 18/10/17.
//  Copyright © 2017 Brandao, Camillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface detail_Model : NSObject
@property NSMutableArray *items;
-(NSMutableArray *)getData:(NSString*)urlPull;
@end
