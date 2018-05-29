//
//  UserCenterTableViewCell.m
//  BasicFramework
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "UserCenterTableViewCell.h"
#import "UserCenterTableViewCellModel.h"

@interface UserCenterTableViewCell ()

@property (nonatomic,weak) UIImageView *leftImageView;
@property (nonatomic,weak) UILabel *titleLable;;
@property (nonatomic,weak) UIImageView *rightImageView;

@end

@implementation UserCenterTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier {
    
//    static NSString *Identifier = @"cell";
    UserCenterTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UserCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
    
    }
    
    return self;
}


- (void)setupUI {
    
    self.contentView.backgroundColor = WhiteColor;
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self.contentView addSubview:leftImageView];
    self.leftImageView = leftImageView;
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(15);
//        make.top.equalTo(self.contentView).offset(10);
//        make.right.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.backgroundColor = RandomColor;
    [self.contentView addSubview:titleLable];
    self.titleLable = titleLable;
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
       
    }];
    
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self.contentView addSubview:rightImageView];
    self.rightImageView = rightImageView;
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.contentView);
    }];
}


- (void)setModel:(UserCenterTableViewCellModel *)model {
    
    _model = model;
    self.titleLable.text = model.title;
}
@end
