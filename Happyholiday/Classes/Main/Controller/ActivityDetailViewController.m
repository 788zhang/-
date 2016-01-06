//
//  ActivityDetailViewController.m
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import <AFHTTPSessionManager.h>
#import <MBProgressHUD.h>
@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationController.title=@"活动详情";
    
    [self showBarButton];
    
    
    
}

#pragma mark ---网络请求

-(void)getModel{
    
    
    
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    
    
    sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    
    
//    
//    [sessionManager GET:[NSString stringWithFormat:kActivityDetail,self.activityID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%lld",downloadProgress.totalUnitCount);
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//    
    
    
    [sessionManager GET:[NSString stringWithFormat:@"%@&id=%@",kActivitychangeDetail,self.activityID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       ZPFLog(@"%@",responseObject);
        
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
    
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
