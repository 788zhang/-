//
//  GoodActivityViewController.m
//  Happyholiday
//精选按钮
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "GoodActivityViewController.h"
//引入上拉下拉第三方框架
#import "PullingRefreshTableView.h"
#import "GoodActivityModel.h"
#import "GoodActiivityTableViewCell.h"
#import "ActivityDetailViewController.h"
@interface GoodActivityViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>


{
    
    NSInteger _pageCount;//定义请求加载的页面
    
}

@property(nonatomic, assign) BOOL refresh;
@property(nonatomic, strong) PullingRefreshTableView *tableView;

@property(nonatomic, strong) NSArray *acData;
@property(nonatomic, strong) NSMutableArray *allGroupArray;



@end

@implementation GoodActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButton];
    
    self.title=@"竞选活动";
    self.allGroupArray=[[NSMutableArray alloc]init];

    
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodActiivityTableViewCell"  bundle:nil]  forCellReuseIdentifier:@"goodCell"];
    

    
    [self.view addSubview:self.tableView];
    
    [self.tableView launchRefreshing];

    
    [self getNetModel];
    
}


#pragma mark --- 网络请求


- (void)getNetModel{
    
    

    
   
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc]init];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];

    [manager GET:[NSString stringWithFormat:@"%@&page=%ld",KactivityGood,(long)_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"%@",responseObject);
        NSDictionary *dic=responseObject;
        NSString *status=dic[@"status"];
        NSInteger code=[dic[@"code"] integerValue];
        
        if ([status isEqualToString:@"success"] && code ==0) {
            
            NSDictionary *successDic=dic[@"success"];
//            ZPFLog(@"%@",successDic);
            
            self.acData =successDic[@"acData"];
            
            if (self.refresh) {
                //下拉刷新时需要移除数组中的元素
                if ( self.allGroupArray.count>0) {
                    [self.allGroupArray removeAllObjects];
                }
                
            }

            
            
            for (NSDictionary *dic in self.acData) {
                GoodActivityModel *model=[[GoodActivityModel alloc]initWith:dic];
                
                [self.allGroupArray addObject:model];
                
            }
            
            NSLog(@"%lu",(unsigned long)self.allGroupArray.count);
            
            //完成加载
            
            [self.tableView tableViewDidFinishedLoading];
            
            self.tableView.reachedTheEnd=NO;

            [self.tableView reloadData];
            
        }else{
            
            
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"%@",error);
    }];
    
    
}

#pragma mark ---- 懒加载



- (NSArray *)acData{
    
    if (_acData == nil) {
        _acData =[[NSArray alloc]init];
        
        
    }
    return _acData;
}








- (PullingRefreshTableView *)tableView{
    
    if (_tableView == nil) {
        self.tableView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) pullingDelegate:self];
        
        
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        
        self.tableView.rowHeight=90;
        
    }
    
    return _tableView;
}

#pragma mark ---PullingRefreshTableViewDelegate,,,上拉下拉

//上拉
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _pageCount+=1;
     self.refresh=NO;
    
    [self performSelector:@selector(getNetModel) withObject:nil afterDelay:1.f];
}



//table开始下拉开始调用
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount=1;
    self.refresh=YES;
    
    [self performSelector:@selector(getNetModel) withObject:nil afterDelay:1.0];
    
    
    
    
}


//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    NSLog(@"%s - [%d]",__FUNCTION__,__LINE__);
    
  return   [HWTools getSystemNowdate];
    
    
}



#pragma mark - ScrollView Method
//手指开始拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView tableViewDidScroll:scrollView];
}

//手指结束拖动方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView tableViewDidEndDragging:scrollView];
}



#pragma mark ---UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    ZPFLog(@"%ld",(unsigned long)self.allGroupArray.count);
    
    return self.allGroupArray.count;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodActiivityTableViewCell *goodcell=[self.tableView dequeueReusableCellWithIdentifier:@"goodCell" forIndexPath:indexPath];
    if (indexPath.row <= self.allGroupArray.count) {
        goodcell.model= self.allGroupArray[indexPath.row];

    }
    
    
    return goodcell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
   
           //推荐活动
        
        UIStoryboard *mainSB=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ActivityDetailViewController *activity=[mainSB instantiateViewControllerWithIdentifier:@"ActivityDetail"];
        
        
        //活动id
    GoodActivityModel *model=self.allGroupArray[indexPath.row];
    
        activity.activityID = model.activityid;
        
        [self.navigationController pushViewController:activity animated:YES];
        
        
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
