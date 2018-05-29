//
//  UsersManager.m
//  BasicFramework
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "UsersManager.h"
#import "NetWorkManagerTwo.h"

@interface UsersManager ()

//@property (nonatomic,strong) NSMutableArray *userAry;


@property (nonatomic,strong) UserModel *userModel;
@property (nonatomic,strong) NSString *filePath;

@end

@implementation UsersManager

WMSingletonM(usersManager)

- (void)logInName:(NSString *)name Password:(NSString *)password completionHandler:(void (^)(BOOL, NSString *))completionHandler {

    if (!name.length || !password.length) {return;}
   
    NSDictionary *parametersDic = @{
                                    @"username":name,
                                    @"userpwd":password
                                };
    
    [[AFHTTPSessionManager manager] GET:@"http://47.93.28.161:8080/news/api/zx/login" parameters:parametersDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue] == 200) {
            UserModel *userModel = [[UserModel alloc]init];
           userModel.name = name;
            userModel.ID = name;
            userModel.token = @"1";
            userModel.imageData  = self.userModel.imageData;
            [self saveUserModel:userModel];
            completionHandler(YES,@"登录成功");
        }else {
            
            completionHandler(NO,@"登录失败");
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         completionHandler(NO,@"登录失败");
    }];
    
}

- (void)logOut {
    
    self.userModel.token = @"0";
    [self save];
}

- (void)save {
    
    [self saveUserModel:self.userModel];
}

- (BOOL)saveUserModel:(UserModel *)userModel {
    
   
    if ([NSKeyedArchiver archiveRootObject:userModel toFile:self.filePath]) {
        
        self.userModel = userModel;
        return YES;
    }
    return NO;
    
}

- (void)setPortrait:(UIImage *)image {
    
    self.userModel.imageData = UIImageJPEGRepresentation(image, 1);
    [self save];
}


- (UserModel *)currentUser {
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
//    NSString *sqlFilePath = [docPath stringByAppendingPathComponent:@"Users.sqlite"];
//    NSMutableArray *usesModel =[NSKeyedUnarchiver unarchiveObjectWithFile:sqlFilePath];
//
//    return usesModel.lastObject;
    
    return self.userModel;
}
#pragma mark -------------------------- lazy load ----------------------------------------

- (NSString *)filePath {
    if (!_filePath) {
        
         NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        _filePath = [docPath stringByAppendingPathComponent:@"User.text"];
    }
    
    return _filePath;
}

- (UserModel *)userModel {
    
    if (!_userModel) {
        
        _userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
    }
    
    return _userModel;
}
//- (NSArray<UserModel *> *)users {

//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
//    NSString *sqlFilePath = [docPath stringByAppendingPathComponent:@"Users.sqlite"];
//    //    NSArray *usersArr = [NSArray arrayWithContentsOfFile:sqlFilePath];
//    NSMutableArray *usersArr = [NSKeyedUnarchiver unarchiveObjectWithFile:sqlFilePath];
//    return usersArr;
//    return self.userAry;
//}

//- (NSMutableArray *)userAry {
//
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
//    NSString *sqlFilePath = [docPath stringByAppendingPathComponent:@"Users.sqlite"];
//    //    NSArray *usersArr = [NSArray arrayWithContentsOfFile:sqlFilePath];
//    NSMutableArray *usersArr = [NSKeyedUnarchiver unarchiveObjectWithFile:sqlFilePath];
//    return [usersArr?_userAry:[NSMutableArray alloc]init];
//}

@end
