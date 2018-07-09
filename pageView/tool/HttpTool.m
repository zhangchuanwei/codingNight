//
//  HttpTool.m
//  pageView
//
//  Created by 张传伟 on 2018/7/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool
+ (void)getWithURL:(NSString *)url params:(NSMutableArray *)params success:(HttpSuccess)success failure:(HttpFailere)failure{
    
    NSString *urlS = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager  = [self getAFHTTPSessionManagerfuntion];
    
    [manager GET:urlS parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error,error.code);
        }
    }];
    
}


+ (AFHTTPSessionManager *)getAFHTTPSessionManagerfuntion{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    //解析加密的HTTPS网络请求数据
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.securityPolicy.validatesDomainName = NO;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html; charset=utf-8",@"text/css",nil]];
    // 头部传值
    [manager.requestSerializer setValue:@"KEY 7367d114-2838-43bf-8b5a-a5e960908ae9" forHTTPHeaderField:@"Authorization"];
    
    return manager;
}

@end
