//
//  UserModel.h
//  BasicFramework
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;
@end
