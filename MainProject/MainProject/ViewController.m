//
//  ViewController.m
//  MainProject
//
//  Created by 刘小壮 on 2016/12/10.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import "ViewController.h"
#import <MGJRouter/MGJRouter.h>

@implementation ViewController

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
