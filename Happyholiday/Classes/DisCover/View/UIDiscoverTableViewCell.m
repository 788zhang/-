//
//  UIDiscoverTableViewCell.m
//  Happyholiday
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UIDiscoverTableViewCell.h"


@interface UIDiscoverTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;


@property (weak, nonatomic) IBOutlet UILabel *detailLabel;




@end

@implementation UIDiscoverTableViewCell






- (void)setModel:(DisCover *)model{
    
       
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    self.headImage.layer.cornerRadius=60;
    self.headImage.clipsToBounds=YES;
    
    
    self.detailLabel.text=model.title;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
