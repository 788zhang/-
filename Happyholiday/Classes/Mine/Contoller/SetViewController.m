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
#import "WeiboSDK.h"
#import "AppDelegate.h"
@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,WBHttpRequestDelegate>
@property(nonatomic, strong) NSMutableArray *titleArr;
@property(nonatomic, strong) NSArray *imageArr;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *shareView;
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
            
            //分享
            
            [self CustomshareView];
            
            
            
            
            
            
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


#pragma mark ----分享视图


-(void)CustomshareView{
    
    UIWindow *window=[[UIApplication sharedApplication].delegate window];
    
    
    self.shareView=[[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-200, KScreenWidth, 200)];
    
    
    self.shareView.backgroundColor=[UIColor redColor];
    [window addSubview:self.shareView];
    
    
    
    [UIView animateWithDuration:1.0 animations:^{
        
        
        //微博授权
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame=CGRectMake(50,10, 50,50);
        
        [btn setImage:[UIImage imageNamed:@"ic_com_weibo"] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(shareWb) forControlEvents:UIControlEventTouchUpInside];
        
        [self.shareView addSubview:btn];
        
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 70, 30)];
        label.text=@"微博分享";
        label.textColor=[UIColor blackColor];
        [self.shareView addSubview:label];
        
        
        
        
        //微博取消授权
        UIButton *btnCancelAuthorize=[UIButton buttonWithType:UIButtonTypeCustom];
        
        btnCancelAuthorize.frame=CGRectMake(50, 120, 50,50);
        
        [btnCancelAuthorize setImage:[UIImage imageNamed:@"ic_com_weibo"] forState:UIControlStateNormal];
        
        [btnCancelAuthorize addTarget:self action:@selector(CancelWBAuthorize) forControlEvents:UIControlEventTouchUpInside];
        
        [self.shareView addSubview:btnCancelAuthorize];
        

        UILabel *labelCancel=[[UILabel alloc]initWithFrame:CGRectMake(20, 170, 100, 30)];
        labelCancel.text=@"微博取消授权";
        labelCancel.font=[UIFont systemFontOfSize:16];
        labelCancel.textColor=[UIColor blackColor];
        [self.shareView addSubview:labelCancel];
        
        
        
        //微信
        
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        
        btn1.frame=CGRectMake(150, 10, 50, 50);
        
        [btn1 setImage:[UIImage imageNamed:@"icon_weixin"] forState:UIControlStateNormal];
        
        [btn1 addTarget:self action:@selector(shareWX) forControlEvents:UIControlEventTouchUpInside];
        
        [self.shareView addSubview:btn1];
        
        UILabel *labelWX=[[UILabel alloc]initWithFrame:CGRectMake(135, 60, 70, 30)];
        labelWX.text=@"微信分享";
        labelWX.textColor=[UIColor blackColor];
        [self.shareView addSubview:labelWX];

        
        
        
        //微信朋友圈
        
        UIButton *btnCancelWX=[UIButton buttonWithType:UIButtonTypeCustom];
        
        btnCancelWX.frame=CGRectMake(150, 120, 50, 50);
        
        [btnCancelWX setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        
        [btnCancelWX addTarget:self action:@selector(CancelshareWX) forControlEvents:UIControlEventTouchUpInside];
        
        [self.shareView addSubview:btnCancelWX];
        
        UILabel *labelCancelWX=[[UILabel alloc]initWithFrame:CGRectMake(135, 170, 110, 30)];
        labelCancelWX.text=@"朋友圈";
        labelCancelWX.textColor=[UIColor blackColor];
        [self.shareView addSubview:labelCancelWX];
        
        
        
        //removeView
        
      
        
        UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        
        btn2.frame=CGRectMake(250, 40, 70, 70);
        
        [btn2 setTitle:@"取消" forState:UIControlStateNormal];
        [btn2 setTintColor:[UIColor blackColor]];
        [btn2 addTarget:self action:@selector(cleanView) forControlEvents:UIControlEventTouchUpInside];
        
        [self.shareView addSubview:btn2];

        
        
        
        
    }];
    
    
    
    
}

//版本请求成功
-(void)checkAppVersion{
    
    [ProgressHUD showSuccess:@"你已经是最新版本"];
    
    
}




#pragma mark ----分享的按钮方法


-(void)cleanView{
    
    [self.shareView removeFromSuperview];
    
    
}

#pragma mark ----微博分享
-(void)shareWb{
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
    

    
}

//分享数据
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = @"微博分享";
    
    
    
    
    return message;
}


//取消授权
- (void)CancelWBAuthorize{
    
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:nil];

    
}



#pragma mark ----微信分享
//
-(void)shareWX{
    
    
    SendMessageToWXReq* req =[[SendMessageToWXReq alloc] init];
    req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
    req.bText = YES;
    //微信好友
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];

    
    
    
    
}
-(void)CancelshareWX{
    
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@""]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"60" ofType:@".jpg"];

    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    
    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    
    //朋友圈
    req.scene =WXSceneTimeline;
    
    [WXApi sendReq:req];

    
    
    
    
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
