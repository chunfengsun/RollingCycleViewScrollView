//
//  DiekCycleScrollViewController.m
//  循环滚动视图ScrollView
//
//  Created by chunfeng on 15/5/30.
//  Copyright (c) 2015年 chunfeng. All rights reserved.
//

#import "DiekCycleScrollViewController.h"
#import "DiekCycleScrollView.h"



@interface DiekCycleScrollViewController ()
@property (nonatomic, strong) DiekCycleScrollView *scrollView;
@end

@implementation DiekCycleScrollViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _scrollView  = [[DiekCycleScrollView alloc] initWithFrame:CGRectMake(0, 70, KScreenWidth, 180)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
