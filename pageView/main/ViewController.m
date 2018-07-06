//
//  ViewController.m
//  pageView
//
//  Created by 张传伟 on 2018/7/4.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "ViewController.h"


#import "MenuScrollView.h"

#import "childTableView.h"
#import "childTableViewB.h"
#import "childTableViewC.h"
#import "childTableViewD.h"

#define MainScreenWdith  [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<menuScrollviewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    NSInteger _currentIndex;
    
    UIViewController * _pengdingViewController;
}
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
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
        childTableView *vc1 = [[childTableView alloc]init];
        childTableViewB *vc2 = [[childTableViewB alloc]init];
        childTableViewC *vc3 = [[childTableViewC alloc]init];
        childTableViewD *vc4 = [[childTableViewD alloc]init];
        
        [_dataArray addObject:vc1];
        [_dataArray addObject:vc2];
        [_dataArray addObject:vc3];
        [_dataArray addObject:vc4];
        
        
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles =@[@"科技",@"生活类",@"军事",@"农业",@"养殖",@"It",@"影视",@"动漫",@"历史科技"];
    self.menuScroll.titleArray = titles;
    [self.view addSubview:self.menuScroll];
    
    self.pageView.view.frame = CGRectMake(0, CGRectGetMaxY(self.menuScroll.frame), MainScreenWdith, MainScreenHeight - CGRectGetMaxY(self.menuScroll.frame));
    
    //设置初始界面
    [_pageView setViewControllers:@[self.dataArray[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    //设置是否双面展示
    _pageView.doubleSided = NO;

    _pageView.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_pageView.view];

    
}
- (void)menuDidSelectBtnIndex:(NSInteger)index
{
    NSLog(@"当前选中的事第几个按钮%ld",index);
}

    //pageview 的代理方法
    - (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
        
        NSInteger beforeIndex = _currentIndex - 1;
        //返回nil时禁止继续滑动
        if (beforeIndex < 0) return nil;
        
        return self.dataArray[beforeIndex];

    }
    //翻页控制器进行向后翻页动作 这个数据源方法返回的视图控制器为要显示视图的视图控制器
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger afterIndex = _currentIndex + 1;
    if (afterIndex > self.dataArray.count - 1) return nil;
    
    return self.dataArray[afterIndex];

}
#pragma mark - UIPageViewControllerDelegate
//跳转动画开始时触发，利用该方法可以定位将要跳转的界面
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    //pendingViewControllers虽然是一个数组，但经测试证明该数组始终只包含一个对象
    _pengdingViewController = pendingViewControllers.lastObject;
}
//跳转动画完成时触发，配合上面的代理方法可以定位到具体的跳转界面，此方法有利于定位具体的界面位置（childViewControllersArray），
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    //previousViewControllers虽然是一个数组，但经测试证明该数组始终只包含一个对象
    if (completed) {
        
        [self.dataArray enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (_pengdingViewController == obj) {
                
                _currentIndex = idx;
                
                
                [self.menuScroll selectBtnWithindex:idx];
                
            }
        }];

    }
}


@end
