//
//  Jigyosho.h
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/20.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jigyosho : NSObject

@property int jid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *moyorieki;
@property int toho; // 緯度
@property double lat; // 緯度
@property double lon; // 経度

+ (NSArray*)getJigyoshoList;

+ (Jigyosho*)getJigyosho:(int)jid;

+ (void)saveDefaultJigyoshoList;

@end
