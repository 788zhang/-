//
//  ActivityDetailViewController.m
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ActivityDetailViewController.h"
//#import <AFHTTPSessionManager.h>
#import "Activity.h"
//#import <MBProgressHUD.h>
//#import <SDWebImage/UIImageView+WebCache.h>

@interface ActivityDetailViewController ()

@property (strong, nonatomic) IBOutlet Activity *ActivityDetail;


@property(nonatomic, strong) NSString *phoneNumber;

@property(nonatomic, strong) NSDictionary *DetailDic;

@property(nonatomic, strong) NSArray *contentArr;
@property(nonatomic, strong) NSDictionary *shoppingDic;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title=@"活动详情";
//    //隐藏tablerbar
//    self.tabBarController.tabBar.hidden=YES;
    
   
    //导航栏左边按钮
    [self showBarButton];
    
    
    //去地图界面
    [self.ActivityDetail.activityMap addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //打电话
    
    [self.ActivityDetail.activityPhone addTarget:self action:@selector(makeCallButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self configDataView];
    [self getModel];
    
    
}



//地图页

- (void)mapButtonAction:(UIButton *)btn{
    
    
    
}


//打电话

- (void)makeCallButtonAction:(UIButton *)btn{
    //程序外打电话。打完电话之后不返回当前应用
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneNumber]]];
    
    
     //程序内打电话。打完电话之后还返回当前应用
    
    UIWebView *call=[[UIWebView alloc]init];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneNumber]]];
    
    
    [call loadRequest:request];
    
    [self.view addSubview:call];
    
    
}




//懒加载

- (NSArray *)contentArr{
    
    if (_contentArr == nil) {
        self.contentArr =[[NSArray alloc]init];
        
    }
    return _contentArr;
}


-(void)configDataView{
    
        
    
    
}

#pragma mark ---网络请求

-(void)getModel{
    
    
    
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    
    
    sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    
//    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    
    
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
//       ZPFLog(@"%@",responseObject);
        
        NSDictionary *resuleDic=responseObject;
        
        NSString *status=resuleDic[@"status"];
        NSInteger code=[resuleDic[@"code"] integerValue];
        
        if ([status isEqualToString:@"success"] &&code == 0) {
            NSDictionary *dic=resuleDic[@"success"];
          
            self.phoneNumber=dic[@"tel"];
            
            self.ActivityDetail.dataDic=dic;

            
            
        }else{
            
            
            
            
        }
        
        
        
        
        
        [self configDataView];
        
        
        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
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
