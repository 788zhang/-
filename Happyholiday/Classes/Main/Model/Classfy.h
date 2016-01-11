//
//  Classfy.h
//  Happyholiday
//
//  Created by scjy on 16/1/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Classfy : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *counts;
@property(nonatomic, copy) NSString *age;
@property(nonatomic, copy) NSString *activityid;
@property(nonatomic, copy) NSString *endTime;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *label;
@property(nonatomic, copy) NSString *type;


- (instancetype )initWith:(NSDictionary *)dic;
@end
