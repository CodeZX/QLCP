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
//@property (nonatomic,strong,readonly) NSArray <UserModel *> *users;
@property (nonatomic,strong,readonly) UserModel *currentUser;

WMSingletonH(usersManager)


//+ (UsersManager *)sharedUsersManager;


- (void)signUp;
- (void)logInName:(NSString *)name Password:(NSString *)password completionHandler:(void (^)(BOOL error ,NSString *message))completionHandler;
- (void)logOut;
- (BOOL)saveUserModel:(UserModel *)userModel;
- (void)update;
- (void)setPortrait:(UIImage *)image;



- (NSString *)provingCode;


@end
