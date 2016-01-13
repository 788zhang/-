//
//  DisCover.h
//  Happyholiday
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisCover : NSObject

@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *shareImage;
@property(nonatomic, copy) NSString *activityID;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *type;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
