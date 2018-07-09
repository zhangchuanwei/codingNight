//
//  NewsModel.h
//  pageView
//
//  Created by 张传伟 on 2018/7/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property(nonatomic,copy)NSString * banner;
@property(nonatomic,copy)NSString * createTime;
@property(nonatomic,copy)NSString * ID;
@property(nonatomic,copy)NSString * intro;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * browseCount;
@property(nonatomic,strong)NSArray *tags;
@end
