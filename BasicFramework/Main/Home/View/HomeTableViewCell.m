//
//  HomeTableViewCell.m
//  BasicFramework
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "HomeTableViewCell.h"


#define EDGE_LEFT 20
#define EDGE_RIGHT 20
#define EDGE_TOP 20
#define EDGE_BOTTOM 20


static NSString *Identifier = @"HomeCell";

@interface HomeTableViewCell    ()

@property (nonatomic,weak) UIImageView *contentImg;
@property (nonatomic,weak) UILabel *MainTitleLb;
@property (nonatomic,weak) UILabel *subheadTitleLb;
@property (nonatomic,weak) UIImageView   *indicateImg;

@end

@implementation HomeTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier {
    
    if(!tableView || !identifier || [identifier isEqualToString:@""]) {  identifier = Identifier; }
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) {
        
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *contentImg = [UIImageView new];
    contentImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:contentImg];
    self.contentImg = contentImg;
    [contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(EDGE_TOP);
        make.left.equalTo(self.contentView).offset(EDGE_LEFT);
        make.size.equalTo(CGSizeMake(44,44));
    }];
    
    UILabel  *MainTitleLb = [UILabel new];
    MainTitleLb.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:MainTitleLb];
    self.MainTitleLb = MainTitleLb;
    [MainTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(EDGE_TOP);
        make.centerX.equalTo(self.contentView);
//        make.size.equalTo(CGSizeMake(22,22));
    }];
    self.MainTitleLb.text = @"主标题";
    
    UILabel  *subheadTitleLb = [UILabel new];
    subheadTitleLb.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:subheadTitleLb];
    self.subheadTitleLb = subheadTitleLb;
    [subheadTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.MainTitleLb.bottom).offset(10);
        make.centerX.equalTo(self.contentView);
//        make.size.equalTo(CGSizeMake(22,22));
    }];
    self.subheadTitleLb.text = @"副标题";
    
    UIImageView *indicateImg = [UIImageView new];
    indicateImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:indicateImg];
    self.indicateImg = indicateImg;
    [indicateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(EDGE_TOP);
        make.right.equalTo(self.contentView).offset(-EDGE_RIGHT);
        make.size.equalTo(CGSizeMake(22,22));
    }];
   
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
