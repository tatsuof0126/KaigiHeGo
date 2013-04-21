//
//  FirstViewController.h
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/19.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Jigyosho.h"

@interface SearchInputController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager* lm;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UINavigationItem *topNavi;

@property (strong, nonatomic) IBOutlet UIButton *searchlocationBtn;

@property int fromjigyoshoid;
@property (strong, nonatomic) IBOutlet UITextField *fromstation;
@property (strong, nonatomic) IBOutlet UILabel *fromjigyoshoname;
@property (strong, nonatomic) IBOutlet UITextField *fromtoho;

@property (strong, nonatomic) NSString* fromstationorg;
@property (strong, nonatomic) NSString* fromtohoorg;

@property int tojigyoshoid;
@property (strong, nonatomic) IBOutlet UITextField *tostation;
@property (strong, nonatomic) IBOutlet UILabel *tojigyoshoname;

- (IBAction)searchlocationButton:(id)sender;

- (IBAction)searchButton:(id)sender;

- (void)setToJigyosho:(Jigyosho*)jigyosho;

@end
