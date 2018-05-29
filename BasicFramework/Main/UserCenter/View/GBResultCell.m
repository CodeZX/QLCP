//
//  GBResultCell.m
//  BasicFramework
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GBResultCell.h"


@interface GBResultCell ()
@property (weak, nonatomic) IBOutlet UILabel *specialistName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *user;

@end
@implementation GBResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setResultModel:(GBresultModel *)resultModel {
    
    _resultModel = resultModel;
    self.specialistName.text = resultModel.doctor;
    self.date.text = resultModel.date;
    self.user.text = resultModel.name;
}

@end
