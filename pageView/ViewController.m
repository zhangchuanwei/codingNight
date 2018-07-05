//
//  ViewController.m
//  pageView
//
//  Created by 张传伟 on 2018/7/4.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "ViewController.h"
#import "childViewController.h"

#import "MenuScrollView.h"
#define MainScreenWdith  [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<menuScrollviewDelegate>
@property(nonatomic,strong)MenuScrollView * menuScroll;
@end

@implementation ViewController


- (MenuScrollView *)menuScroll
{
    if (_menuScroll == nil) {
        _menuScroll = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 50, MainScreenWdith, 44)];
        _menuScroll.Delegate = self ;//当前的类来遵循代理
    }
    return _menuScroll;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles =@[@"科技",@"生活类",@"军事",@"农业",@"养殖",@"It",@"影视",@"动漫",@"历史科技"];
    self.menuScroll.titleArray = titles;
    [self.view addSubview:self.menuScroll];
    
}
- (void)menuDidSelectBtnIndex:(NSInteger)index
{
    NSLog(@"当前选中的事第几个按钮%ld",index);
}


@end
