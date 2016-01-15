//
//  ShareView.m
//  Pandas
//
//  Created by scjy on 16/1/14.
//  Copyright © 2016年 苹果IOS. All rights reserved.
//

#import "ShareView.h"
#import "WeiboSDK.h"

#import "AppDelegate.h"

@interface ShareView ()<WeiboSDKDelegate>
@property (nonatomic,strong)  UIView *shareView;
@property (nonatomic,strong)  UIView *blockView;
@end

@implementation ShareView
-(instancetype)init{

    self = [super init];
    if (self) {
        [self config];
    }
    return self;

}
-(void)config{

  
      UIWindow  *window = [[UIApplication sharedApplication] .delegate window];
    self.blockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    self.blockView.backgroundColor = [UIColor blackColor];
    self.blockView.alpha = 0.8;
    [window addSubview:self.blockView];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight-170, KScreenWidth, 250)];
    self.shareView.backgroundColor = [UIColor lightGrayColor];
    self.shareView.alpha = 1;
    [window addSubview:self.shareView];
    
    
    
    
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(70, 30, 60, 60);
    [weiboBtn setImage:[UIImage imageNamed:@"ic_com_sina_weibo_sdk_logo"] forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(SendRequest) forControlEvents:UIControlEventTouchUpInside];
    [ self.shareView addSubview:weiboBtn];
    
    
    
    UIButton *friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    friendBtn.frame = CGRectMake(150, 30, 60, 60);
    [friendBtn setImage:[UIImage imageNamed:@"share_friend"] forState:UIControlStateNormal];
    [friendBtn addTarget:self action:@selector(sendAuthRequest) forControlEvents:UIControlEventTouchUpInside];
    
    [self.shareView addSubview:friendBtn];
    
    
    
    UIButton *circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    circleBtn.frame = CGRectMake(230, 30, 60, 60);
    [circleBtn setImage:[UIImage imageNamed:@"py_normal"] forState:UIControlStateNormal];
    [self.shareView addSubview:circleBtn];
    
    
    
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(20, 100, KScreenWidth-40, 44);
    [removeBtn setTitle:@"取消" forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(goBacks) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:removeBtn];
    
  
    
    [UIView  animateWithDuration:1.0 animations:^{
        
        self.shareView.frame = CGRectMake(0, KScreenWidth+100, KScreenHeight, 300);
        
    }];
    
    



}
-(void)goBacks{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.blockView.alpha = 0.0;
        self.shareView.frame = CGRectMake(0, KScreenWidth+100, KScreenHeight, 200);
        
    }];
    [self.blockView removeFromSuperview];
    [self.shareView removeFromSuperview];
    
    
}
-(void)sendAuthRequest{
    
    
    
    
    
   
    
    
}
-(void)SendRequest{
    
    [self goBacks];
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI =kRedirectURI ;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"ShareViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}
                         };
    [WeiboSDK sendRequest:request];
    
    
    
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{

  
    
    
}
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{

    
    
}

- (WBMessageObject *)messageToShare
{
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"你好";
    return message;
    
    
}



@end
