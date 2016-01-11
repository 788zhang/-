//
//  HotTableViewCell.m
//  Happyholiday
//
//  Created by scjy on 16/1/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "HotTableViewCell.h"

@implementation HotTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CustomView];
    }
    
    return self;
}


-(void)CustomView{
    
    self.imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, KScreenWidth-20, 158)];
    
    self.imageview.layer.cornerRadius=3;
    
    [self addSubview:self.imageview];
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
