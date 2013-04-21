//
//  SelectListController.m
//  KaigiHeGo
//
//  Created by 藤原 達郎 on 2013/04/20.
//  Copyright (c) 2013年 Tatsuo Fujiwara. All rights reserved.
//

#import "SelectListController.h"
#import "Jigyosho.h"
#import "SearchInputController.h"

@interface SelectListController ()

@end

@implementation SelectListController

@synthesize source;
@synthesize selecttype;
@synthesize selectList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    selectList = [Jigyosho getJigyoshoList];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return selectList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SelectInputCell"];
    cell.textLabel.text = [[selectList objectAtIndex:indexPath.row] name];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"本社事業所%d",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Jigyosho* jigyosho = [selectList objectAtIndex:indexPath.row];
    
    [source setToJigyosho:jigyosho];
    
    [self dismissModalViewControllerAnimated:YES];
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
//    NSLog(@"sakujo");
//}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

- (IBAction)backButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];    
}

@end
