//
//  Jigyosho.m
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/20.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import "Jigyosho.h"
#import "DataManager.h"

@implementation Jigyosho

@synthesize jid;
@synthesize name;
@synthesize moyorieki;
@synthesize toho;
@synthesize lat;
@synthesize lon;

+ (NSArray*)getJigyoshoList {
    NSArray* array = [self makeJigyoshoList:[DataManager loadString:@"jigyosho.dat"]];
    if(array == nil){
        [self saveDefaultJigyoshoList];
        array = [self makeJigyoshoList:[DataManager loadString:@"jigyosho.dat"]];
    }
    
    return array;
}

+ (NSArray*)getJigyosho:(int)jid {
    if(jid < 0){
        return nil;
    }
    
    NSArray* array = [self getJigyoshoList];
    return [array objectAtIndex:jid];
}

+ (NSArray*)makeJigyoshoList:(NSString*)sourceString {
    if([@"" isEqualToString:sourceString]){
        return nil;
    }
    
    NSArray* jigyoshoStringArray = [sourceString componentsSeparatedByString:@"\n"];
    
    NSMutableArray* jigyoshoArray = [NSMutableArray array];
    
    for(int i=0;i<[jigyoshoStringArray count];i++){
        NSString* jigyoshoString = [jigyoshoStringArray objectAtIndex:i];
        
//        NSLog(@"[%@]",jigyoshoString);
        
        if([@"" isEqualToString:jigyoshoString]){
            continue;
        }
        
        NSArray* jigyoshoItemStringArray = [jigyoshoString componentsSeparatedByString:@","];
        
        Jigyosho* jigyosho = [[Jigyosho alloc] init];
        jigyosho.jid = [[jigyoshoItemStringArray objectAtIndex:0] intValue];
        jigyosho.name = [jigyoshoItemStringArray objectAtIndex:1];
        jigyosho.moyorieki = [jigyoshoItemStringArray objectAtIndex:2];
        jigyosho.toho = [[jigyoshoItemStringArray objectAtIndex:3] intValue];
        jigyosho.lat = [[jigyoshoItemStringArray objectAtIndex:4] doubleValue];
        jigyosho.lon = [[jigyoshoItemStringArray objectAtIndex:5] doubleValue];
        
        [jigyoshoArray addObject:jigyosho];
    }
    
    return jigyoshoArray;
}

+ (void)saveDefaultJigyoshoList {
    NSMutableString* listStr = [NSMutableString string];
    
    [listStr appendString:@"0,本社事業所,新橋,5,35.667119,139.763014\n"];
    [listStr appendString:@"1,大森事業所,馬込,8,35.597719,139.707203\n"];
    [listStr appendString:@"2,品川事業所,品川シーサイド,3,35.612027,139.750273\n"];
    [listStr appendString:@"3,新横浜事業所,新横浜,10,35.510945,139.620681\n"];
    [listStr appendString:@"4,中央研究所,仲町台,8,35.537357,139.594033\n"];
    [listStr appendString:@"5,海老名事業所,海老名,10,35.458849,139.389126\n"];
//    [listStr appendString:@"6,富士見ヶ丘の家,富士見ヶ丘,10,35.680008,139.604547\n"];
    
    [DataManager saveString:@"jigyosho.dat" targetString:listStr];
}

@end
