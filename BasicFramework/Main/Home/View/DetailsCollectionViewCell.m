//
//  DetailsCollectionViewCell.m
//  BasicFramework
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "DetailsCollectionViewCell.h"


@interface DetailsCollectionViewCell ()

@property (nonatomic,weak) UIImageView *contentImg;
@property (nonatomic,weak) UITextView *textView;
@property (nonatomic,weak) UIScrollView *scrollView;
@end
@implementation DetailsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.contentView.backgroundColor = WhiteColor;
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor redColor];
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 3, 200)];
    scrollView.pagingEnabled = YES;
    [self.contentView addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.centerY).offset(-20);
        make.centerX.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - 10,200));
    }];
    self.scrollView.backgroundColor = RandomColor;
    
   
    
//    UIImageView *contentImg = [UIImageView new];
//    contentImg.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:contentImg];
//    self.contentImg = contentImg;
//    [contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.bottom.equalTo(self.contentView.centerY).offset(-20);
//        make.centerX.equalTo(self.contentView);
//        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - 10,200));
//    }];
//    self.contentImg.backgroundColor = RandomColor;
    
    UITextView  *textView = [UITextView new];
    textView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:textView];
    self.textView = textView;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.centerY).offset(20);
        make.centerX.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - 10,200));
    }];
    self.textView.backgroundColor = RandomColor;
    self.textView.text = @"豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技豚金科技";
    self.textView.font= [UIFont systemFontOfSize:20];
}
@end
