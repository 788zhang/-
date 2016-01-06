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
#import "SelectCityViewController.h"
#import "SearchViewController.h"
#import "ActivityDetailViewController.h"
#import "ThemeViewController.h"
//分类列表
#import "ClassifyViewController.h"

//精选
#import "GoodActivityViewController.h"

//热门
#import "HotViewController.h"



@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//strong
@property(nonatomic, strong) NSMutableArray *listAllArr;
@property(nonatomic, strong) NSMutableArray *advertisementArray;
@property(nonatomic, strong) NSMutableArray *activityArr;
@property(nonatomic, strong) NSMutableArray *themeArr;

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControll;

//定时器，用于图片滚动播放
@property(nonatomic, strong) NSTimer *timer;


@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //左
    
    UIBarButtonItem *leftbtn=[[UIBarButtonItem alloc]initWithTitle:@"洛阳" style:UIBarButtonItemStylePlain target:self action:@selector(selectCity)];
    
    
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
    
    
    //启动定时器
    
    [self startTimer];
    
    
}


#pragma mark --- 导航栏按钮方法


//实现代理方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    NSLog(@"%@",scrollView);
    
    UIImageView *imageview=(UIImageView *)[scrollView viewWithTag:110];
    return imageview;
    
    //    //在scrollview上通过tag值寻找imageview
    //    return [scrollView viewWithTag:0];
    
}


- (void)selectCity{
 
    SelectCityViewController *select=[[SelectCityViewController alloc]init];
    
    //模态退出
    [self.navigationController presentViewController:select animated:YES completion:nil];
    
    
    
}

-(void)seachActivity{
    
    SearchViewController *search=[[SearchViewController alloc]init];
    
    [self.navigationController presentViewController:search animated:YES completion:nil];
    
    
}
#pragma mark ----首页轮播图的方法

//轮播图定时器方法
-(void)startTimer{
    
    //防止定时器重复创建
    if (self.timer != nil) {
        return;
    }
    
    self.timer=[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(rollAnimation) userInfo:nil repeats:YES];
    
    // 添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    
}

//每两秒执行一次
-(void)rollAnimation{

    
    NSInteger page=self.pageControll.currentPage+1 ;
    
    NSInteger curentPage = page % self.advertisementArray.count;
  
      self.pageControll.currentPage = curentPage;
    
    // 根据页数，调整滚动视图中的图片位置 contentOffset
    CGFloat x = self.pageControll.currentPage * KScreenWidth;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
    
    
}
//当手动去滑动Scroller的时候，定时器依然在计算时间，可能我们刚刚滑动到下一页，定时器时间又刚好触发，导致在当前页停留时间不到2秒
//解决方案在scroller开始移动的时候结束定时器
//在scroller结束的时候启动定时器
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    
    //停止计时器
    
    [self.timer invalidate];
    
    self.timer =nil;//
    
    
}










- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //第一步：获取scroller的页面宽度
    
    CGFloat pageWith=self.scrollView.frame.size.width;
    //第二步：获取scroller的偏移量
    
    CGPoint offset=self.scrollView.contentOffset;
    //第三步：通过偏移量和页面宽度计算出当前页
    
    NSInteger pageNumber=offset.x/pageWith;
    self.pageControll.currentPage=pageNumber;
    
    
    
}


-(void)pageSelecAction:(UIPageControl *)page{

    
    //第一步：获取pagecontrol点击的第几个页面
    NSInteger num =  page.currentPage;
    //第二步：获取页面的宽度：
    CGFloat pageWidth=self.scrollView.frame.size.width;
    //让scrollview滚动到第几页
    self.scrollView.contentOffset=CGPointMake(num * pageWidth, 0);
    

    
    

}



#pragma mark ----6个按钮的方法

//轮播图的点击方法

-(void)touchAdvertisement:(UIButton *)btn{
    //从数组中的字典中
    
    NSString *type=self.advertisementArray[btn.tag-100][@"type"];
    
    
    if ([type integerValue]==1) {
        ActivityDetailViewController *activity=[[ActivityDetailViewController alloc]init];
        activity.activityID=self.advertisementArray[btn.tag-100][@"id"];
        
        [self.navigationController pushViewController:activity animated:YES];
    }else{
        
        
        HotViewController *hot=[[HotViewController alloc]init];
        
        [self.navigationController pushViewController:hot animated:YES];
        
    }
    
    
}






-(void)clickbtn:(UIButton *)btn{
    
    
    
    if (btn.tag == 1) {
        
        ClassifyViewController *class=[[ClassifyViewController alloc]init];
        
        
        [self.navigationController pushViewController:class animated:YES];
        
        
        
        
    }
    if (btn.tag == 2) {
        
        
        ClassifyViewController *class=[[ClassifyViewController alloc]init];
        
        
        [self.navigationController pushViewController:class animated:YES];
    }
    if (btn.tag == 3) {
        
        
        ClassifyViewController *class=[[ClassifyViewController alloc]init];
        
        
        [self.navigationController pushViewController:class animated:YES];
    }
    if (btn.tag == 4) {
        
        
        ClassifyViewController *class=[[ClassifyViewController alloc]init];
        
        
        [self.navigationController pushViewController:class animated:YES];
    }
    if (btn.tag == 5) {
        
        GoodActivityViewController *good=[[GoodActivityViewController alloc]init];
        
        [self.navigationController pushViewController:good animated:YES];
        
        
        
    }
    if (btn.tag == 6) {
        
        
        HotViewController *hot=[[HotViewController alloc]init];
        
        [self.navigationController pushViewController:hot animated:YES];
        
        
        
    }
  
    
    
}



#pragma mark ----属性的懒加载

- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        
        //添加轮播图
        self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 186)];
        
        self.scrollView.delegate=self;
        
        self.scrollView.contentSize=CGSizeMake(self.advertisementArray.count*KScreenWidth, 186);
        
        
        //整平滑动
        self.scrollView.pagingEnabled=YES;
        //不显示水平方向滚动条
        self.scrollView.showsHorizontalScrollIndicator=NO;

        
    }
    
    
    return _scrollView;
}



- (UIPageControl *)pageControll{
    
    if (_pageControll == nil) {
        
        //创建小原点
        
        self.pageControll=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 186-30, KScreenWidth, 30)];
        
       
        
        self.pageControll.currentPageIndicatorTintColor=[UIColor redColor];
        [self.pageControll addTarget:self action:@selector(pageSelecAction:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    
    return _pageControll;
}









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
    
    
    
    NSString *urlstring=kMainDataInterface;
    
    
    AFHTTPSessionManager  *sessionManager=[AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [sessionManager GET:urlstring parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       //ZPFLog(@"%@",responseObject);
        
        
        
        
        
        NSDictionary *resuleDic=responseObject;
        
        NSString *status=resuleDic[@"status"];
        NSInteger code=[resuleDic[@"code"] integerValue];
        
        if ([status isEqualToString:@"success"] &&code == 0) {
            NSDictionary *dic=resuleDic[@"success"];
            //广告adData
            NSArray *adDataArr=dic[@"adData"];
            
            for (NSDictionary *dic in adDataArr) {
                
                NSDictionary *dic1=@{@"url":dic[@"url"],@"type":dic[@"type"],@"id":dic[@"id"]};
                [self.advertisementArray addObject:dic1];
                
//                [self.advertisementArray addObject:dic[@"url"]];
            }
            
            [self configTableViewheadView];
            
            NSString *cityname=dic[@"cityname"];
            //已请求回来的城市作为导航栏按钮标题
            self.navigationItem.leftBarButtonItem.title=cityname;
            

            
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
         ZPFLog(@"%@",error);
    }];
    
    
}

#pragma mark ----自定义TableView头部
//自定义TableView头部
-(void)configTableViewheadView{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 343)];

    
    
    [view addSubview:self.scrollView];
    
    [view addSubview:self.pageControll];

     self.pageControll.numberOfPages=self.advertisementArray.count;
    
    for (int i=0; i<self.advertisementArray.count; i++) {
       
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*i, 0, KScreenWidth, 186)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.advertisementArray[i][@"url"]] placeholderImage:nil];
        imageView.userInteractionEnabled=YES;
        
        [self.scrollView addSubview:imageView];
        
        
        
        UIButton *touchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        touchBtn.frame=imageView.frame;
        touchBtn.tag=100+i;
        
        [touchBtn addTarget:self action:@selector(touchAdvertisement:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.scrollView addSubview:touchBtn];
        
        
        
        
        
    }
    
    
    
    
    self.tableView.tableHeaderView=view;
    
    
    
    
    //按钮
    
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*KScreenWidth/4, 186, KScreenWidth/4, KScreenWidth/4);
        
        NSString *imgStr=[NSString stringWithFormat:@"home_icon_0%d",i+1];
        [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
        
        btn.tag=i+1;
        
        
        [btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn];
        
        //精选热门活动
        
        
        UIButton *selecteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        selecteBtn.frame=CGRectMake(0,262, KScreenWidth/2, KScreenWidth/4);
        
      
        [selecteBtn setImage:[UIImage imageNamed:@"home_huodong"] forState:UIControlStateNormal];
        
        selecteBtn.tag=5;
        
        
        [selecteBtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:selecteBtn];
        
        
        
        UIButton *selecteBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        selecteBtn1.frame=CGRectMake(KScreenWidth/2,262, KScreenWidth/2, KScreenWidth/4);
        
        
        [selecteBtn1 setImage:[UIImage imageNamed:@"home_zhuanti"] forState:UIControlStateNormal];
        
        selecteBtn1.tag=6;
        
        
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        //推荐活动
        ActivityDetailViewController *activity=[[ActivityDetailViewController alloc]init];
        
        
        [self.navigationController pushViewController:activity animated:YES];
        
        
    }else{
        
        
        ThemeViewController *them=[[ThemeViewController alloc]init];
        
        [self.navigationController pushViewController:them animated:YES];
        
    }
    
    
    
    
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
   
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-160, 5,320 , 16)];
   
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
