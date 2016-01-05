//
//  MainViewController.m
//  Happyholiday
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "MainModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//strong
@property(nonatomic, strong) NSMutableArray *listAllArr;
@property(nonatomic, strong) NSMutableArray *advertisementArray;
@property(nonatomic, strong) NSMutableArray *activityArr;
@property(nonatomic, strong) NSMutableArray *themeArr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //左
    
    UIBarButtonItem *leftbtn=[[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectCity)];
    
    
    leftbtn.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=leftbtn;
    
    
    //导航栏上navigationItem
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(seachActivity)];
    //1.设置导航栏上的左右按钮  把leftBarButton设置为navigationItem左按钮
    
    rightBarButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    
    //注册cell
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
//    //请求网络数据
    [self requestModel];
    
    
    //解析数据
    [self configTableViewheadView];
    
    
    
    
}


#pragma mark --- 导航栏按钮方法


- (void)selectCity{
 
    
    
    
}

-(void)seachActivity{
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURL *URL = [NSURL URLWithString:@"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1"];
   
    AFHTTPSessionManager *managerhttp=[[AFHTTPSessionManager alloc]initWithBaseURL:URL sessionConfiguration:configuration];

    NSURLSessionDataTask *a=[managerhttp GET:@"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *resuleDic=responseObject;
        
        NSString *status=resuleDic[@"status"];
        NSInteger code=[resuleDic[@"code"] integerValue];
        
        if ([status isEqualToString:@"success"] &&code == 0) {
            NSDictionary *dic=resuleDic[@"success"];
            //广告adData
            NSArray *adDataArr=dic[@"adData"];
           
            
            NSString *cityname=dic[@"cityname"];
            //已请求回来的城市作为导航栏按钮标题
            self.navigationItem.leftBarButtonItem.title=cityname;
           
            for (NSDictionary  *adDic  in adDataArr) {
                
                MainModel *model=[[MainModel alloc]initWithDic:adDic];
                
                [self.advertisementArray addObject:model];
                
                
            }
            //推荐活动
            NSArray *acDataArr=dic[@"acData"];

            for (NSDictionary *dic in acDataArr ) {
                
                MainModel *model=[[MainModel alloc]initWithDic:dic];
                
                
                [self.activityArr addObject:model];
                
            }
            
            
          //推荐专题
            NSArray *rcDataArr=dic[@"rcData"];
            
            
            for (NSDictionary *dic in rcDataArr ) {
                
                MainModel *model=[[MainModel alloc]initWithDic:dic];
                
                
                [self.themeArr addObject:model];
                
            }

            
            
        }
        
        
        [self.listAllArr addObject:self.activityArr];

        [self.listAllArr addObject:self.themeArr];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    [a resume];
    
}


#pragma mark ----6个按钮的方法


-(void)clickbtn:(UIButton *)btn{
    
    
    
    if (btn.tag == 1) {
        
    }
    if (btn.tag == 2) {
        
    }
    if (btn.tag == 3) {
        
    }
    if (btn.tag == 4) {
        
    }
    if (btn.tag == 5) {
        
    }
    if (btn.tag == 6) {
        
    }
  
    
    
}



#pragma mark ----数组属性的懒加载

- (NSMutableArray *)listAllArr{
    
    if (_listAllArr == nil) {
        self.listAllArr =[[NSMutableArray alloc]init];
    }
    return _listAllArr;
}


- (NSMutableArray *)advertisementArray{
    
    if (_advertisementArray == nil) {
        self.advertisementArray=[[NSMutableArray alloc]init];
    }
    
    return _advertisementArray;
}


- (NSMutableArray *)activityArr{
    
    if (_activityArr == nil) {
        self.activityArr=[[NSMutableArray alloc]init];
        
    }
    
    return _activityArr;
}


- (NSMutableArray *)themeArr{
    
    if (_themeArr == nil ) {
        self.themeArr=[[NSMutableArray alloc]init];
    }
    
    return _themeArr;
}



#pragma mark -----网络请求数据和解析数据


-(void)requestModel{
    
    
    
    NSString *urlstring=@"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1";
    
    
    AFHTTPSessionManager  *sessionManager=[AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [sessionManager GET:urlstring parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
         NSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        
        
        
        
        NSDictionary *resuleDic=responseObject;
        
        NSString *status=resuleDic[@"status"];
        NSInteger code=[resuleDic[@"code"] integerValue];
        
        if ([status isEqualToString:@"success"] &&code == 0) {
            NSDictionary *dic=resuleDic[@"success"];
            //广告adData
            NSArray *adDataArr=dic[@"adData"];
            
            for (NSDictionary *dic in adDataArr) {
                [self.advertisementArray addObject:dic[@"url"]];
            }
            
            [self configTableViewheadView];
            
            NSString *cityname=dic[@"cityname"];
            //已请求回来的城市作为导航栏按钮标题
            self.navigationItem.leftBarButtonItem.title=cityname;
            
            for (NSDictionary  *adDic  in adDataArr) {
                
                MainModel *model=[[MainModel alloc]initWithDic:adDic];
                
                [self.advertisementArray addObject:model];
                
                
            }
            //推荐活动
            NSArray *acDataArr=dic[@"acData"];
            
            for (NSDictionary *dic in acDataArr ) {
                
                MainModel *model=[[MainModel alloc]initWithDic:dic];
                
                
                [self.activityArr addObject:model];
                
            }
            [self.listAllArr addObject:self.activityArr];
            
            //推荐专题
            NSArray *rcDataArr=dic[@"rcData"];
            
            
            for (NSDictionary *dic in rcDataArr ) {
                
                MainModel *model=[[MainModel alloc]initWithDic:dic];
                
                
                [self.themeArr addObject:model];
                
            }
            [self.listAllArr addObject:self.themeArr];
            //刷新收据
            [self.tableView reloadData];
            
            
            
        }
        
        
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
    }];
    
    
}

#pragma mark ----自定义TableView头部
//自定义TableView头部
-(void)configTableViewheadView{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 343)];
//    
//    view.backgroundColor=[UIColor redColor];
    
    //添加轮播图
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 186)];
    
   
    
    scrollView.contentSize=CGSizeMake(self.advertisementArray.count*[UIScreen mainScreen].bounds.size.width, 186);
    
    
    for (int i=0; i<self.advertisementArray.count; i++) {
       
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width, 186)];
     
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.advertisementArray[i]] placeholderImage:nil];
        
        
        [scrollView addSubview:imageView];
        
        
        
    }
    
    
    
    [view addSubview:scrollView];
    
    
    
    
    self.tableView.tableHeaderView=view;
    
    
    
    
    //按钮
    
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*[UIScreen mainScreen].bounds.size.width/4, 186, [UIScreen mainScreen].bounds.size.width/4, [UIScreen mainScreen].bounds.size.width/4);
        
        NSString *imgStr=[NSString stringWithFormat:@"home_icon_0%d",i+1];
        [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
        
        btn.tag=i+1;
        
        
        [btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn];
        
        //精选热门活动
        
        
        UIButton *selecteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        selecteBtn.frame=CGRectMake(0,262, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width/4);
        
      
        [selecteBtn setImage:[UIImage imageNamed:@"home_huodong"] forState:UIControlStateNormal];
        
        selecteBtn.tag=6;
        
        
        [selecteBtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:selecteBtn];
        
        
        
        UIButton *selecteBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        selecteBtn1.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2,262, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width/4);
        
        
        [selecteBtn1 setImage:[UIImage imageNamed:@"home_zhuanti"] forState:UIControlStateNormal];
        
        selecteBtn1.tag=7;
        
        
        [selecteBtn1 addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:selecteBtn1];
        
        
        
    }
    
    
    
    
    
    
    
    
}




#pragma mark ----UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.activityArr.count;
    }
    
    return self.themeArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainTableViewCell *maincell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    maincell.model=self.listAllArr[indexPath.section][indexPath.row];
    
    
    return maincell;
    
    
}

#pragma mark ----UITableViewDelegate




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return self.listAllArr.count;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 203;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 26;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]init];
   
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-160, 5,320 , 16)];
   
    if (section == 0) {
        
       imageView.image=[UIImage imageNamed:@"home_recommed_ac"];
    }else{
 
       imageView.image=[UIImage imageNamed:@"home_recommd_rc"];
    }
    [view addSubview:imageView];
    
    return view;
    
  
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
