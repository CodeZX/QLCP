//
//  GramophoneViewControllerCellTwo.h
//  BasicFramework
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvdioModel.h"

@interface GramophoneViewControllerCellTwo : UICollectionViewCell
- (void)startAnimation;
@property (nonatomic,strong) AvdioModel *avdioModel;
@property (nonatomic,assign,getter=isStop) BOOL stop;
@property (nonatomic,strong) NSString *title;
@end
