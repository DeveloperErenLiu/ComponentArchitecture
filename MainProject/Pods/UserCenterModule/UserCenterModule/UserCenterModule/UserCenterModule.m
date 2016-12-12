//
//  UserCenterModule.m
//  UserCenterModule
//
//  Created by 刘小壮 on 2016/12/12.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import "UserCenterModule.h"
#import <MGJRouter/MGJRouter.h>
#import "UserCenterViewController.h"

@implementation UserCenterModule

// 在load方法中自动注册，在主工程中不用写任何代码。
+ (void)load {
    [MGJRouter registerURLPattern:@"CTB://UserCenter/PushMainVC" toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        
        UserCenterViewController *userCenterVC = [[UserCenterViewController alloc] init];
        [navigationVC pushViewController:userCenterVC animated:YES];
    }];
}

@end
