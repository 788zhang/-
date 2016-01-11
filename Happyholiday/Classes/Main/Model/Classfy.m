//
//  Classfy.m
//  Happyholiday
//
//  Created by scjy on 16/1/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "Classfy.h"

@implementation Classfy


- (instancetype)initWith:(NSDictionary *)dic{
    self=[super init];
    
    if (self) {
        
        self.title=dic[@"title"];
        self.age=dic[@"age"];
        self.counts=dic[@"counts"];
        
        self.price=dic[@"price"];
        self.image=dic[@"image"];
        self.type=dic[@"type"];
        
        self.activityid=dic[@"id"];
        self.label=dic[@"lable"];
        self.endTime=dic[@"endTime"];

        
        
    }
    return self;
}

@end
