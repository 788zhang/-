//
//  ClassfyTableViewCell.m
//  Happyholiday
//
//  Created by scjy on 16/1/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ClassfyTableViewCell.h"


@interface ClassfyTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;


@property (weak, nonatomic) IBOutlet UILabel *activityTitle;

@property (weak, nonatomic) IBOutlet UILabel *activityAgeLable;

@property (weak, nonatomic) IBOutlet UILabel *activityPriceLable;



@property (weak, nonatomic) IBOutlet UILabel *activityDidPrice;



@end


@implementation ClassfyTableViewCell




- (void)setModel:(Classfy *)model{
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    self.activityTitle.text=model.title;
    
    self.activityPriceLable.text=model.price;
    
    self.activityAgeLable.text=model.age;
    
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
