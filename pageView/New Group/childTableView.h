//
//  childTableView.h
//  pageView
//
//  Created by 张传伟 on 2018/7/6.
//  Copyright © 2018年 张传伟. All rights reserved.
//
typedef void(^ScrollViewOffSet)(CGFloat offSet);
#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
@interface childTableView : UITableViewController
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)ScrollViewOffSet scrollViewOffSet;
@end
