//
//  SecondViewController.m
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/19.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import "ConfigController.h"

@interface ConfigController ()

@end

@implementation ConfigController

@synthesize versionLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    versionLabel.text = [NSString stringWithFormat:@"会議へGo  ver%@",version];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setVersionLabel:nil];
    [super viewDidUnload];
}
@end
