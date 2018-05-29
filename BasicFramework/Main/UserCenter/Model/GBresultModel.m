//
//  GBresultModel.m
//  BasicFramework
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GBresultModel.h"

@implementation GBresultModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        
        self.name = dic[@"name"];
        self.sex = dic[@"sex"];
        self.iphone = dic[@"iphone"];
        self.doctor = dic[@"doctor"];
        self.describe = dic[@"describe"];
        self.date = dic[@"date"];
        self.username = dic[@"username"];
        self.ID = dic[@"id"];
        
    }
    
    return self;
}



//@property (nonatomic,copy) NSString *name;
//@property (nonatomic,copy) NSString *sex;
//@property (nonatomic,copy) NSString *iphone;
//@property (nonatomic,copy) NSString *doctor;
//@property (nonatomic,copy) NSString *describe;
//@property (nonatomic,copy) NSString *date;
//@property (nonatomic,copy) NSString *username;
//@property (nonatomic,copy) NSString *ID;
@end
