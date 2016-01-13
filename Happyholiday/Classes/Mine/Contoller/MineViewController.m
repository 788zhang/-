//
//  MineViewController.m
//  
//
//  Created by scjy on 16/1/4.
//
//

#import "MineViewController.h"

#import "SetViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIButton *headImageBtn;

@property(nonatomic, strong) UILabel *nikeNameLabel;

//cell  的数据
@property(nonatomic, strong) NSArray *imageArr;
@property(nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor=RGB(96, 185, 185);
    
    self.tableView.bounces=NO;
    [self.view addSubview:self.tableView];
    [self tableHeadView];
    
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame=CGRectMake(0, 0, 30, 200);
    [btn addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"home_recommed_ac"] forState:UIControlStateNormal];
    //导航栏上navigationItem
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    

    
    
    
   
    
    
}

#pragma mark ---- 自定义tableView头部










- (void)tableHeadView{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 210)];
    
    view.backgroundColor=RGB(96, 185, 185);
    [view addSubview:self.headImageBtn];
    
    [view addSubview:self.nikeNameLabel];
    
    self.tableView.tableHeaderView=view;
    
    
    
    
}



#pragma mark -----自定义方法
/**
 *  登陆注册按钮
 */
- (void)login{
    
    
    
    
}

//设置按钮

- (void)set{
    
    SetViewController *set=[[SetViewController alloc]init];
    
    [self.navigationController pushViewController:set animated:YES];
    
    
}










#pragma mark ---- 懒加载


- (UILabel *)nikeNameLabel{
    
    
    if (_nikeNameLabel == nil) {
        self.nikeNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(35+KScreenWidth/3, KScreenWidth/6+11 , KScreenWidth*2/3, 44)];
        
        self.nikeNameLabel.text=@"欢迎来到骑车去旅行";
        self.nikeNameLabel.textColor=[UIColor whiteColor];
    }
    return _nikeNameLabel;
}



- (UIButton *)headImageBtn{
    
    
    if (_headImageBtn == nil) {
        self.headImageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.headImageBtn.frame=CGRectMake(20, 30, KScreenWidth/3, KScreenWidth/3);
        self.headImageBtn.layer.cornerRadius=KScreenWidth/6;
        self.headImageBtn.clipsToBounds=YES;
        [self.headImageBtn setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [self.headImageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.headImageBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.headImageBtn.backgroundColor=[UIColor whiteColor];

    }
    return _headImageBtn;
}



- (UITableView *)tableView{
    
    if (_tableView== nil) {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        
        
        
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        
        
        
        
        
    }
    
    return _tableView;
}






#pragma mark ----UITableViewDelegate,UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 20;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *strID=@"zhang";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strID];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strID];
        
    }
    
    cell.imageView.image=[UIImage imageNamed:@"icon_like"];
    cell.textLabel.text=@"我的资料";
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
             break;
        case 1:
       
            ZPFLog(@"zhang");
        
            break;
        case 2:
       
            ZPFLog(@"zhang");
      
            
            break;
        case 3:
      
        ZPFLog(@"zhang");
            break;
        case 4:
        
            
        ZPFLog(@"zhang");
            break;
            
        default:
            break;
    }
    
    
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
