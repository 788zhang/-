//
//  MainModel.h
//  Happyholiday
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum{
    
    RecommendTypeActivity=1,//推荐活动
    RecommendTypeTheme //推荐专题
    
    
}RecommendType;

@interface MainModel : NSObject
//首页大图
@property(nonatomic, retain) NSString *image_big;
//价格
@property(nonatomic, retain) NSString *price;
//标题
@property(nonatomic, retain) NSString *title;
//经纬度

@property(nonatomic, assign) CGFloat  lat;
@property(nonatomic, assign) CGFloat  lng;




//地址
@property(nonatomic, retain) NSString *address;
@property(nonatomic, retain) NSString *counts;
@property(nonatomic, retain) NSString *startTime;
@property(nonatomic, retain) NSString *entTime;
@property(nonatomic, retain) NSString *type;
@property(nonatomic, retain) NSString *activityID;



@property(nonatomic, copy) NSString *activityDescription;



-(instancetype)initWithDic:(NSDictionary *)dic;




@end
