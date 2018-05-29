//
//  UsersManager.m
//  BasicFramework
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "UsersManager.h"


@implementation UsersManager

+ (UsersManager *)sharedUsersManager {
    
    static UsersManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super alloc] init];
    });
    
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    return [UsersManager sharedUsersManager];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
   return [UsersManager sharedUsersManager];
}

- (NSArray<UserModel *> *)users {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *sqlFilePath = [docPath stringByAppendingPathComponent:@"Users.sqlite"];
    NSArray *usersArr = [NSArray arrayWithContentsOfFile:sqlFilePath];
    
    return usersArr;
}
- (BOOL)save {
    
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *sqlFilePath = [docPath stringByAppendingPathComponent:@"Users.sqlite"];
    
    return [self.users writeToFile:sqlFilePath atomically:NO];
    
}

@end
