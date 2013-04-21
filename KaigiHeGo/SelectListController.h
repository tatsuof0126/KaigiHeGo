//
//  SelectListController.h
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/20.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchInputController.h"

#define TO_JIGYOSHO 1
#define TO_YOKUTSUKAU 2

@interface SelectListController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray* selectList;

@property (strong, nonatomic) SearchInputController* source;
@property int selecttype;

- (IBAction)backButton:(id)sender;

@end
