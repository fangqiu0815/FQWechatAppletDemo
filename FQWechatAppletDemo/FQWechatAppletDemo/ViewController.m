//
//  ViewController.m
//  FQWechatAppletDemo
//
//  Created by mac on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>
#import "FQWechatAppletDemo-Swift.h"

@interface ViewController ()<MenuViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong) MenuView *menuView;
@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"仿微信小程序";
    self.menuView = [[MenuView alloc]init];
    self.menuView.delegate = self;
    self.menuView.backgroundColor = [UIColor whiteColor];
    self.menuView.contentView = self.collectionView;
    [self.tableView addSubview:self.menuView];
    
    //添加个上拉刷新控件
    __weak __typeof(self)weakSelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView.mj_footer endRefreshing];
            });
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

static NSString *identifier = @"cell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell===%ld",(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row%2 == 0) {
        [self.menuView setContentHeight:260];
    } else {
        [self.menuView setContentHeight:130];
    }
}

///在这里处理上拉刷新能不能显示
- (void)menuWithStatusChanged:(BOOL)status{
    self.tableView.mj_footer.hidden = status;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuItem" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

///初始化collectionView
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 80);
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor lightGrayColor];
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"menuItem"];
        _collectionView = collectionView;
    }
    
    return _collectionView;
}


@end
