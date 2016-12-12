//
//  HomePageModule.m
//  HomePageModule
//
//  Created by 刘小壮 on 2016/12/12.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import "HomePageModule.h"
#import <MGJRouter/MGJRouter.h>
#import "HomePageViewController.h"

@implementation HomePageModule

// 在load方法中自动注册，在主工程中不用写任何代码。
+ (void)load {
    [MGJRouter registerURLPattern:@"CTB://HomePage/PushMainVC" toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        
        HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
        [navigationVC pushViewController:homePageVC animated:YES];
    }];
}

@end
