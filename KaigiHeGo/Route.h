//
//  Route.h
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/21.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Route : NSObject

@property int fromjid;
@property int tojid;
@property (strong, nonatomic) NSString *fromstation;
@property int fromtoho;
@property (strong, nonatomic) NSString *tostation;

+ (NSArray*)getRouteList;

+ (void)saveDefaultRouteList;

@end
