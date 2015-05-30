//
//  DiekCycleScrollView.m
//  循环滚动视图ScrollView
//
//  Created by chunfeng on 15/5/30.
//  Copyright (c) 2015年 chunfeng. All rights reserved.
//

#import "DiekCycleBaseScrollView.h"
#import "NSTimer+Addition.h"

@interface DiekCycleBaseScrollView () <UIScrollViewDelegate>
{
    UIPageControl *_pageControl;
    float _viewWidth;
    float _viewHeight;

}

@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;


@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation DiekCycleBaseScrollView

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{


    _totalPageCount = totalPagesCount();
    
    _pageControl.numberOfPages = _totalPageCount; // 一共显示多少个圆点（多少页）

    
    if (_totalPageCount > 0) {
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    
//    LOGRECT(frame);
    
    // 添加PageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    //设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = UIColorRGB(253, 98, 42);
    pageControl.pageIndicatorTintColor = UIColorRGB(189, 189, 189);
//    // 设置非选中页的圆点颜色
//    pageControl.pageIndicatorTintColor = [UIColor redColor];
//    // 设置选中页的圆点颜色
//    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    // 禁止默认的点击功能
    pageControl.enabled = NO;
    _pageControl = pageControl;

    _pageControl.center = CGPointMake(frame.size.width * 0.5, frame.size.height - 10);
    _pageControl.bounds = CGRectMake(0, 0, 150, 50);
    
    [self addSubview:pageControl];

    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _viewWidth = self.bounds.size.width;
        _viewHeight = self.bounds.size.height;
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
    }
    return self;
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
//        DebugLog(@"next，当前页:%ld",self.currentPageIndex);
        _pageControl.currentPage = self.currentPageIndex;

        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
//        DebugLog(@"previous，当前页:%ld",self.currentPageIndex);
        _pageControl.currentPage = self.currentPageIndex;

        [self configContentViews];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    
//    if (self.scrollView.contentOffset.x != KScreenWidth) {
//        
//    }
    
    CGPoint newOffset = CGPointMake(_viewWidth + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
