//
//  GBresultModel.h
//  BasicFramework
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBresultModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *iphone;
@property (nonatomic,copy) NSString *doctor;
@property (nonatomic,copy) NSString *describe;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *ID;
- (instancetype)initWithDic:(NSDictionary *)dic;

//[0]    (null)    @"iphone" : @"15901263250"
//[1]    (null)    @"doctor" : @"蔡芳芳"
//[2]    (null)    @"id" : (long)10
//[3]    (null)    @"describe" : (no summary)
//[4]    (null)    @"date" : @"2018-05-22T16:00:00.000+0000"
//[5]    (null)    @"username" : @"admin"
//[6]    (null)    @"sex" : @"反弹"
//[7]    (null)    @"name" : @"的但e"
@end
