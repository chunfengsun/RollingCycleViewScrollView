//
//  DiekCycleScrollView.h
//  循环滚动视图ScrollView
//
//  Created by chunfeng on 15/5/30.
//  Copyright (c) 2015年 chunfeng. All rights reserved.
//


#import <UIKit/UIKit.h>
//获取屏幕宽度
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
//获取屏幕高度
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
// 获得RGB颜色
#define UIColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface DiekCycleBaseScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
@property (nonatomic , strong) NSTimer *animationTimer;

/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

@end