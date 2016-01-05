//
//  MainTableViewCell.m
//  Happyholiday
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MainTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainTableViewCell ()
//活动图片
@property (weak, nonatomic) IBOutlet UIImageView *activityPicture;
//活动名字
@property (weak, nonatomic) IBOutlet UILabel *activityNameLable;
//活动价钱
@property (weak, nonatomic) IBOutlet UILabel *activityPriceLable;

//活动距离
@property (weak, nonatomic) IBOutlet UIButton *activityDistanceBtn;



@end

@implementation MainTableViewCell







//setter
- (void)setModel:(MainModel *)model{
    
    [self.activityPicture sd_setImageWithURL:[NSURL URLWithString:model.image_big] placeholderImage:nil];
    
    
    self.activityNameLable.text=model.title;
    self.activityPriceLable.text=model.price;

    
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
