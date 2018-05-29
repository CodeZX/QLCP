//
//  UserCenterTableViewCellModel.h
//  BasicFramework
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^action)(id cell);

@interface UserCenterTableViewCellModel : NSObject

@property (nonatomic,copy) NSString *leftImageName;
@property (nonatomic,copy)  NSString *title;
@property (nonatomic,copy) NSString *rightName;
@property (nonatomic,copy) action actionBlock;
- (UserCenterTableViewCellModel *)initWithLeftImageName:(NSString *)leftImageName RightName:(NSString *)rightName  Title:(NSString *)title ActionBlock:(action)actionBlock;

- (UserCenterTableViewCellModel *)initWithLeftName:(NSString *)LeftName  Title:(NSString *)title;

- (UserCenterTableViewCellModel *)initWithTitle:(NSString *)title;

- (UserCenterTableViewCellModel *)initWithRightName:(NSString *)rightName Title:(NSString *)title ActionBlock:(action)actionBlock;
@end


