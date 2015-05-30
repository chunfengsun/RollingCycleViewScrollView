//
//  DiekCycleScrollView.m
//  循环滚动视图ScrollView
//
//  Created by chunfeng on 15/5/30.
//  Copyright (c) 2015年 chunfeng. All rights reserved.
//
#define KheardCellHeight 170

#import "DiekCycleScrollView.h"

@interface DiekCycleScrollView(){
    float _viewWidth;
    float _viewHeight;
}
@property (nonatomic , strong) DiekCycleBaseScrollView *heardScorllView;



@end

@implementation DiekCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _viewWidth = self.bounds.size.width;
        _viewHeight = self.bounds.size.height;
        
        self.backgroundColor = [UIColor grayColor];
        self.heardScorllView = [[DiekCycleBaseScrollView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight) animationDuration:2];
        
        self.heardScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
        [self addSubview:_heardScorllView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(distantFutureTimer:) name:@"distantFutureTimer" object:nil];
        
        [self initWithCellModelDict:nil];
    }
    return self;
}



- (void)distantFutureTimer:(NSNotification *)fication{
    NSString *str = fication.object;
    if (_heardScorllView) {
        if ([str isEqualToString:@"1"]) {
            
            [_heardScorllView.animationTimer setFireDate:[NSDate date]]; //继续。
        }else if ([str isEqualToString:@"2"]){
            
            [_heardScorllView.animationTimer setFireDate:[NSDate distantFuture]];
        }
    }
    
}

- (void)initWithCellModelDict:(NSArray *)arr{
    
    NSMutableArray *viewsArray = [NSMutableArray array];
    
    for (int i = 1; i < 5; ++i) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%i.jpg",i]];

//        [imgView sd_setImageWithURL:[NSURL URLWithString:arr[i][@"image"]] placeholderImage:[UIImage imageNamed:@"zhan2"]];
        
        [viewsArray addObject:imgView];
    }
    
    self.heardScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    
    self.heardScorllView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };
    __weak DiekCycleScrollView * mySelf = self;
    self.heardScorllView.TapActionBlock = ^(NSInteger pageIndex){
        //        DebugLog(@"点击了第%ld个",pageIndex);
        
        if ([mySelf.delegate respondsToSelector:@selector(CycleScrollClickImagV:)]) {
            NSDictionary *dict = arr[pageIndex];
            [mySelf.delegate CycleScrollClickImagV:dict];
        }
        
    };
    [self addSubview:self.heardScorllView];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"distantFutureTimer" object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
