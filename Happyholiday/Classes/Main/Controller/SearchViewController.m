//
//  SearchViewController.m
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property(nonatomic, strong) UITextField *textfiel;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"搜索";
    
    
    self.textfiel=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
    self.textfiel.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.textfiel];
    
    
    self.view.backgroundColor=[UIColor redColor];
    NSArray *arr=@[@"热门关键字",@"篮球",@"抢票",@"博物馆",@"滑雪",@"水上乐园",@"动物园",@"游泳",@"羽毛球",@"书法",@"采摘",@"北京",@"儿童剧",@"垂钓",@"活动",@"舞台剧",@"科技馆"];
    
    
    for (int i=0; i<4; i++) {
        for (int j=0; j<4; j++) {
            
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(KScreenWidth/4*j, 44+i*44, KScreenWidth/4, 44);
            [btn setTitle:arr[j+i] forState:UIControlStateNormal];
            btn.tag=i+j+1;
            [btn addTarget:self action:@selector(WriteTextfield:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:btn];
            
            if (btn.tag == 1) {
                [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                btn.userInteractionEnabled=NO;
                
            }
            
        }
    }
    
    
    
}




-(void)WriteTextfield:(UIButton *)btn{
    
    
    if (btn.tag != 1) {
        self.textfiel.text=btn.currentTitle;
        
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
