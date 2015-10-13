//
//  HttpRequestModel.h
//  mike2.0
//
//  Created by 佐毅 on 15/9/15.
//  Copyright (c) 2015年 上海乐住信息技术有限公司. All rights reserved.
//

#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "NSMutableDictionary+Safe.h"

typedef void(^HttpRequestPostSuccessBlock)(id responseObject);
typedef void(^HttpRequestPostFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void(^HttpRequestPostAllFinishBlock)();

@interface HttpRequest : NSObject

/**
 *  @brief  初始化
 */
+ (instancetype)request;

/**
 *  @brief  发起请求的网络地址
 */
@property (strong, nonatomic) NSString *urlString;

/**
 *  @brief  发起请求的参数键值对
 */
@property (strong, nonatomic) NSMutableDictionary *parameters;

/**
 *  @brief  Post请求
 */

- (void)requestDataWithUrl:(NSString *)urlStr success:(void (^)(id data))success fail:(void (^)())fail;


- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                        hud:(MBProgressHUD *)hud
                                    success:(HttpRequestPostSuccessBlock)success
                                    failure:(HttpRequestPostFailureBlock)failure
                                  allFinish:(HttpRequestPostAllFinishBlock)finish;

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                    success:(HttpRequestPostSuccessBlock)success
                                    failure:(HttpRequestPostFailureBlock)failure
                                  allFinish:(HttpRequestPostAllFinishBlock)finish;

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                        hud:(MBProgressHUD *)hud
                                    success:(HttpRequestPostSuccessBlock)success
                                  allFinish:(HttpRequestPostAllFinishBlock)finish;

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                        hud:(MBProgressHUD *)hud
                                    success:(HttpRequestPostSuccessBlock)success
                                    failure:(HttpRequestPostFailureBlock)failure;

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                    success:(HttpRequestPostSuccessBlock)success
                                    failure:(HttpRequestPostFailureBlock)failure;

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                    success:(HttpRequestPostSuccessBlock)success
                                  allFinish:(HttpRequestPostAllFinishBlock)finish;

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                        hud:(MBProgressHUD *)hud
                                    success:(HttpRequestPostSuccessBlock)success;

- (AFHTTPRequestOperation *)postWithManager:(AFHTTPRequestOperationManager *)requestOperationManager
                                    success:(HttpRequestPostSuccessBlock)success;
/**检测网路状态**/
+ (void)netWorkStatus;

/**
 *  @brief  数据解析
 */
- (id)parseData:(id)originalData;

@end
