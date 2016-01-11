//
//  ThemeViewController.m
//  Happyholiday
// 活动专题
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ThemeViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "ActivityThem.h"
@interface ThemeViewController ()


@property(nonatomic, strong) ActivityThem *activityThem;

@end

@implementation ThemeViewController


- (void)loadView{
    
    [super loadView];
    
    
    self.activityThem=[[ActivityThem alloc]initWithFrame:self.view.frame];
    
    
    
    [self.view addSubview:self.activityThem];
    
    //获取网络数据
    [self getModel];
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self showBarButton];
   
    
    
    
    
}









#pragma mark ----网络请求

-(void)getModel{
    
    NSString *urlstring=KactivityThem;
    
    
    AFHTTPSessionManager  *sessionManager=[AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [sessionManager GET:[NSString stringWithFormat:@"%@&id=%@",urlstring,self.themId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        NSDictionary *resuleDic=responseObject;
        
        NSString *status=resuleDic[@"status"];
        NSInteger code=[resuleDic[@"code"] integerValue];
        
        if ([status isEqualToString:@"success"] &&code == 0){
            
          
            
            self.activityThem.dataDic=resuleDic[@"success"];
            
            self.navigationItem.title=resuleDic[@"success"][@"title"];
            
        }else{
            
            
            
            
        }
               
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ZPFLog(@"%@",error);
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
