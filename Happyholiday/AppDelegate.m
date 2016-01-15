//
//  AppDelegate.m
//  Happyholiday
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()<WeiboSDKDelegate>



@end

@implementation AppDelegate
@synthesize wbtoken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppkey];
    
    [WXApi registerApp:kWeixinAppId];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //创建一个 UITabBarController
     self.tabbar=[[UITabBarController alloc]init];
    
   
    //创建被tabbar控制的视图控制器
    
    //主页
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *mainNav=mainStoryboard.instantiateInitialViewController;
    //导航栏颜色
    mainNav.navigationBar.barTintColor = [UIColor colorWithRed:96/255.0f green:185/255.0f blue:191/255.0f alpha:1.0];
    
    //mainNav.tabBarItem.title=@"主页";
    mainNav.tabBarItem.image=[UIImage imageNamed:@"ft_home_normal_ic"];
    UIImage *image=[UIImage imageNamed:@"ft_home_selected_ic"];
    //按图片原来状态显示
    mainNav.tabBarItem.selectedImage=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //上左下右
    mainNav.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    
    //发现
    
    UIStoryboard *discoverbd=[UIStoryboard storyboardWithName:@"DiscoverStoryboard" bundle:nil];
    UINavigationController *discoverNav=discoverbd.instantiateInitialViewController;
    
//    discoverNav.navigationBar.tintColor=[UIColor colorWithRed:96/255.0f green:185/255.0f blue:191/255.0f alpha:1.0];
//    
    
   // discoverNav.tabBarItem.title=@"发现";
    discoverNav.tabBarItem.image=[UIImage imageNamed:@"ft_found_normal_ic"];
    UIImage *disimage=[UIImage imageNamed:@"ft_found_selected_ic"];
    //按图片原来状态显示
    discoverNav.tabBarItem.selectedImage=[disimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    discoverNav.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
    
    UIStoryboard *minebd=[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    
    
    UINavigationController *mineNav=minebd.instantiateInitialViewController;
    //mineNav.tabBarItem.title=@"我的";
    mineNav.tabBarItem.image=[UIImage imageNamed:@"ft_person_normal_ic"];
    
    UIImage *mineimage=[UIImage imageNamed:@"ft_person_selected_ic"];
    //按图片原来状态显示
    mineNav.tabBarItem.selectedImage=[mineimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    mineNav.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
    
    //添加被管理的视图控制器
    
    
    
    
    
     self.tabbar.viewControllers=@[mainNav,discoverNav,mineNav];
    
     self.tabbar.tabBar.backgroundColor=[UIColor whiteColor];

    
    
    
    self.window.rootViewController= self.tabbar;
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark --- shar微信
-(void) onReq:(BaseReq*)req{
    
    
}


-(void) onResp:(BaseResp*)resp{
    
    
    
}



#pragma mark --- share微博
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    
    return [WeiboSDK handleOpenURL:url delegate:self];
    return [WXApi handleOpenURL:url delegate:self];
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WeiboSDK handleOpenURL:url delegate:self];
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark ---微博代理
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
