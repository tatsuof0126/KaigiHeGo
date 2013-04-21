//
//  DataManager.h
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/20.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (void)saveString:(NSString*)filename targetString:(NSString*)targetString;

+ (NSString*)loadString:(NSString*)filename;

// + (void)saveJigyoshoList:(NSString*)jigyoshoListStr;

// + (NSArray*)loadJigyoshoList;

@end
