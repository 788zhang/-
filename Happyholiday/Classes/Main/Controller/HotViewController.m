//
//  HotViewController.m
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "HotViewController.h"
#import "HotTableViewCell.h"
#import "ThemeViewController.h"

@interface HotViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *imgArray;
@property(nonatomic, strong) NSMutableArray *iDArray;



@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showBarButton];
    self.navigationItem.title=@"热门专题";
    self.view.backgroundColor=[UIColor redColor];
    
    [self configData];
    
    
    
}

//网络请求

-(void)configData{
    
    
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc]init];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [manager GET:[NSString stringWithFormat:@"%@",KactivityHot] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        ZPFLog(@"%@",responseObject);
        
        NSDictionary *rootDic=responseObject;
        
        NSString *status=rootDic[@"status"];
        NSInteger code=[rootDic[@"code"] integerValue];
        
        if ([status isEqualToString:@"success"] && code == 0) {
            
            NSDictionary *successDic=rootDic[@"success"];
            
            NSArray *arr=successDic[@"rcData"];
            
            for (NSDictionary *dic in arr) {
                
                [self.imgArray addObject:dic[@"img"]];
                [self.iDArray addObject:dic[@"id"]];
                
            }
            
            [self.view addSubview:self.tableView];
            [self.tableView reloadData];
            
            
            
        }else{
            
            NSLog(@"解析失败");
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"%@",error);
    }];
    
    
    
    
}




//懒加载


- (NSMutableArray *)iDArray{
    
    if (_iDArray == nil) {
        _iDArray =[[NSMutableArray alloc]init];
        
    
    }
    return _iDArray;
}

- (NSMutableArray *)imgArray{
    
    if (_imgArray == nil) {
        self.imgArray=[[NSMutableArray alloc]init];
    }
 
    return _imgArray;
}



- (UITableView *)tableView{
    
    
    if (_tableView == nil) {
        _tableView =[[UITableView alloc]initWithFrame:self.view.frame];
        
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight=168;
        
    }
    return  _tableView;
}



#pragma mark --- UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return self.imgArray.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     static NSString *str=@"zhang";
    HotTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell=[[HotTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"zhang"];
    }
    
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:self.imgArray[indexPath.row]] placeholderImage:nil];
    
    return cell;
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ThemeViewController *them=[[ThemeViewController alloc]init];
    
    them.themId=self.iDArray[indexPath.row];
    
    them.hidesBottomBarWhenPushed=YES;

    
    [self.navigationController pushViewController:them animated:YES];
    
    
    
    
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
