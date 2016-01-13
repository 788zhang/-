//
//  DiscoverViewController.m
//  
//
//  Created by scjy on 16/1/4.
//
//

#import "DiscoverViewController.h"
#import "UIDiscoverTableViewCell.h"
#import "PullingRefreshTableView.h"
#import "ProgressHUD.h"
#import "DisCover.h"
#import "ActivityDetailViewController.h"


@interface DiscoverViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>

@property(nonatomic, strong) PullingRefreshTableView *tableView;
@property(nonatomic, strong) NSMutableArray *likeOfArr;
@property(nonatomic, strong) UIScrollView *scrollerView;


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title=@"发现";
     self.navigationController.navigationBar.barTintColor=RGB(96, 185, 185);
    
    [self.view addSubview:self.tableView];
    //向四周填充
    self.edgesForExtendedLayout=UIRectEdgeAll;
    
   
    [self.tableView registerNib:[UINib nibWithNibName:@"UIDiscoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self getNetData];
    [self tabelheadView];
    
}




-(void)tabelheadView{
    
    
    
    
    
    
    
    
    
}




#pragma mark ----网络请求

-(void)getNetData{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [ProgressHUD show:@"正在拼命加载中。。" Interaction:YES];
    
    [manager GET:[NSString stringWithFormat:@"%@",Kdiscover] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ProgressHUD showSuccess:@"加载完成" Interaction:YES];
        
        ZPFLog(@"%@",responseObject);
        
        NSDictionary *rootdic=responseObject;
        
        NSInteger code=[rootdic[@"code"] intValue];
        NSString *status=rootdic[@"status"];
        if (code==0 &&[status isEqualToString:@"success"]) {
            
            NSDictionary *successdic=rootdic[@"success"];
            
            NSArray *likeArr=successdic[@"like"];
            
            for (NSDictionary *dic in likeArr) {
                
                DisCover *model=[[DisCover alloc]initWithDic:dic];
                
                [self.likeOfArr addObject:model];
                
            }
            
            
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error] Interaction:YES];
        
    }];
    
    
    
    
    
    
    
}








#pragma mark ----PullingRefreshTableViewDelegate

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    
    
   [self performSelector:@selector(getNetData) withObject:nil afterDelay:1.f];
    
    
    
}


- (NSDate *)pullingTableViewLoadingFinishedDate{
    
    return [HWTools getSystemNowdate];
    
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




#pragma mark -----UITableViewDataSource,UITableViewDelegate








- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return self.likeOfArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UIDiscoverTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     
    cell.model=self.likeOfArr[indexPath.row];
    return cell;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIStoryboard *mainSB=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ActivityDetailViewController *activity=[mainSB instantiateViewControllerWithIdentifier:@"ActivityDetail"];
    
    
    //活动id
    DisCover *model=self.likeOfArr[indexPath.row];
    
    activity.activityID =model.activityID;
    
    [self.navigationController pushViewController:activity animated:YES];
 
    
    
    
}

#pragma mark ---- 懒加载

//自定义头部的
- (UIScrollView *)scrollerView{
    
    if (_scrollerView == nil) {
        _scrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 186)];
    }
    
    return _scrollerView;
}


- (NSMutableArray *)likeOfArr{
    
    if (_likeOfArr == nil) {
        self.likeOfArr=[[NSMutableArray alloc]init];
        
        
    }
    return _likeOfArr;
    
}


- (PullingRefreshTableView *)tableView{
    
    if (_tableView == nil) {
        self.tableView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) pullingDelegate:self];
        
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.rowHeight=168;
        
        [self.tableView setHeaderOnly:YES];
        
    }
    return _tableView;
    
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
