//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "otherViewController.h"
#import "YZUserinfoViewController.h"
#import "YZLoginModel.h"
#import "YZHLLoginViewController.h"

@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource> {
    UIButton *_logoutButton;
}
@property (nonatomic, strong) NSArray *rowArray;
@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSelf];
    [self layoutUI];
}

- (void)configSelf {
    [self.view setBackgroundColor:UICOLOR(19, 93, 219, 1)];
    self.rowArray = @[@"个人信息"];
}

- (void)layoutUI {
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"首页背景"];
    [self.view addSubview:imageview];
    
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = self.rowArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    otherViewController *vc = [[otherViewController alloc] init];
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    
    [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self getHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logoutButton.frame = CGRectMake(0, 0, self.tableview.bounds.size.width, 60);
    _logoutButton.backgroundColor = [UIColor clearColor];
    [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if ([[[NSUserDefaults standardUserDefaults] deviceToken] isEqualToString:@""]) {
        [_logoutButton setTitle:@"登录" forState:UIControlStateNormal];
    }else {
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    }
    [_logoutButton addTarget:self action:@selector(logoutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    return _logoutButton;
}

- (UIView *)getHeaderView {
    CGFloat viewWidth = self.tableview.bounds.size.width , viewHeight = SCREEN_HEIGHT*2/7;
    CGFloat leftDistance = 20.0;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    view.backgroundColor = [UIColor lightTextColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick)];
    [view addGestureRecognizer:tap];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(leftDistance, viewHeight/2.0 - 40, 40, 40)];
    logoView.layer.masksToBounds = YES;
    logoView.layer.cornerRadius = 20;
    logoView.backgroundColor = [UIColor redColor];
    [view addSubview:logoView];
    
    RYLable *userNameLable = [[RYLable alloc] initWithFrame:CGRectMake(leftDistance + 40 + 10, viewHeight/2.0 - 27, viewWidth - leftDistance - 50, 20) titleText:[[NSUserDefaults standardUserDefaults] userName] textColor:[UIColor grayColor] textFont:[UIFont systemFontOfSize:14] lineSpace:0 autoHeight:NO];
    [view addSubview:userNameLable];
    
    return view;
}

- (void)logoutButtonClick {
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    if ([_logoutButton.titleLabel.text isEqualToString:@"登录"]) {
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        YZHLLoginViewController *vc = [[YZHLLoginViewController alloc] init];
        [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
    }else {
        [YZLoginModel logoutSuccess:^(BOOL success) {
            if (success) {
                [RYToastHelp showSVProgressWithSuccess:@"退出登录成功"];
                [_logoutButton setTitle:@"登录" forState:UIControlStateNormal];
                [[NSUserDefaults standardUserDefaults]setDeviceToken:@""];
                YZHLLoginViewController *vc = [[YZHLLoginViewController alloc] init];
                [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];

            }else {
                [RYToastHelp showSVProgressWithSuccess:@"退出登录失败"];
            }
        } failure:^{
            [RYToastHelp showSVProgressWithSuccess:@"退出登录失败"];
        }];
    }
}

- (void)headerClick {
    NSLog(@"headerClick === ");
    YZUserinfoViewController *userVC = [[YZUserinfoViewController alloc] init];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    
    [tempAppDelegate.mainNavigationController pushViewController:userVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
