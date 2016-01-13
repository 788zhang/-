//
//  GoodActiivityTableViewCell.m
//  Happyholiday
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "GoodActiivityTableViewCell.h"


@interface GoodActiivityTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *activityTitleLable;


@property (weak, nonatomic) IBOutlet UILabel *activityDistanceLable;


@property (weak, nonatomic) IBOutlet UILabel *activityAgeLable;


@property (weak, nonatomic) IBOutlet UILabel *activityPriceLable;

@property (weak, nonatomic) IBOutlet UIButton *activityLoveCountBtn;


@property (weak, nonatomic) IBOutlet UIView *GoodAcitvityView;

@property(nonatomic, strong) NSString *btnTitle;



@end

@implementation GoodActiivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
   self.frame=CGRectMake(0, 0, KScreenWidth, 90);
    
}



- (void)setModel:(GoodActivityModel *)model{
    
    
    self.activityTitleLable.text=model.title;
    self.activityPriceLable.text=model.price;
    self.headImage.layer.cornerRadius=35;
    self.headImage.clipsToBounds=YES;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    self.activityDistanceLable.text=@"694.52km";
    
    self.activityAgeLable.text=model.age;
    self.activityPriceLable.text=model.price;
    
    
//    self.btnTitle=model.counts;
    
//    [self.activityLoveCountBtn setTitle:self.btnTitle forState:UIControlStateNormal];
    
    
    
    

    
        
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
