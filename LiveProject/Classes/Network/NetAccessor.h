//
//  NetAccessor.h
//  NetRequestEncapsulation
//
//  Created by dd on 16/5/19.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <AFNetworking/AFNetworking.h>

//连接状态
typedef enum {
    ///返回数据正确
    Enum_SUCCESS = 0,
    ///返回数据出错
    Enum_FAIL = 1,
    ///连接不上服务器
    Enum_NOTCONNECTED = 2,
    ///超时连接
    Enum_CONNECTEDTIMEOUT = 3
} EnumServerStatus;

typedef void (^FinishedBlock)(EnumServerStatus status, id object);
typedef void (^ProgressBlock)(NSProgress *taskProgress);


@interface NetAccessor : NSObject

+ (instancetype)sharedInstance;

- (void)sendPostObjectFormUrl:(NSString *)urlStr
                   parameters:(id)parameters
                     progress:(ProgressBlock)progress
                     finished:(FinishedBlock)finished;

- (void)sendImageFormUrl:(NSString *)urlStr
                filePath:(UIImage *)image
              parameters:(id)parameters
                 process:(ProgressBlock)progress
                finished:(FinishedBlock)finished;

- (void)sendGetObjectFormUrl:(NSString *)urlStr
                  parameters:(id)parameters
                connectClass:(Class)Class
                    progress:(ProgressBlock)progress
                    finished:(FinishedBlock)finished;

@end
