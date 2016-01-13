//
//  DisCover.m
//  Happyholiday
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DisCover.h"

@implementation DisCover


-(instancetype)initWithDic:(NSDictionary *)dic{
    self=[super self];
    
    if (self) {
        self.activityID=dic[@"id"];
        self.image=dic[@"image"];
        self.shareImage=dic[@"shareImage"];
        self.title=dic[@"title"];
        self.type=dic[@"type"];
    
    }
    
    return self;
    
}

@end
