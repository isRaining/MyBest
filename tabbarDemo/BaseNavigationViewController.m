//
//  BaseNavigationViewController.m
//  tabbarDemo
//
//  Created by Shouqiang Wei on 14/12/26.
//  Copyright (c) 2014年 TabBarDemo. All rights reserved.
//

#import "BaseNavigationViewController.h"
@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *color=[Tools hexStringToColor:@"303237"];
    UIImage *image=[Tools imageWithColor:color size:CGSizeMake(kDeviceWidth, 64)];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSDictionary * navTitleTextAttributesDic = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [[UINavigationBar appearance]setTitleTextAttributes:navTitleTextAttributesDic];//控制title颜色字体;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];//控制 barButtonItem 返回图片的颜色 字体颜色;
    
    
    
    UIColor *color2=[Tools hexStringToColor:@"999999"];
    NSDictionary *barButtonItemDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [[UIBarButtonItem appearance]setTitleTextAttributes:barButtonItemDic forState:UIControlStateNormal];//控制返回字体的大小;
    NSDictionary *tabBarItemAttributesDicNormal=@{NSForegroundColorAttributeName:color2,NSFontAttributeName:[UIFont boldSystemFontOfSize:10]};
    NSDictionary *tabBarItemAttributesDicSelect=@{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont systemFontOfSize:10]};
    
    
    [[UITabBarItem appearance]setTitleTextAttributes:tabBarItemAttributesDicNormal forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:tabBarItemAttributesDicSelect forState:UIControlStateSelected];//tabbaritem 字体的大小颜色;
    // Do any additional setup after loading the view.
}

//push的时候判断到子控制器的数量。当大于零时隐藏BottomBar 也就是UITabBarController 的tababar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
