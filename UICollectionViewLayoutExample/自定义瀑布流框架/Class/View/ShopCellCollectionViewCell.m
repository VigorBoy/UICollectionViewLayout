//
//  ShopCellCollectionViewCell.m
//  自定义瀑布流框架
//
//  Created by    🐯 on 16/2/13.
//  Copyright © 2016年 张炫赫. All rights reserved.
//

#import "ShopCellCollectionViewCell.h"
#import "Shop.h"
#import "UIImageView+WebCache.h"
@interface ShopCellCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
@implementation ShopCellCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setShop:(Shop *)shop
{
    _shop=shop;
    
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.priceLabel.text = shop.price;
}
@end
