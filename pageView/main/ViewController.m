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
#import "titlesModel.h"
#define MainScreenWdith  [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<menuScrollviewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>
{
    NSInteger _currentIndex;
    
    UIViewController * _pengdingViewController;
}

@property(nonatomic,strong)UIScrollView *bgScroll;
@property(nonatomic,strong)MenuScrollView * menuScroll;
@property(nonatomic,strong)UIPageViewController *pageView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *titles;
@end

@implementation ViewController

-(UIScrollView *)bgScroll
{
    if (_bgScroll == nil) {
        _bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWdith, MainScreenHeight)];
        _bgScroll.delegate = self;
    }
    return  _bgScroll;
}
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
        
        for (int index = 0; index < self.titles.count; index ++) {
            childTableView *vc = [[childTableView alloc]init];
            vc.index = index ;
            [_dataArray addObject:vc];
        }
    }
    return _dataArray;
}

-(NSMutableArray *)titles
{
    if (_titles == nil) {
        
        _titles = [NSMutableArray arrayWithCapacity:0];
       
    }
    return _titles ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self.view addSubview:self.bgScroll];
    NSString *url =[NSString stringWithFormat:@"%@headline/tag",HOME_URL];
    [HttpTool getWithURL:url params:nil success:^(id json) {
        NSLog(@"json==%@",json);
        
        for (NSDictionary  * dic in json[@"content"]) {
            
            
            titlesModel *model = [[titlesModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.titles addObject:model];
        }
        
        [self setUpView];
        
    } failure:^(NSError *error, NSInteger code) {
        
    }] ;

}
-(void)setUpView
{
    self.menuScroll.titleArray = self.titles;
    [self.bgScroll addSubview:self.menuScroll];
    
    self.pageView.view.frame = CGRectMake(0, CGRectGetMaxY(self.menuScroll.frame), MainScreenWdith, MainScreenHeight - CGRectGetMaxY(self.menuScroll.frame));
    
    //设置初始界面
    [_pageView setViewControllers:@[self.dataArray[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    //设置是否双面展示
    _pageView.doubleSided = NO;
    
    _pageView.view.backgroundColor = [UIColor redColor];
    [self.bgScroll addSubview:_pageView.view];
    
}

- (void)menuDidSelectBtnIndex:(NSInteger)index
{
    NSLog(@"当前选中的事第几个按钮%ld",index);
    
//    [_pageView s]
    if (index < self.dataArray.count ) {
        
        if (index < _currentIndex) { //向左滑
            [_pageView setViewControllers:@[self.dataArray[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
            
        }else
        { // 向右滑
            
            [_pageView setViewControllers:@[self.dataArray[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
        _currentIndex = index ;
    }
  
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
