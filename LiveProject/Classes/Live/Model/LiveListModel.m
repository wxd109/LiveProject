//
//  LiveListModel.m
//  LiveProject
//
//  Created by dd on 7/12/16.
//  Copyright © 2016 dd. All rights reserved.
//

#import "LiveListModel.h"

@implementation LiveListModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data":[Data class]};
}

@end


@implementation Recommend

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data":[RecommendData class]};
}

@end


@implementation Data

@end


@implementation Link_Object

@end


@implementation RecommendData

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end



