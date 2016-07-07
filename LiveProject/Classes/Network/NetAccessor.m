//
//  NetAccessor.m
//  NetRequestEncapsulation
//
//  Created by dd on 16/5/19.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "NetAccessor.h"

@implementation NetAccessor

+ (instancetype)sharedInstance
{
    static NetAccessor *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)sendPostObjectFormUrl:(NSString *)urlStr parameters:(id)parameters progress:(ProgressBlock)progress finished:(FinishedBlock)finished
{
    NSString *partURL = [@"" stringByAppendingString:@""];
    NSString *URLString = [partURL stringByAppendingPathComponent:urlStr];
    if (parameters) {
        
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/xml",@"text/html",@"application/x-www-form-urlencoded",@"application/json", @"text/json", @"text/javascript",@"charset=UTF-8", nil];
    manager.requestSerializer.timeoutInterval = 20.0;
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(Enum_SUCCESS,responseObject);
        [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finished(Enum_FAIL,error);
        [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
    }];
}

- (void)sendImageFormUrl:(NSString *)urlStr filePath:(UIImage *)image parameters:(id)parameters process:(ProgressBlock)progress finished:(FinishedBlock)finished
{
    NSString *partURL = [@"" stringByAppendingString:@""];
    NSString *URLString = [partURL stringByAppendingString:urlStr];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html"@"charset=utf-8",@"application/json", nil];
    manager.requestSerializer.timeoutInterval = 20.0;
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image, 0.2);
        [formData appendPartWithFileData:data name:@"" fileName:@"" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(Enum_SUCCESS,responseObject);
        [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finished(Enum_FAIL,error);
        [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
    }];
}


- (NSURLSessionUploadTask *)uploadTaskWithImage:(UIImage *)image formUrl:(NSString *)urlStr completion:(void(^)(NSURLResponse *response,id responseObject, NSError *error)) completionBlock {
    NSError *error = NULL;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"someFileName" mimeType:@"image/png"];
    } error:&error];
    
    //配置验证信息
    
    AFURLSessionManager *manege = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask = [manege uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
    } completionHandler:completionBlock];
    
    return uploadTask;
}

- (void)sendImagesFormurl:(NSString *)urlStr files:(NSArray *)images parameters:(id)parameters process:(ProgressBlock)progress finished:(FinishedBlock)finished
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:images.count];
    dispatch_group_t group = dispatch_group_create();
    
    double processBase = 1.0f/images.count;
    for (int i = 0; i < images.count; i++) {
        dispatch_group_enter(group);
        
        NSURLSessionUploadTask *uploadTask = [self uploadTaskWithImage:images[i] formUrl:urlStr  completion:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"第 %d 张图片上传失败: %@",i + 1,error);
                dispatch_group_leave(group);
            } else {
                NSLog(@"第 %d 张图片上传成功: %@",i + 1,responseObject);
                @synchronized (result) {
                    result[i] = responseObject;
                }
                dispatch_group_leave(group);
            }
        }];
        [uploadTask resume];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"上传完成");
        finished(Enum_SUCCESS,result);
        for (id response in result) {
            NSLog(@"%@",response);
        }
    });
}

@end
