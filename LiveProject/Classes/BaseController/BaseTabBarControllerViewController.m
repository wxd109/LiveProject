//
//  BaseTabBarControllerViewController.m
//  LiveProject
//
//  Created by dd on 16/7/8.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseTabBarControllerViewController.h"
#import "BaseNavigationViewController.h"
#import "HomeViewController.h"
#import "PartViewController.h"
#import "LiveViewController.h"
#import "PersonViewController.h"

@interface BaseTabBarControllerViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    [self setTabBar];
}

- (void)setTabBar
{
    NSArray *viewArr = @[@"HomeViewController",@"PartViewController",@"LiveViewController",@"PersonViewController"];
    NSArray *imageArr = @[@"home",@"fishpond",@"message",@"account"];
    
    for (int i = 0; i < viewArr.count; i++) {
        Class cls = NSClassFromString([viewArr objectAtIndex:i]);
        [self addChildViewController:(UIViewController *)[[cls alloc] init] imageNamed:[imageArr objectAtIndex:i]];
    }
    
}

- (void)addChildViewController:(UIViewController *)childController imageNamed:(NSString *)imageName
{
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:childController];
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
