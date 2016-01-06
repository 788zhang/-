//
//  UIViewController+Common.m
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)

-(void)showBarButton{
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *legtbtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=legtbtn;
    
    
}


-(void)backButtonAction{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}



@end
