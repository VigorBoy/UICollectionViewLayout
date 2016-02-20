# UICollectionViewLayout
一个自定义瀑布流框架 

## 绑定代理方法 
## 显示Cell的高度 
```objc
	- (CGFloat)waterflowLayout:(WaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
```

## 每一行之间的距离 默认显示 10
```objc
  - (CGFloat)rowMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
```
## 每一列之间的距离 默认显示10
```objc
	- (CGFloat)columnMarginInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
```
## 显示多少列 默认显示3
```objc
  - (CGFloat)columnCountInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
```
## 边缘距离 UIEdgeInsets 默认｛10, 10, 10, 10｝
```objc
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterflowLayout *)waterflowLayout;
```
