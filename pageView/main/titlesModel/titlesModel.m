//
//  titlesModel.m
//  pageView
//
//  Created by 张传伟 on 2018/7/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "titlesModel.h"

@implementation titlesModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    else
    {
        [super setValue:value forKey:key];
    }
}
@end
