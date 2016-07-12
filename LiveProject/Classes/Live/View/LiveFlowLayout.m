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
    self.itemSize = CGSizeMake((_k_w-20)/2, (_k_w-20)/2-30);
    self.minimumLineSpacing = 5;
    self.minimumInteritemSpacing = 5;
    self.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
