//
//  DiekScrollAndPageView.h
//  循环滚动视图ScrollView
//
//  Created by chunfeng on 15/5/30.
//  Copyright (c) 2015年 chunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DiekScrollAndPageViewDelegate;

@interface DiekScrollAndPageView : UIView <UIScrollViewDelegate>
{
    __unsafe_unretained id <DiekScrollAndPageViewDelegate> _delegate;
}

@property (nonatomic, assign) id <DiekScrollAndPageViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;

-(void)shouldAutoShow:(BOOL)shouldStart;

@end

@protocol DiekScrollAndPageViewDelegate <NSObject>

@optional
- (void)didClickPage:(DiekScrollAndPageView *)view atIndex:(NSInteger)index;

@end

