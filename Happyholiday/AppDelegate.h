//
//  AppDelegate.h
//  Happyholiday
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property(nonatomic, strong) NSString* wbtoken; 
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) UITabBarController *tabbar;

@end

