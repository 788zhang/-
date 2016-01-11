//
//  Activity.m
//  Happyholiday
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "Activity.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface Activity ()

{
    //保存上一次图片底部的高度
    CGFloat _previousImageBottom;
    
    CGFloat _lastLabelBottom;
    
    CGFloat _lastViewheight;
    
    
}


@property (weak, nonatomic) IBOutlet UIImageView *headImage;


@property (weak, nonatomic) IBOutlet UILabel *activityTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *activityTimeLable;

@property (weak, nonatomic) IBOutlet UILabel *favourLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroller;

@property (weak, nonatomic) IBOutlet UILabel *activityAdressLable;

@property (weak, nonatomic) IBOutlet UILabel *activityPhoneLable;

@property (weak, nonatomic) IBOutlet UILabel *activityPriceLable;

@property(nonatomic, strong) NSString *WarmStr;

@end


@implementation Activity



- (void)awakeFromNib{
    
     self.mainScroller.contentSize=CGSizeMake(KScreenWidth, 10000);
    
}



/**
 *  setter方法
 *
 *  @param dataDic 在data中传值
 */
- (void)setDataDic:(NSDictionary *)dataDic{
    
    
    self.WarmStr=dataDic[@"reminder"];
    
    //活动图片
    NSArray *urls=dataDic[@"urls"];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:urls[0]]placeholderImage:nil];

    //活动标题
    self.activityTitleLable.text=dataDic[@"title"];
    self.favourLabel.text=[NSString stringWithFormat:@"%@人以收藏",dataDic[@"fav"]];
    
    
    //活动起始时间
    NSString *startTime=dataDic[@"new_start_date"];
    NSString *endTime=dataDic[@"new_end_date"];
    
      
    self.activityTimeLable.text=[NSString stringWithFormat:@"正在进行：%@_%@",[HWTools getDateFromString:startTime],[HWTools getDateFromString:endTime]];
    
    self.activityPriceLable.text=[NSString stringWithFormat:@"参考价格：%@",dataDic[@"pricedesc"]];
    
    
    self.activityAdressLable.text=dataDic[@"address"];
    
    self.activityPhoneLable.text=dataDic[@"tel"];
    
    //活动详情
    
    [self drawContentWithArray:dataDic[@"content"]];
    
     self.mainScroller.contentSize=CGSizeMake(KScreenWidth,_lastLabelBottom+60 +10 + 64+_lastViewheight);
    
   
    
    
    
}

- (void)drawContentWithArray:(NSArray *)contentArray {
    for (NSDictionary *dic in contentArray) {
        //每一段活动信息
        
       
        CGFloat height = [HWTools getTextHeightWithText:dic[@"description"] bigSize:CGSizeMake(KScreenWidth, 1000) textFont:15.0];
        CGFloat y;
        if (_previousImageBottom > 430) { //如果图片底部的高度没有值（也就是小于430）,也就说明是加载第一个lable，那么y的值不应该减去430
            y = 500 + _previousImageBottom - 500;
        } else {
            y = 430 + _previousImageBottom;
        }
        NSString *title = dic[@"title"];
        if (title != nil) {
            //如果标题存在,标题的高度应该是上次图片的底部高度
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, y, KScreenWidth - 20, 30)];
            titleLabel.text = title;
            [self.mainScroller addSubview:titleLabel];
            //下边详细信息label显示的时候，高度的坐标应该再加30，也就是标题的高度。
            y += 30;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, KScreenWidth - 20, height)];
        label.text = dic[@"description"];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15.0];
        [self.mainScroller addSubview:label];
        //保留最后一个label的高度，+ 64是下边tabbar的高度
        _lastLabelBottom = label.bottom + 10 + 64;
        
        NSArray *urlsArray = dic[@"urls"];
        if (urlsArray == nil) { //当某一个段落中没有图片的时候，上次图片的高度用上次label的底部高度+10
            _previousImageBottom = label.bottom + 10;
        } else {
            CGFloat lastImgbottom = 0.0;
            for (NSDictionary *urlDic in urlsArray) {
                CGFloat imgY;
                if (urlsArray.count > 1) {
                    //图片不止一张的情况
                    if (lastImgbottom == 0.0) {
                        if (title != nil) { //有title的算上title的30像素
                            imgY = _previousImageBottom + label.height + 30 + 5;
                        } else {
                            imgY = _previousImageBottom + label.height + 5;
                        }
                    } else {
                        imgY = lastImgbottom + 10;
                    }
                    
                } else {
                    //单张图片的情况
                    imgY = label.bottom;
                }
                CGFloat width = [urlDic[@"width"] integerValue];
                CGFloat imageHeight = [urlDic[@"height"] integerValue];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, imgY, KScreenWidth - 20, (KScreenWidth - 20)/width * imageHeight)];
                imageView.backgroundColor = [UIColor redColor];
                [imageView sd_setImageWithURL:[NSURL URLWithString:urlDic[@"url"]] placeholderImage:nil];
                [self.mainScroller addSubview:imageView];
                //每次都保留最新的图片底部高度
                _previousImageBottom = imageView.bottom + 5;
                if (urlsArray.count > 1) {
                    lastImgbottom = imageView.bottom;
                }
            }
        }
    }
    
    
    
    UILabel *warmlable=[[UILabel alloc]initWithFrame:CGRectMake(10, _lastLabelBottom, KScreenWidth-20, 30)];
    warmlable.textColor=[UIColor redColor];
    
    warmlable.text=@"温馨提示:";
    
    [self.mainScroller addSubview:warmlable];
    
    _lastViewheight= [HWTools getTextHeightWithText:self.WarmStr bigSize:CGSizeMake(KScreenWidth, 10000) textFont:15.0];
    
    UILabel *warmlableqq=[[UILabel alloc]initWithFrame:CGRectMake(10, _lastLabelBottom+60, KScreenWidth-20, _lastViewheight)];
    
    ZPFLog(@"%@",self.WarmStr);
    warmlableqq.text=self.WarmStr;
    warmlableqq.numberOfLines=0;
    
    warmlableqq.font=[UIFont systemFontOfSize:15.0];
    
    [self.mainScroller addSubview:warmlableqq];
    
  
    


    
    
    
    
    
}



@end
