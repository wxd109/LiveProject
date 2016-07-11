//
//  LiveFlowLayout.m
//  LiveProject
//
//  Created by dd on 16/7/8.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "LiveFlowLayout.h"

@implementation LiveFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = CGSizeMake((_k_w-20)/2, (_k_w-20)/2+50);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
