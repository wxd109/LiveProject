//
//  UIViewController+HUDUtils.h
//  
//
//  Created by dd on 16/6/27.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUDUtils)

- (void)showProgreeHUD:(NSString *)text;

- (void)hideHUD:(NSTimeInterval)afterDelay;

@end
