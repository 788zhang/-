//
//  Activity.h
//  Happyholiday
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Activity : UIView


@property (weak, nonatomic) IBOutlet UIButton *activityMap;

@property (weak, nonatomic) IBOutlet UIButton *activityPhone;

@property(nonatomic, strong) NSDictionary *dataDic;


@end
