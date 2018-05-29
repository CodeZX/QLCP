//
//  UsersManager.h
//  BasicFramework
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UsersManager : NSObject
@property (nonatomic,strong,readonly) NSArray <UserModel *> *users;
@property (nonatomic,strong,readonly) UserModel *currentUser;




+ (UsersManager *)sharedUsersManager;


- (void)signUp;
- (void)logIn;
- (void)logOut;
- (BOOL)save;

- (NSString *)provingCode;


@end
