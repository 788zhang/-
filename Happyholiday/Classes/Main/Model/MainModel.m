//
//  MainModel.m
//  Happyholiday
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel



-(instancetype)initWithDic:(NSDictionary *)dic{
    
    self=[super init];
    
    if (self) {
        
         self.type=dic[@"type"];
        //如果是推荐活动
        if ([self.type integerValue] ==RecommendTypeActivity) {
            
            self.price=dic[@"price"];
            self.lat=[dic[@"lat"] floatValue];
            self.lng=[dic[@"lng"] floatValue];
            self.counts=dic[@"counts"];
            self.entTime=dic[@"endTime"];
            self.startTime=dic[@"startTime"];
            
            
        }else{
            
            self.activityDescription=dic[@"description"]; 
            
            
        }
        
        self.image_big=dic[@"image_big"];
        self.title=dic[@"title"];
        self.activityID=dic[@"id"];
        
        
       
        
       
        
        
        
    }
    
    return self;
    
}


@end
