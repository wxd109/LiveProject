//
//  LiveViewCell.m
//  LiveProject
//
//  Created by dd on 7/11/16.
//  Copyright © 2016 dd. All rights reserved.
//

#import "LiveViewCell.h"
#import "LiveListModel.h"

@implementation LiveViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headView.layer.cornerRadius  = self.headView.height * 0.5;
    self.headView.layer.masksToBounds = YES;
    self.headView.layer.borderWidth   = 1;
    self.headView.layer.borderColor   = [UIColor whiteColor].CGColor;
}

- (void)setLiveData:(Data *)liveData
{
    _liveData = liveData;
    self.anchorName.text = liveData.nick;
    self.anchorDescribe.text = liveData.title;
    [self.liveImage sd_setImageWithURL:[NSURL URLWithString:liveData.thumb] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.liveImage.image = image;
    }];
    [self.headView sd_setImageWithURL:[NSURL URLWithString:liveData.avatar] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1];
        self.headView.image = image;
    }];
}

@end
