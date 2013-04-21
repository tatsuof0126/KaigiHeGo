//
//  FirstViewController.m
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/19.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import "SearchInputController.h"
#import "SelectListController.h"
#import "DataManager.h"
#import "Jigyosho.h"
#import "Route.h"
#import "MBProgressHUD.h"

#define NO_ID -999

@interface SearchInputController ()

@end

@implementation SearchInputController

@synthesize scrollView;
@synthesize topNavi;
@synthesize searchlocationBtn;
@synthesize fromjigyoshoid;
@synthesize fromstation;
@synthesize fromjigyoshoname;
@synthesize fromtoho;
@synthesize fromstationorg;
@synthesize fromtohoorg;
@synthesize tojigyoshoid;
@synthesize tostation;
@synthesize tojigyoshoname;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initCondition];
    [self locationSearch];
}

- (void)initCondition {
    fromjigyoshoid = NO_ID;
    fromjigyoshoname.text = @"";
    fromtoho.text = @"5";
    tojigyoshoname.text = @"";

    // 自動設定した値を保存
    fromstationorg = fromstation.text;
    fromtohoorg = fromtoho.text;    
}

- (void)locationSearch {
    //ぐるぐるを出す
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.scrollView animated:YES];
    [hud setLabelText:@"現在地を取得中..."];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"中止"
        style:UIBarButtonItemStylePlain target:self action:@selector(stopLocationSearch)];
    topNavi.rightBarButtonItem = btn;
    
    lm = [[CLLocationManager alloc] init];
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    lm.distanceFilter = kCLDistanceFilterNone;
    [lm startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self didUpdateLocatoin:[locations lastObject]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self didUpdateLocatoin:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"ServiceObj.locationManager:didFailWithError: %d %@",error.code,error.localizedDescription);
}

- (void)didUpdateLocatoin:(CLLocation*)location {
    NSLog(@"緯度%f",location.coordinate.latitude);
    NSLog(@"経度%f", location.coordinate.longitude);
    
    NSArray* jigyoshoArray = [Jigyosho getJigyoshoList];
    
    for(int i=0;i<[jigyoshoArray count];i++){
        Jigyosho* jigyosho = [jigyoshoArray objectAtIndex:i];
        double distance = [self calculateDistance:location.coordinate.latitude fromlon:location.coordinate.longitude tolat:jigyosho.lat tolon:jigyosho.lon];
        
        NSLog(@"%@ : %f",jigyosho.name, distance);
        
        if(distance <= 500){
            fromjigyoshoid = jigyosho.jid;
            fromjigyoshoname.text = jigyosho.name;
            fromstation.text = jigyosho.moyorieki;
            fromtoho.text = [NSString stringWithFormat:@"%d",jigyosho.toho];
            
            // 自動設定した値を保存
            fromstationorg = fromstation.text;
            fromtohoorg = fromtoho.text;
            
            CGRect newRect = CGRectMake(240, searchlocationBtn.frame.origin.y,
                                        searchlocationBtn.frame.size.width, searchlocationBtn.frame.size.height);
            searchlocationBtn.frame = newRect;
            break;
        }
        
        if(i == [jigyoshoArray count]-1){
            if(fromjigyoshoid != NO_ID){
                fromjigyoshoid = NO_ID;
                fromjigyoshoname.text = @"";
                fromstation.text = @"";
                fromtoho.text = @"5";
            
                CGRect newRect = CGRectMake(110, searchlocationBtn.frame.origin.y,
                                        searchlocationBtn.frame.size.width, searchlocationBtn.frame.size.height);
                searchlocationBtn.frame = newRect;
            }
        }
    }
    
    [self stopLocationSearch];
}

- (void)stopLocationSearch {
    topNavi.rightBarButtonItem = nil;
    
    [lm stopUpdatingLocation];
    lm = nil;
    [MBProgressHUD hideAllHUDsForView:self.scrollView animated:YES];
}

- (double)calculateDistance:(double)fromlat fromlon:(double)fromlon tolat:(double)tolat tolon:(double)tolon {
    double diflat = (fromlat - tolat) * 1000 * 110.953;
    double diflon = (fromlon - tolon) * 1000 * 90.525;
    
    return sqrt( pow(diflat,2) + pow(diflon,2) );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self showDoneButton];
    
    // ScrollViewを大きくしてスクロールできるようにする
    CGSize size;
    // iPhone5対応
    if([UIScreen mainScreen].bounds.size.height == 568){
        size = CGSizeMake(320, 748);
    } else {
        size = CGSizeMake(320, 660);
    }
    scrollView.contentSize = size;
    
    // ちょうどいいところにスクロール
    if (textField == tostation && scrollView.contentOffset.y < 140.0f){
        [scrollView setContentOffset:CGPointMake(0.0f, 140.0f) animated:YES];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self hiddenDoneButton];
    
    if([fromtoho.text intValue] == 0){
        fromtoho.text = @"0";
    }
    
    return YES;
}

- (void)showDoneButton {
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"完了"
        style:UIBarButtonItemStylePlain target:self action:@selector(doneButton)];
    topNavi.rightBarButtonItem = btn;
}

- (void)hiddenDoneButton {
    topNavi.rightBarButtonItem = nil;
}

- (void)doneButton {
    [self endTextEdit];
}

- (void)endTextEdit {
    // ScrollViewのサイズを戻す
    CGSize size = CGSizeMake(320, 365);
    scrollView.contentSize = size;
    
    [fromstation endEditing:YES];
    [fromtoho endEditing:YES];
    [tostation endEditing:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    [self endTextEdit];

    NSString* segueStr = [segue identifier];
    SelectListController *controller = [segue destinationViewController];
    if ([segueStr isEqualToString:@"tojigyosho"] == YES) {
        controller.source = self;
        controller.selecttype = TO_JIGYOSHO;
    }
}

- (void)setToJigyosho:(Jigyosho*)jigyosho {
    tojigyoshoid = jigyosho.jid;
    tostation.text = jigyosho.moyorieki;
    tojigyoshoname.text = jigyosho.name;
    
    NSArray* routeArray = [Route getRouteList];
    
    for(int i=0;i<[routeArray count];i++){
        NSArray* routeSubArray = [routeArray objectAtIndex:i];
        for(int j=0;j<[routeSubArray count];j++){
            Route* route = [routeSubArray objectAtIndex:j];
            if(fromjigyoshoid == i && jigyosho.jid == j){
                tostation.text = route.tostation;
                
                NSLog(@"%d %d %@ %d %@",route.fromjid,route.tojid,route.fromstation,route.fromtoho,route.tostation);
                
                // 現在地の情報をユーザーが編集していなければ現在地も更新
                if([fromstationorg isEqualToString:fromstation.text] &&
                   [fromtohoorg isEqualToString:fromtoho.text]){
                    fromstation.text = route.fromstation;
                    fromtoho.text = [NSString stringWithFormat:@"%d",route.fromtoho];
                    
                    // 自動設定した値を保存
                    fromstationorg = fromstation.text;
                    fromtohoorg = fromtoho.text;
                }
            }
        }
    }
}

- (IBAction)searchlocationButton:(id)sender {
    [self locationSearch];
}

- (IBAction)searchButton:(id)sender {
    if([fromstation.text isEqualToString:@""] || [tostation.text isEqualToString:@""]){
        return;
    }
    
    [self endTextEdit];
    
    // 現在日時＋徒歩時間を取得
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:60*[fromtoho.text intValue]];
    NSDateComponents *dateComps
    = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:date];
    
    int year = dateComps.year;
    int month = dateComps.month;
    int day = dateComps.day;
    int hour = dateComps.hour;
    int minite = dateComps.minute;
    
    NSString* ym = [NSString stringWithFormat:@"%d%02d",year,month];
        
    NSString* fromUrlStr = [self encodeUrlString:fromstation.text];
    NSString* toUrlStr   = [self encodeUrlString:tostation.text];
    
    NSString* urlStr = [NSString stringWithFormat:@"http://transit.loco.yahoo.co.jp/search/result?from=%@&to=%@&ex=1&shin=0&hb=1&lb=1&al=1&sr=1&ym=%@&d=%d&hh=%d&m1=%d&m2=%d&type=1&ws=2&s=0&expkind=1&ost=0&ei=utf-8",fromUrlStr,toUrlStr,ym,day,hour,minite/10,minite%10];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
}

- (NSString*)encodeUrlString:(NSString*)sourceString {
    return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                        NULL,
                                                        (CFStringRef)sourceString,
                                                        NULL,
                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                        kCFStringEncodingUTF8 ));
    
    //decoding
//    NSString *decodedUrlString = (NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
//                                                                                                      NULL,
//                                                                                                      (CFStringRef) escapedUrlString,
//                                                                                                      CFSTR(""),
//                                                                                                      kCFStringEncodingUTF8);
}

- (void)viewDidUnload {
    [self setTopNavi:nil];
    [self setScrollView:nil];
    [self setFromjigyoshoname:nil];
    [self setFromtoho:nil];
    [self setTojigyoshoname:nil];
    [self setFromstation:nil];
    [self setTostation:nil];
    [self setSearchlocationBtn:nil];
    [super viewDidUnload];
}

@end
