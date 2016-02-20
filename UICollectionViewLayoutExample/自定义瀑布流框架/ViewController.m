//
//  ViewController.m
//  自定义瀑布流框架
//
//  Created by    🐯 on 16/2/13.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import "ViewController.h"
#import "WaterflowLayout.h"
#import "ShopCellCollectionViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "Shop.h"

@interface ViewController ()<UICollectionViewDataSource, XMGWaterflowLayoutDelegate>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

static NSString * const XMGShopId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    [self setupRefresh];
}

- (void)setupLayout
{
    // 创建布局
    WaterflowLayout *layout = [[WaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCellCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:XMGShopId];
    
    self.collectionView = collectionView;
}

- (void)setupRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.header beginRefreshing];
    
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.footer.hidden = YES;
}

- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [Shop objectArrayWithFilename:@"1.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.header endRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [Shop objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.footer endRefreshing];
    });
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMGShopId forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}

#pragma mark - <XMGWaterflowLayoutDelegate>
-(CGFloat)waterflowLayout:(WaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    Shop *shop=self.shops[index];
    return itemWidth*shop.h/shop.w;
}

//每一行之间的距离
//-(CGFloat)rowMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout
//{
//    return 10;
//}

//默认的列数
//-(CGFloat)columnCountInWaterflowLayout:(WaterflowLayout *)waterflowLayout
//{
//    return 3;
//}

//边缘距离
//-(UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterflowLayout *)waterflowLayout
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}

//每一列之间的间距
//-(CGFloat)columnMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout
//{
//    return 10;
//}
@end
