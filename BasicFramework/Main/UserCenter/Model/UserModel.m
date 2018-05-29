//
//  UserModel.m
//  BasicFramework
//
//  Created by apple on 2018/5/4.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.ID forKey:@"ID"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.token forKey:@"token"];
    [coder encodeObject:self.imageData forKey:@"imageData"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.imageData =[aDecoder decodeObjectForKey:@"imageData"];
    }
    
    return self;
}

@end
