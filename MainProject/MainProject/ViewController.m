//
//  ViewController.m
//  MainProject
//
//  Created by 刘小壮 on 2016/12/10.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import "ViewController.h"
#import <MGJRouter/MGJRouter.h>
#import "HomeViewController.h"
#import "LoginViewController.h"

const NSString *CTBUserCenterLoginDelegateKey = @"CTBUserCenterLoginDelegateKey";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    NSDictionary *params = @{CTBUserCenterLoginDelegateKey : homeVC};
    [MGJRouter openURL:@"CTB://UserCenter/UserLogin" withUserInfo:params completion:nil];
    
    [MGJRouter registerURLPattern:@"CTB://UserCenter/UserLogin" toHandler:^(NSDictionary *routerParameters) {
        UIViewController *homeVC = routerParameters[CTBUserCenterLoginDelegateKey];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = homeVC;
    }];
}

- (IBAction)skipToUserCenterModuleAction:(UIButton *)sender {
    
    [MGJRouter openURL:@"CTB://UserCenter/PushMainVC"
          withUserInfo:@{@"navigationVC" : self.navigationController}
            completion:nil];
}

- (IBAction)skipToHomePageModuleAction:(UIButton *)sender {
    
    [MGJRouter openURL:@"CTB://HomePage/PushMainVC"
          withUserInfo:@{@"navigationVC" : self.navigationController}
            completion:nil];
}

@end
