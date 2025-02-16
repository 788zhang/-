//
//  ActivityThem.m
//  Happyholiday
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ActivityThem.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ActivityThem ()

{
    //保存上一次图片底部的高度
    CGFloat _previousImageBottom;
    
    CGFloat _lastLabelBottom;
    
    CGFloat _lastViewheight;
    
    
}

@property(nonatomic, strong) UIScrollView *mainScrollView;
@property(nonatomic, retain) UIImageView *headImageView;


@end

@implementation ActivityThem


- (instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self CustomView];
    }
    
    return self;
}
-(void)CustomView{
    
    
    [self addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headImageView];
    
    
    
    
    
}

//在setter中赋值

- (void)setDataDic:(NSDictionary *)dataDic{
    
    
    NSLog(@"%@",dataDic);
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"image"]] placeholderImage:nil];
    
    
    [self drawContentWithArray:dataDic[@"content"]];
    
    self.mainScrollView.contentSize=CGSizeMake(KScreenWidth,_lastLabelBottom);

    
    
    
}


- (void)drawContentWithArray:(NSArray *)contentArray {
    for (NSDictionary *dic in contentArray) {
        //每一段活动信息
        
        
        CGFloat height = [HWTools getTextHeightWithText:dic[@"description"] bigSize:CGSizeMake(KScreenWidth, 1000) textFont:15.0];
        CGFloat y;
        if (_previousImageBottom > 186) { //如果图片底部的高度没有值（也就是小于430）,也就说明是加载第一个lable，那么y的值不应该减去430
            y = 500 + _previousImageBottom - 500;
        } else {
            y = 186 + _previousImageBottom;
        }
        NSString *title = dic[@"title"];
        if (title != nil) {
            //如果标题存在,标题的高度应该是上次图片的底部高度
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, y, KScreenWidth - 20, 30)];
            titleLabel.text = title;
            [self.mainScrollView addSubview:titleLabel];
            //下边详细信息label显示的时候，高度的坐标应该再加30，也就是标题的高度。
            y += 30;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, KScreenWidth - 20, height)];
        label.text = dic[@"description"];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15.0];
        [self.mainScrollView addSubview:label];
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
                [self.mainScrollView addSubview:imageView];
                //每次都保留最新的图片底部高度
                _previousImageBottom = imageView.bottom + 5;
                if (urlsArray.count > 1) {
                    lastImgbottom = imageView.bottom;
                }
            }
        }
        
        _lastLabelBottom=label.bottom > _previousImageBottom ? label.bottom+70:_previousImageBottom+70;
        
        
        
    }
  
    
}



- (UIScrollView *)mainScrollView{
    
    if (_mainScrollView == nil) {
        self.mainScrollView=[[UIScrollView alloc]initWithFrame:self.frame];
       
        
    }
    return _mainScrollView;
}



- (UIImageView *)headImageView{
    
    if (_headImageView== nil) {
        self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 186)];
        
        
        
        
        
        
    }
    return _headImageView;
}




@end
