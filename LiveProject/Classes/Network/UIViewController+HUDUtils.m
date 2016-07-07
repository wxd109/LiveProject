//
//  UIViewController+HUDUtils.m
//
//
//  Created by dd on 16/6/27.
//
//

#import "UIViewController+HUDUtils.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIViewController (HUDUtils)

- (void)showProgreeHUD:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    NSLog(@"start");
}

- (void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:true];
}

- (void)hideHUD:(NSTimeInterval)afterDelay
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self hideHUD];
//        NSLog(@"stop");
//    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
        NSLog(@"stop");
    });
}
@end
