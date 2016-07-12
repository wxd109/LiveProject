//
//  LiveViewCell.h
//  LiveProject
//
//  Created by dd on 7/11/16.
//  Copyright © 2016 dd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Data;

@interface LiveViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *liveImage;

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *anchorName;

@property (weak, nonatomic) IBOutlet UILabel *anchorDescribe;

@property (nonatomic, strong) Data *liveData;

@end
