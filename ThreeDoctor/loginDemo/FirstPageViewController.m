//
//  FirstPageViewController.m
//  ThreeDoctor
//
//  Created by 若义张 on 16/1/27.
//  Copyright © 2016年 若义张. All rights reserved.
//

#import "FirstPageViewController.h"
#import "CircleImageButtonView.h"
#import "FirstPageCollectionViewCell.h"

@interface FirstPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configVC];
    [self layoutUI];
}


- (void)configVC {
    
    [self.view setBackgroundColor:[UIColor blueColor]];
    self.myTitle = @"首页";
    [self setLeftItemWithImage:[UIImage imageNamed:@"我的"] andSelectImage:nil];
    [self setRightItemWithImage:[UIImage imageNamed:@"消息提醒"] andSelectImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = UICOLOR(19, 93, 219, 1);
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"今日入组",@"今日复诊",@"更换处方",@"建议转诊",@"控制不佳",@"我的关注",@"所有患者",@"我的社区", nil];
    
}

- (void)layoutUI {
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgView.image = [UIImage imageNamed:@"首页背景"];
    [self.view addSubview:bgView];
    
    UICollectionViewFlowLayout * flowlayout = [[UICollectionViewFlowLayout alloc]init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //初始化collectionView控件
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/6.0, 64*SCREEN_WIDTH/464, SCREEN_WIDTH*2/3.0, SCREEN_HEIGHT - 64) collectionViewLayout:flowlayout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.collectionView registerClass:[FirstPageCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    
    for (int i = 1; i < 4; i ++) {
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*SCREEN_WIDTH/3.5 + (i -2)*10, SCREEN_WIDTH, 1)];
        if (SCREEN_WIDTH == 320) {
            lineImageView.frame = CGRectMake(0, i*SCREEN_WIDTH/4.0 + (i -1 )*10, SCREEN_WIDTH, 1);
        }
        lineImageView.backgroundColor = [UIColor whiteColor];
        lineImageView.alpha = 0.7;
        [self.collectionView addSubview:lineImageView];
    }
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.collectionView.frame.size.width/2.0 - 0.5, 0, 1, SCREEN_WIDTH/3.5 * 4 + 10)];
    lineImageView.backgroundColor = [UIColor whiteColor];
    lineImageView.alpha = 0.7;
    [self.collectionView addSubview:lineImageView];


}

- (void)leftItemMethod {
    AppDelegate *appdelegate = APP_DELEGATE;
    [appdelegate.LeftSlideVC openLeftView];
}

- (void)rightItemMethod:(UIButton *)button {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"还没有开发" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark - UICollectionViewDataSource
//cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio{
    return self.dataArray.count/2;
}
//section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"UICollectionViewCell";
    FirstPageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.dataArray[indexPath.row + indexPath.section * 4]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (SCREEN_WIDTH == 320) {
        return CGSizeMake(SCREEN_WIDTH/4.0, SCREEN_WIDTH/4.0);
    }
    return CGSizeMake(SCREEN_WIDTH/4.0, SCREEN_WIDTH/3.5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
