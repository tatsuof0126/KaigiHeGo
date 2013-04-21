//
//  DataManager.m
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/20.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import "DataManager.h"
#import "Jigyosho.h"

@implementation DataManager

+ (void)saveString:(NSString*)filename targetString:(NSString*)targetString {
    NSArray* dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dirpath = [dirpaths objectAtIndex:0];
    NSString* filepath = [dirpath stringByAppendingPathComponent:filename];
    
    NSData* data = [targetString dataUsingEncoding:NSUTF8StringEncoding];
    
    [data writeToFile:filepath atomically:YES];
}

+ (NSString*)loadString:(NSString*)filename {
    NSArray* dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dirpath = [dirpaths objectAtIndex:0];
    NSString* filepath = [dirpath stringByAppendingPathComponent:filename];
    
    NSData* readdata = [NSData dataWithContentsOfFile:filepath];
    
    return [[NSString alloc] initWithData:readdata encoding:NSUTF8StringEncoding];
}


/*






+ (void)saveJigyoshoList:(NSString*)jigyoshoListStr {
    NSArray* dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dirpath = [dirpaths objectAtIndex:0];
    NSString* filename = [NSString stringWithFormat:@"jigyosho.dat"];
    NSString* filepath = [dirpath stringByAppendingPathComponent:filename];
    
    NSData* data = [jigyoshoListStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [data writeToFile:filepath atomically:YES];
}

+ (NSArray*)loadJigyoshoList {
    NSArray* dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dirpath = [dirpaths objectAtIndex:0];
    NSString* filename = [NSString stringWithFormat:@"jigyosho.dat"];
    NSString* filepath = [dirpath stringByAppendingPathComponent:filename];
    
    NSData* readdata = [NSData dataWithContentsOfFile:filepath];
    
    NSString* resultStr = [[NSString alloc] initWithData:readdata encoding:NSUTF8StringEncoding];
    
    NSLog(@"resultStr[%@]",resultStr);
    
    if([@"" isEqualToString:resultStr]){
        return nil;
    }
    
    NSArray* resultStrArray = [resultStr componentsSeparatedByString:@"\n"];
    
    NSMutableArray* retArray = [NSMutableArray array];
    
    for(int i=0;i<[resultStrArray count];i++){
        NSString* jigyoshoStr = [resultStrArray objectAtIndex:i];
        
        NSLog(@"[%@]",jigyoshoStr);
        
        
        if([@"" isEqualToString:jigyoshoStr]){
            continue;
        }
        
        NSArray* jigyoshoStrArray = [jigyoshoStr componentsSeparatedByString:@","];
        
        Jigyosho* jigyosho = [[Jigyosho alloc] init];
        jigyosho.jid = [[jigyoshoStrArray objectAtIndex:0] intValue];
        jigyosho.name = [jigyoshoStrArray objectAtIndex:1];
        jigyosho.moyorieki = [jigyoshoStrArray objectAtIndex:2];
        jigyosho.toho = [[jigyoshoStrArray objectAtIndex:3] intValue];
        jigyosho.lat = [[jigyoshoStrArray objectAtIndex:4] doubleValue];
        jigyosho.lon = [[jigyoshoStrArray objectAtIndex:5] doubleValue];
        
        [retArray addObject:jigyosho];
    }
    
    return retArray;
}
*/

@end
