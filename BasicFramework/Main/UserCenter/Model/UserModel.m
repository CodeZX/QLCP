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
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    
    return self;
}

@end
