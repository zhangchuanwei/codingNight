//
//  ViewController.m
//  pageView
//
//  Created by 张传伟 on 2018/7/4.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "ViewController.h"

#import "PagesViewController.h"
#import "MenuScrollView.h"
#define MainScreenWdith  [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<menuScrollviewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property(nonatomic,strong)MenuScrollView * menuScroll;
@property(nonatomic,strong)UIPageViewController *pageView;
    @property(nonatomic,strong)NSMutableArray *dataArray;

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
    
-(UIPageViewController *)pageView{
    
    if (_pageView == nil){
        
        _pageView = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:0 options:nil];
        _pageView.dataSource = self;
        _pageView.delegate = self;
    }
    return _pageView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles =@[@"科技",@"生活类",@"军事",@"农业",@"养殖",@"It",@"影视",@"动漫",@"历史科技"];
    self.menuScroll.titleArray = titles;
    [self.view addSubview:self.menuScroll];
    
    self.pageView.view.frame = CGRectMake(0, CGRectGetMaxY(self.menuScroll.frame), MainScreenWdith, MainScreenHeight - CGRectGetMaxY(self.menuScroll.frame));
    
    PagesViewController * model = [[PagesViewController alloc]init];
    //设置初始界面
    [_pageView setViewControllers:@[model] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    //设置是否双面展示
    _pageView.doubleSided = NO;
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:model];
    _pageView.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_pageView.view];

    
}
- (void)menuDidSelectBtnIndex:(NSInteger)index
{
    NSLog(@"当前选中的事第几个按钮%ld",index);
}

    
    
    //pageview 的代理方法
    - (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
        int index = (int)[_dataArray indexOfObject:viewController];
        if (index==0) {
            return nil;
        }else{
            return _dataArray[index-1];
        }
    }
    //翻页控制器进行向后翻页动作 这个数据源方法返回的视图控制器为要显示视图的视图控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    int index = (int)[_dataArray indexOfObject:viewController];
    if (index==9) {
        return nil;
    }else{
        if (_dataArray.count-1>=(index+1)) {
            return _dataArray[index+1];
        }else{
            PagesViewController * model = [[PagesViewController alloc]init];
            
            int R = (arc4random() % 256) ;
            int G = (arc4random() % 256) ;
            int B = (arc4random() % 256) ;

            model.view.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
            [_dataArray addObject:model];
            return model;
        }
    }
}

@end
