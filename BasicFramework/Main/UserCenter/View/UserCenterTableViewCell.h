//
//  UserCenterTableViewCell.h
//  BasicFramework
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class UserCenterTableViewCellModel;

@interface UserCenterTableViewCell : UITableViewCell

@property (nonatomic,strong) UserCenterTableViewCellModel *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier;

@end

















