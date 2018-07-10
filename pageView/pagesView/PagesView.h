//
//  PagesView.h
//  pageView
//
//  Created by 张传伟 on 2018/7/10.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PagesViewDelegate<NSObject>

-(void)PagesViewScrollToIndex:(NSInteger)index;
-(void)PagesScrollOffset:(CGFloat) offSetY;
@end

@interface PagesView : UIView
@property(nonatomic,strong)UIPageViewController *pageView;
@property(nonatomic,strong)NSArray * pages;
@property(nonatomic,weak)id<PagesViewDelegate> PagesDelsgate;

-(void)setUpPagesWithIndex:(NSInteger)index;
@end
