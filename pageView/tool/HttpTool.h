//
//  HttpTool.h
//  pageView
//
//  Created by 张传伟 on 2018/7/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^HttpSuccess)(id json);

typedef void(^HttpFailere)(NSError *error,NSInteger code);

@interface HttpTool : NSObject
//设置Manager的一些属性
//+(AFHTTPSessionManager *)getAFHTTPSessionManagerfuntion;


+ (void)getWithURL:(NSString *)url params:(NSMutableArray *)params success:(HttpSuccess)success failure:(HttpFailere)failure;
@end
