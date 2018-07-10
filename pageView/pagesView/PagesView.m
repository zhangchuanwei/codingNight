//
//  PagesView.m
//  pageView
//
//  Created by 张传伟 on 2018/7/10.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "PagesView.h"
#import "childTableView.h"
@interface PagesView ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    NSInteger _currentIndex;
    
    UIViewController * _pengdingViewController;
}
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation PagesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageView.view.frame = frame;
        [self addSubview:self.pageView.view];
        
    }
    return self;
}
-(UIPageViewController *)pageView{
    
    if (_pageView == nil){
        _pageView = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:0 options:nil];
        //设置是否双面展示
        _pageView.doubleSided = NO;
        _pageView.dataSource = self;
        _pageView.delegate = self;
        
    }
    return _pageView;
    
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
-(void)setPages:(NSArray *)pages
{
    _pages = pages;
    
    for (int index = 0; index < self.pages.count; index ++) {
        childTableView *vc = [[childTableView alloc]init];
        typeof(self) weakSelf = self;
        vc.scrollViewOffSet = ^(CGFloat offSet) {
//            NSLog(@"block中的offSet==%f",offSet);
            if (weakSelf.PagesDelsgate) {
                
                [weakSelf.PagesDelsgate respondsToSelector:@selector(PagesViewScrollToIndex:)];
                
                [weakSelf.PagesDelsgate PagesScrollOffset:offSet];
            }
        };
        vc.index = index ;
        [self.dataArray addObject:vc];
    }
    [_pageView setViewControllers:@[self.dataArray[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
}
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
            if (self->_pengdingViewController == obj) {
                self->_currentIndex = idx;
//                [self.menuScroll selectBtnWithindex:idx];  这里用个代理传出去
                [self.PagesDelsgate respondsToSelector:@selector(PagesViewScrollToIndex:)];
                [self.PagesDelsgate PagesViewScrollToIndex:idx];
            }
        }];
    }
}

-(void)setUpPagesWithIndex:(NSInteger)index
{
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
@end
