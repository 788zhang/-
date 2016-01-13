//
//  ClassifyViewController.m
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ClassfyTableViewCell.h"
#import "Classfy.h"
//引入上拉下拉第三方框架
#import "PullingRefreshTableView.h"


#import "ActivityDetailViewController.h"
#import "VOSegmentedControl.h"

#import "ProgressHUD.h"


@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>

{
    
    NSInteger _pageCount;//定义请求加载的页面
    
}

@property(nonatomic, strong) VOSegmentedControl *segctrl1;//分割

@property(nonatomic, assign) BOOL refresh;
@property(nonatomic, strong) PullingRefreshTableView *tableView;

@property(nonatomic, strong) NSArray *acData;
@property(nonatomic, strong) NSMutableArray *allGroupArray;

//用来展示数据的数组

@property(nonatomic, strong) NSMutableArray *showDataArr;
@property(nonatomic, strong) NSMutableArray *showArr;
@property(nonatomic, strong) NSMutableArray *toursArr;
@property(nonatomic, strong) NSMutableArray *studyArr;
@property(nonatomic, strong) NSMutableArray *familyArr;





@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"分类列表";
    [self showBarButton];
    
    self.view.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.segctrl1];
    [self.tableView registerNib:[UINib nibWithNibName:@"ClassfyTableViewCell" bundle:nil] forCellReuseIdentifier:@"classfyCell"];
    _pageCount=1;
    [self chooseRequest];
    
    

    
    }
    


-(void)chooseRequest{
    
    switch (self.classfylistType) {
        case  ClassfyListTypeShowRepertoire:
            [self getShowRequest];
        break;
        case ClassfyListTypeTouristPlace:
            [self getToursData];
            
            break;
        case ClassfyListTypeStudyPUZ:
            [self getStudyData];
            break;
        case ClassfyListTypeFamilyTravel:
            [self getFamilyData];
            break;
        default:
            break;
    }
    
    
    
}



//- (void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillDisappear:animated];
//    
//    [ProgressHUD dismiss];
//    
//    
//    
//}

#pragma mark ----Custom Method  四个接口


-(void)getShowRequest{
    
    
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    
    
    sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [ProgressHUD show:@"别着急，让哥加载一会,着急，打死你！！！...."];
    
    
    
    
    //演出剧目
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",KClassfy,@(_pageCount),@(6)] parameters:nil
  progress:^(NSProgress * _Nonnull downloadProgress) {
      ZPFLog(@"%lld",downloadProgress.totalUnitCount);
      
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      [ProgressHUD showSuccess:@"主人，我以为你备好数据"];
      
      ZPFLog(@"%@",responseObject);
      NSDictionary *dic=responseObject;
      NSString *status=dic[@"status"];
      NSInteger code=[dic[@"code"] integerValue];
      
      if ([status isEqualToString:@"success"] && code ==0) {
          
          NSDictionary *successDic=dic[@"success"];
          //ZPFLog(@"%@",successDic);
          
          self.acData =successDic[@"acData"];
          
          if (self.refresh) {
              if (self.showArr.count>0) {
                  [self.showArr removeAllObjects];
              }
          }
          
          
          for (NSDictionary *dic in self.acData) {
              
              Classfy *model=[[Classfy alloc]initWith:dic];
              [self.showArr addObject:model];
              
          }
      
          [self showPreviousSelectButton];
          [self.tableView reloadData];
      
      }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      ZPFLog(@"%@",error);
      
      [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
      
  }];
    
    
    
    
    
    
    
}


- (void)getToursData{
    
    
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    
    
    sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];

     [ProgressHUD show:@"别着急，让哥加载一会,着急，打死你！！！...." Interaction:YES];
    
    //typeid 21 景点旅行
    
    
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",KClassfy,@(_pageCount),@(23)] parameters:nil
               progress:^(NSProgress * _Nonnull downloadProgress) {
                   ZPFLog(@"%lld",downloadProgress.totalUnitCount);
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   
                   [ProgressHUD showSuccess:@"主人，我以为你备好数据"];

                   ZPFLog(@"%@",responseObject);
                   NSDictionary *dic=responseObject;
                   NSString *status=dic[@"status"];
                   NSInteger code=[dic[@"code"] integerValue];
                   
                   if ([status isEqualToString:@"success"] && code ==0) {
                       
                       NSDictionary *successDic=dic[@"success"];
                       //            ZPFLog(@"%@",successDic);
                       
                       self.acData =successDic[@"acData"];
                       
                       
                       if (self.refresh) {
                           if (self.toursArr.count>0) {
                               [self.toursArr removeAllObjects];
                           }
                       }
                       
                       
                       for (NSDictionary *dic in self.acData) {
                           
                           Classfy *model=[[Classfy alloc]initWith:dic];
                           [self.toursArr addObject:model];
                           
                       }
                       
                   }else{
                       
                       
                       
                   }
                   [self showPreviousSelectButton];
                   [self.tableView reloadData];
                   
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   ZPFLog(@"%@",error);
               }];
    

    
    
    
    
}


- (void)getStudyData{
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    
    
    sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
   [ProgressHUD show:@"别着急，让哥加载一会,着急，打死你！！！...." Interaction:YES];
    //typeid 22 学习益智
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",KClassfy,@(_pageCount),@(22)] parameters:nil
               progress:^(NSProgress * _Nonnull downloadProgress) {
                   ZPFLog(@"%lld",downloadProgress.totalUnitCount);
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   [ProgressHUD showSuccess:@"主人，我以为你备好数据"];

                   ZPFLog(@"%@",responseObject);
                   NSDictionary *dic=responseObject;
                   NSString *status=dic[@"status"];
                   NSInteger code=[dic[@"code"] integerValue];
                   
                   if ([status isEqualToString:@"success"] && code ==0) {
                       
                       NSDictionary *successDic=dic[@"success"];
                       //            ZPFLog(@"%@",successDic);
                       
                       self.acData =successDic[@"acData"];
                       
                       if (self.refresh) {
                           if (self.studyArr.count>0) {
                               [self.studyArr removeAllObjects];
                           }
                       }

                       
                       for (NSDictionary *dic in self.acData) {
                           
                           Classfy *model=[[Classfy alloc]initWith:dic];
                           [self.studyArr addObject:model];
                           
                       }
                       [self showPreviousSelectButton];
                     [self.tableView reloadData];
                   }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   ZPFLog(@"%@",error);
               }];

    
    
    
}
- (void)getFamilyData{
    
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    
    
    sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [ProgressHUD show:@"别着急，让哥加载一会,着急，打死你！！！...." Interaction:YES];
    //typeid 21 亲子旅行
    
    
    [sessionManager GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",KClassfy,@(_pageCount),@(21)] parameters:nil
               progress:^(NSProgress * _Nonnull downloadProgress) {
                   ZPFLog(@"%lld",downloadProgress.totalUnitCount);
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   [ProgressHUD showSuccess:@"主人，我以为你备好数据"];

                   
                   ZPFLog(@"%@",responseObject);
                   NSDictionary *dic=responseObject;
                   NSString *status=dic[@"status"];
                   NSInteger code=[dic[@"code"] integerValue];
                   
                   if ([status isEqualToString:@"success"] && code ==0) {
                       
                       NSDictionary *successDic=dic[@"success"];
                       //            ZPFLog(@"%@",successDic);
                       
                       self.acData =successDic[@"acData"];
                       
                       
                       if (self.refresh) {
                           if (self.familyArr.count>0) {
                               [self.familyArr removeAllObjects];
                           }
                       }

                       
                       for (NSDictionary *dic in self.acData) {
                           
                           Classfy *model=[[Classfy alloc]initWith:dic];
                           [self.familyArr addObject:model];
                           
                       }
                       
                   }else{
                       
                       
                       
                   }
                   
                   [self showPreviousSelectButton];
                   [self.tableView reloadData];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   ZPFLog(@"%@",error);
               }];
    

    
    
    
    
}


-(void)showPreviousSelectButton{
    
    
    
    if (self.refresh ) {
        if (self.showDataArr.count>0) {
            [self.showDataArr removeAllObjects];
        }
    }
    
    
    
    
    if (self.showDataArr.count >0) {
        [self.showDataArr removeAllObjects];
    }
    
    
    switch (self.classfylistType) {
        case ClassfyListTypeShowRepertoire:
        {
            self.showDataArr=self.showArr;
        }
            break;
        case ClassfyListTypeTouristPlace:
        {
            
            self.showDataArr=self.toursArr;
        }
            break;
        case ClassfyListTypeStudyPUZ:
        {
           
            self.showDataArr=self.studyArr;
        }
            break;
        case ClassfyListTypeFamilyTravel:
        {
            
            self.showDataArr=self.familyArr;
        }
            break;
            
        default:
            break;
    }
    
    //完成加载
    
    [self.tableView tableViewDidFinishedLoading];
    
    self.tableView.reachedTheEnd=NO;
    
    [self.tableView reloadData];
    
    
    [self.tableView reloadData];
    
}





#pragma mark ----上拉，下拉操作
-(void)configData{
    
    
}




#pragma mark ---- 懒加载

- (VOSegmentedControl *)segctrl1{
    if (_segctrl1 == nil) {
       
       self.segctrl1=[[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"演出剧目"},
            @{VOSegmentText: @"景点场馆"},
            @{VOSegmentText: @"学习益智"},
            @{VOSegmentText: @"亲子旅行"}]];
        self.segctrl1.textColor=[UIColor grayColor];
        self.segctrl1.selectedTextColor=[UIColor colorWithRed:0 green:185/255.0f blue:189/255.0f alpha:1.0];
        self.segctrl1.selectedIndicatorColor=[UIColor colorWithRed:0 green:185/255.0f blue:189/255.0f alpha:1.0];
        self.segctrl1.contentStyle = VOContentStyleTextAlone;
        self.segctrl1.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segctrl1.backgroundColor = [UIColor whiteColor];
        self.segctrl1.indicatorColor=[UIColor colorWithRed:0 green:185/255.0f blue:189/255.0f alpha:1.0];
        self.segctrl1.allowNoSelection = NO;
        self.segctrl1.frame = CGRectMake(0 , 0, KScreenWidth,44);
        
        
        self.segctrl1.selectedSegmentIndex=self.classfylistType-1;
        self.segctrl1.indicatorThickness = 4;
       
        
//        __block NSInteger selectIndex;
        [self.segctrl1 setIndexChangeBlock:^(NSInteger index) {
//            selectIndex=index;
            
            
//            NSLog(@"1: block --> %@", @(index));
        }];
        //self.classfylistType=selectIndex;
        [self.segctrl1 addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    
    return _segctrl1;
    
}


-(void)segmentCtrlValuechange:(VOSegmentedControl *)segmentCtrl{
    
   
    
    self.classfylistType=segmentCtrl.selectedSegmentIndex+1;
    
    [self chooseRequest];
    
    [self.tableView reloadData];
    
    
//    [self showPreviousSelectButton];
//    [self.tableView reloadData];
    

}





- (NSMutableArray *)showDataArr{
    
    if (_showDataArr == nil) {
       self.showDataArr=[[NSMutableArray alloc]init];
    }
    return _showDataArr;
}

- (NSMutableArray *)showArr{
    
    if (_showArr == nil) {
        self.showArr=[[NSMutableArray alloc]init];
    }
    return _showArr;
}

- (NSMutableArray *)familyArr{
    
    
    if (_familyArr == nil) {
        self.familyArr=[[NSMutableArray alloc]init];
        
    }
    return _familyArr;
}


- (NSMutableArray *)studyArr{
    
    
    if (_studyArr == nil) {
        self.studyArr =[[NSMutableArray alloc]init];
    }
    return _studyArr;
}








- (NSArray *)acData{
    
    if (_acData == nil) {
        _acData =[[NSArray alloc]init];
        
        
    }
    return _acData;
}








- (PullingRefreshTableView *)tableView{
    
    if (_tableView == nil) {
        self.tableView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 44, KScreenWidth, KScreenHeight) pullingDelegate:self];
        
        
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
    
    [self performSelector:@selector(configData) withObject:nil afterDelay:1.f];
}



//table开始下拉开始调用
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount=1;
    self.refresh=YES;
    
    [self performSelector:@selector(configData) withObject:nil afterDelay:1.0];
    
    
    
    
}


//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
   // NSLog(@"%s - [%d]",__FUNCTION__,__LINE__);
    
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
    
//    ZPFLog(@"%ld",self.allGroupArray.count);
    
    return self.showDataArr.count;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassfyTableViewCell *classfyCell=[self.tableView dequeueReusableCellWithIdentifier:@"classfyCell" forIndexPath:indexPath];
    
    
    classfyCell.model=self.showDataArr[indexPath.row];
    
    
    return classfyCell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *mainSB=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ActivityDetailViewController *activity=[mainSB instantiateViewControllerWithIdentifier:@"ActivityDetail"];
    
    Classfy *model=self.showDataArr[indexPath.row];
    activity.activityID=model.activityid;
    
    
    [self.navigationController pushViewController:activity animated:YES];
    
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
