//
//  DiekCycleScrollView.h
//  循环滚动视图ScrollView
//
//  Created by chunfeng on 15/5/30.
//  Copyright (c) 2015年 chunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiekCycleBaseScrollView.h"
@class DiekCycleScrollView;

@protocol DiekCycleScrollViewDelegate <NSObject>

- (void)CycleScrollClickImagV:(NSDictionary *)gameDict;

@end

@interface DiekCycleScrollView : UIView
@property (nonatomic, weak) id<DiekCycleScrollViewDelegate> delegate;

@end
