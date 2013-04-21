//
//  Route.m
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/21.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import "Route.h"
#import "DataManager.h"

@implementation Route

@synthesize fromjid;
@synthesize tojid;
@synthesize fromstation;
@synthesize fromtoho;
@synthesize tostation;

+ (NSArray*)getRouteList {
    NSArray* array = [self makeRouteList:[DataManager loadString:@"route.dat"]];
    if(array == nil){
        [self saveDefaultRouteList];
        array = [self makeRouteList:[DataManager loadString:@"route.dat"]];
    }
    
    return array;
}

+ (NSArray*)makeRouteList:(NSString*)sourceString {
    if([@"" isEqualToString:sourceString]){
        return nil;
    }
    
    NSArray* routeStringArray = [sourceString componentsSeparatedByString:@"\n"];
    
    NSMutableArray* routeArray = [NSMutableArray array];
    NSMutableArray* routeSubArray = nil;
    int fromjid = -999;
    
    for(int i=0;i<[routeStringArray count];i++){
        NSString* routeString = [routeStringArray objectAtIndex:i];
        
//        NSLog(@"[%@]",routeString);
        
        if([@"" isEqualToString:routeString]){
            continue;
        }
        
        NSArray* routeItemStringArray = [routeString componentsSeparatedByString:@","];
        
        Route* route = [[Route alloc] init];
        route.fromjid = [[routeItemStringArray objectAtIndex:0] intValue];
        route.tojid = [[routeItemStringArray objectAtIndex:1] intValue];
        route.fromstation = [routeItemStringArray objectAtIndex:2];
        route.fromtoho = [[routeItemStringArray objectAtIndex:3] intValue];
        route.tostation = [routeItemStringArray objectAtIndex:4];
        
        if(fromjid != route.fromjid){
            routeSubArray = [NSMutableArray array];
            [routeArray addObject:routeSubArray];
            fromjid = route.fromjid;
        }
        
        [routeSubArray addObject:route];
    }
    
    return routeArray;
}

+ (void)saveDefaultRouteList {
    NSMutableString* listStr = [NSMutableString string];
    
    [listStr appendString:@"0,0,新橋,5,新橋\n"];
    [listStr appendString:@"0,1,新橋,5,馬込\n"];
    [listStr appendString:@"0,2,新橋,5,青物横丁\n"];
    [listStr appendString:@"0,3,新橋,5,新横浜\n"];
    [listStr appendString:@"0,4,新橋,5,仲町台\n"];
    [listStr appendString:@"0,5,新橋,5,海老名\n"];

    [listStr appendString:@"1,0,馬込,8,新橋\n"];
    [listStr appendString:@"1,1,馬込,8,馬込\n"];
    [listStr appendString:@"1,2,荏原町,8,品川シーサイド\n"];
    [listStr appendString:@"1,3,荏原町,8,新横浜\n"];
    [listStr appendString:@"1,4,荏原町,8,仲町台\n"];
    [listStr appendString:@"1,5,荏原町,8,海老名\n"];
    
    [listStr appendString:@"2,0,青物横丁,10,新橋\n"];
    [listStr appendString:@"2,1,品川シーサイド,3,荏原町\n"];
    [listStr appendString:@"2,2,品川シーサイド,3,品川シーサイド\n"];
    [listStr appendString:@"2,3,品川シーサイド,3,新横浜\n"];
    [listStr appendString:@"2,4,品川シーサイド,3,仲町台\n"];
    [listStr appendString:@"2,5,品川シーサイド,3,海老名\n"];
    
    [listStr appendString:@"3,0,新横浜,10,新橋\n"];
    [listStr appendString:@"3,1,新横浜,10,荏原町\n"];
    [listStr appendString:@"3,2,新横浜,10,品川シーサイド\n"];
    [listStr appendString:@"3,3,新横浜,10,新横浜\n"];
    [listStr appendString:@"3,4,新横浜,10,仲町台\n"];
    [listStr appendString:@"3,5,新横浜,10,海老名\n"];

    [listStr appendString:@"4,0,仲町台,8,新橋\n"];
    [listStr appendString:@"4,1,仲町台,8,荏原町\n"];
    [listStr appendString:@"4,2,仲町台,8,品川シーサイド\n"];
    [listStr appendString:@"4,3,仲町台,8,新横浜\n"];
    [listStr appendString:@"4,4,仲町台,8,仲町台\n"];
    [listStr appendString:@"4,5,仲町台,8,海老名\n"];

    [listStr appendString:@"5,0,海老名,10,新橋\n"];
    [listStr appendString:@"5,1,海老名,10,荏原町\n"];
    [listStr appendString:@"5,2,海老名,10,品川シーサイド\n"];
    [listStr appendString:@"5,3,海老名,10,新横浜\n"];
    [listStr appendString:@"5,4,海老名,10,仲町台\n"];
    [listStr appendString:@"5,5,海老名,10,海老名\n"];
    
//    [listStr appendString:@"6,0,海老名,10,新橋\n"];
//    [listStr appendString:@"6,1,海老名,10,荏原町\n"];
//    [listStr appendString:@"6,2,久我山,15,品川シーサイド\n"];
//    [listStr appendString:@"6,3,久我山,15,新横浜\n"];
//    [listStr appendString:@"6,4,海老名,10,仲町台\n"];
//    [listStr appendString:@"6,5,海老名,10,海老名\n"];
//    [listStr appendString:@"6,6,富士見ヶ丘,10,富士見ヶ丘\n"];
    
    [DataManager saveString:@"route.dat" targetString:listStr];
}

@end
