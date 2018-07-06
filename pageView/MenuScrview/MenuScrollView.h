//
//  MenuScrollView.h
//  pageView
//
//  Created by 张传伟 on 2018/7/5.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol menuScrollviewDelegate<NSObject>

-(void)menuDidSelectBtnIndex:(NSInteger)index;

@end


@interface MenuScrollView : UIScrollView
-(void)selectBtnWithindex:(NSInteger)index;
@property(nonatomic,strong)NSArray * titleArray ;

@property(nonatomic,weak)id<menuScrollviewDelegate> Delegate;
@end
