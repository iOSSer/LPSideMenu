//
//  LeftViewController.m
//  LPSideMenuDemo
//
//  Created by MacBook on 15/8/26.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController
{
    NSArray *modules;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Left";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    modules = [NSArray arrayWithObjects:@"我的相册", @"我的收藏", @"我的电脑", @"设置", nil];
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    table.tableFooterView = [UIView new];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"1"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return modules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
    cell.textLabel.text = modules[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.menu showLeft:NO];
    if (indexPath.row == 0) {
        SecondViewController *second = [[SecondViewController alloc] init];
        LPSideMenu *menu = (LPSideMenu *)delegate.window.rootViewController;
        if ([menu.contentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navContent = (UINavigationController *)menu.contentViewController;
            [navContent pushViewController:second animated:YES];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
