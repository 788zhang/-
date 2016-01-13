//
//  SetViewController.m
//  Happyholiday
//
//  Created by scjy on 16/1/13.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "SetViewController.h"
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"
@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate>
@property(nonatomic, strong) NSMutableArray *titleArr;
@property(nonatomic, strong) NSArray *imageArr;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showBarButton];
    self.navigationItem.title=@"设置";
    
    
    self.view.backgroundColor=[UIColor redColor];
    
//  self.imageArr=@[@"icon_like",@"icon_shop" ,@"icon_user",@"icon_ele",@"icon_ac"];
    self.titleArr=[[NSMutableArray alloc]initWithObjects:@"清除缓存",@"用户反馈",@"分享给好友",@"给我评分",@"当前版本1.0", nil];
    [self.view addSubview:self.tableView];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    SDImageCache *cache=[SDImageCache sharedImageCache];
    NSInteger cacheSize=[cache getSize];
    NSString *cacheStr=[NSString stringWithFormat:@"缓存大小(%.2fM)",(float)(cacheSize/1024/1024)];
    
    [self.titleArr replaceObjectAtIndex:0 withObject:cacheStr];
    
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationLeft];
    
    
  

    
    
}


#pragma mark ----发送邮件

//邮件发送方法:
-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    //设置主题
    [picker setSubject:@"用户反馈"];
    
    //设置收件人
    NSArray *receive = [NSArray arrayWithObjects:@"850944623@qq.com",
                             nil];
    
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"1342236145@qq.com",nil];
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"1342236145@qq.com",
                              nil];
    
    [picker setToRecipients:receive];
    [picker setCcRecipients:ccRecipients];
    [picker setBccRecipients:bccRecipients];
    

    // 设置邮件发送内容
    NSString *emailBody = @"请反馈你宝贵的意见，让我们继续改进";
    [picker setMessageBody:emailBody isHTML:NO];
    
    //邮件发送的模态窗口
    [self presentViewController:picker animated:YES completion:nil];
}

//邮件发送完成调用的方法:


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: //取消
            NSLog(@"MFMailComposeResultCancelled-取消");
            break;
        case MFMailComposeResultSaved: // 保存
            NSLog(@"MFMailComposeResultSaved-保存邮件");
            break;
        case MFMailComposeResultSent: // 发送
            NSLog(@"MFMailComposeResultSent-发送邮件");
            break;
        case MFMailComposeResultFailed: // 尝试保存或发送邮件失败
            NSLog(@"MFMailComposeResultFailed: %@...",[error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}







#pragma mark ----懒加载
- (UITableView *)tableView{
    
    if (_tableView== nil) {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
    }
    
    return _tableView;
}





#pragma mark -----UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *strID=@"zhang";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strID];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strID];
        
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.imageView.image=[UIImage imageNamed:self.imageArr[indexPath.row]];
    cell.textLabel.text=self.titleArr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
     return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
//            NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES));
//            
            
            
            UIAlertController *aler=[UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要清除缓存？" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionAletOK=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
                
                SDImageCache *cache=[SDImageCache sharedImageCache];
                [cache clearDisk];
                
                NSInteger cacheSize=[cache getSize];
                
                NSString *cacheStr=[NSString stringWithFormat:@"清除缓存（%.2fM）",(float)cacheSize/1024/1024];
                
                [self.titleArr replaceObjectAtIndex:0 withObject:cacheStr];
                
                NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
                
                [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationLeft];
                
                
            }];
            UIAlertAction *actionAletCancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            
            [aler addAction:actionAletOK];
            [aler addAction:actionAletCancel];
            
            [self presentViewController:aler animated:YES completion:nil];
            
            
            
            
            
            

            
            
            
            
        }
            break;
        case 1:
        {
            //发送邮件
            [self displayComposerSheet];
            
            
            
            
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
            //app评分
            NSString *str = [NSString stringWithFormat:
                             
                             @"itms-apps://itunes.apple.com/app"];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
            
            
        }
            break;
        case 4:
        {
            //检测当前版本
            
            [ProgressHUD show:@"正在检测" Interaction:YES];
            [self performSelector:@selector(checkAppVersion) withObject:nil afterDelay:2.0];
            
            
            
            
            
            
            
            
        }
            break;
            
        default:
            break;
    }

    
    
    
}



-(void)checkAppVersion{
    
    [ProgressHUD showSuccess:@"你已经是最新版本"];
    
    
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
