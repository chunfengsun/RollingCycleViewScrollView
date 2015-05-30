//
//  ViewController.m
//  循环滚动视图ScrollView
//
//  Created by chunfeng on 15/5/30.
//  Copyright (c) 2015年 chunfeng. All rights reserved.
//

#import "ViewController.h"
#import "DiekScrollAndPageView.h"

#import "DiekCycleScrollViewController.h"
#define NUM 5

@interface ViewController ()<DiekScrollAndPageViewDelegate>{
    DiekScrollAndPageView *_whView;
}


@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建view （view中包含UIScrollView、UIPageControl，设置frame）
    _whView = [[DiekScrollAndPageView alloc] initWithFrame:CGRectMake(0, 44, 320, 400)];
    
    //把N张图片放到imageview上
    NSMutableArray *tempAry = [NSMutableArray array];
    for (int i=1; i<NUM; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%i.jpg",i]];
        [tempAry addObject:imageView];
    }
    
    //把imageView数组存到whView里
    [_whView setImageViewAry:tempAry];
    
    //把图片展示的view加到当前页面
    [self.view addSubview:_whView];
    
    //开启自动翻页
    [_whView shouldAutoShow:YES];
    
    //遵守协议
    _whView.delegate = self;
}

#pragma mark 协议里面方法，点击某一页
-(void)didClickPage:(DiekScrollAndPageView *)view atIndex:(NSInteger)index
{
    NSLog(@"点击了第%li页",index);
}

#pragma mark 界面消失的时候，停止自动滚动
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_whView shouldAutoShow:NO];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_whView shouldAutoShow:YES];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (IBAction)clickPushBtn:(UIButton *)sender {
    DiekCycleScrollViewController *vc = [[DiekCycleScrollViewController alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
