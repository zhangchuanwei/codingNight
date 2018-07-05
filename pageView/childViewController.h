//
//  childViewController.h
//  pageView
//
//  Created by 张传伟 on 2018/7/5.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface childViewController : UIViewController
+(childViewController *)creatWithIndex:(int)index;

@property(nonatomic,strong)UILabel * indexLabel;

@end
