//
//  UserCenterTableViewCellModel.m
//  BasicFramework
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "UserCenterTableViewCellModel.h"

@interface UserCenterTableViewCellModel ()



@end
@implementation UserCenterTableViewCellModel
- (UserCenterTableViewCellModel *)initWithLeftImageName:(NSString *)leftImageName RightName:(NSString *)rightName Title:(NSString *)title ActionBlock:(action)actionBlock {
    
    self = [super init];
    if (self) {
        self.leftImageName = leftImageName;
        self.rightName = rightName;
        self.title = title;
        self.actionBlock = actionBlock;
    }
    
    return  self;
}

- (UserCenterTableViewCellModel *)initWithTitle:(NSString *)title {
    
    return [self initWithLeftImageName:nil RightName:nil Title:title ActionBlock:nil];
}

- (UserCenterTableViewCellModel *)initWithLeftName:(NSString *)LeftName Title:(NSString *)title {
    
    return [self initWithLeftImageName:LeftName RightName:nil Title:title ActionBlock:nil];
}

- (UserCenterTableViewCellModel *)initWithRightName:(NSString *)rightName Title:(NSString *)title ActionBlock:(action)actionBlock {
    
    return [self initWithLeftImageName:nil RightName:rightName Title:title ActionBlock:actionBlock];
}
@end
