//
//  HttpRequestModel.m
//  mike2.0
//
//  Created by 佐毅 on 15/9/15.
//  Copyright (c) 2015年 上海乐住信息技术有限公司. All rights reserved.
//

#import "HttpRequest.h"
#import "AFSecurityPolicy.h"
@implementation HttpRequest

#pragma mark - Life cycle

- (void)dealloc {
    _urlString=nil;
    _parameters=nil;
}

+ (instancetype)request{
    return [[self alloc]init];
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _parameters = [[NSMutableDictionary alloc] init];
        [_parameters setObject:@"4" forKey:@"callmethod"];
        [_parameters setObject:[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"callversion"];
    }
    return (self);
}


#pragma mark 检测网路状态
+ (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld", status);
    }];
}

#pragma mark - Public Method

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                        hud:(MBProgressHUD *)hud
                                    success:(HttpRequestPostSuccessBlock)success
                                    failure:(HttpRequestPostFailureBlock)failure
                                  allFinish:(HttpRequestPostAllFinishBlock)finish{

 
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    securityPolicy.allowInvalidCertificates = YES; //还是必须设成YES

    
    //显示
    if (hud!=nil) {
        [hud show:YES];
    }
    AFHTTPRequestOperation *operation = [requestOperationManager
         POST:[NSString stringWithFormat:@"%@%@", @"ksfjlasjfk",_urlString]
         parameters:_parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //获取服务器时间
                         //上报
             int code;
             if ([[responseObject objectForKey:@"success"]boolValue]) {
                 code=200;
             }else{
                 code=[[responseObject objectForKey:@"errcode"]intValue];
             }
           
             //成功
             if (success!=nil) {
                 success([self parseData:responseObject]);
             }
             //结束
             if (requestOperationManager.operationQueue.operations.count==0){
                 if (finish!=nil) {
                     finish();
                 }
             }
             //隐藏
             if (hud!=nil) {
                 [hud hide:NO];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
             //隐藏
             if (hud!=nil) {
                 [hud hide:NO];
             }

             //失败
             if (failure!=nil) {
                 failure(operation,error);
             }
         }];
    return (operation);
}


#pragma mark - get方式获取数据
- (void)requestDataWithUrl:(NSString *)urlStr success:(void (^)(id data))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
    }];
}

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                    success:(HttpRequestPostSuccessBlock)success
                                    failure:(HttpRequestPostFailureBlock)failure
                                  allFinish:(HttpRequestPostAllFinishBlock)finish{
    return [self postWithManager:requestOperationManager hud:nil success:success failure:failure allFinish:finish];
}

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                        hud:(MBProgressHUD *)hud
                                    success:(HttpRequestPostSuccessBlock)success
                                  allFinish:(HttpRequestPostAllFinishBlock)finish{
    return [self postWithManager:requestOperationManager hud:hud success:success failure:nil allFinish:finish];
}

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                        hud:(MBProgressHUD *)hud
                                    success:(HttpRequestPostSuccessBlock)success
                                    failure:(HttpRequestPostFailureBlock)failure{
    return [self postWithManager:requestOperationManager hud:hud success:success failure:failure allFinish:nil];
}

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                    success:(HttpRequestPostSuccessBlock)success
                                    failure:(HttpRequestPostFailureBlock)failure{
    return [self postWithManager:requestOperationManager hud:nil success:success failure:failure allFinish:nil];
}

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                    success:(HttpRequestPostSuccessBlock)success
                                  allFinish:(HttpRequestPostAllFinishBlock)finish{
    return [self postWithManager:requestOperationManager hud:nil success:success failure:nil allFinish:finish];
}

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                        hud:(MBProgressHUD *)hud
                                    success:(HttpRequestPostSuccessBlock)success{
    return [self postWithManager:requestOperationManager hud:hud success:success failure:nil allFinish:nil];
}

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                    success:(HttpRequestPostSuccessBlock)success{
    return [self postWithManager:requestOperationManager hud:nil success:success failure:nil allFinish:nil];
}

-(id)parseData:(id)originalData{
    // subClass
    return originalData;
}

@end
