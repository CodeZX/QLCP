//
//  GramophoneViewControllerCellTwo.m
//  BasicFramework
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GramophoneViewControllerCellTwo.h"

@interface GramophoneViewControllerCellTwo  ()
@property (nonatomic,weak) UIView *leftView;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UIImageView *trayImg;
@property (nonatomic,weak) UIImageView *styli;


@end
@implementation GramophoneViewControllerCellTwo
{
    CGFloat angle;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
//        [self startAnimation];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayer) name:@"sotpPlayer" object:nil];
    }
    return self;
}

- (void)stopPlayer {
    
    self.stop = YES;
//    self.stop  = NO;
    
    
}

- (void)setupUI {
    
    self.contentView.backgroundColor = RandomColor;
    
    UIImageView *trayImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_disc"]];
//    trayImg.backgroundColor = RandomColor;
    [self.contentView addSubview:trayImg];
    self.trayImg = trayImg;
    [self.trayImg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    UIImageView *styli = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_styli"]];
    //    styli.backgroundColor = RandomColor;
    [self.contentView addSubview:styli];
    self.styli = styli;
    [self.styli mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.size.equalTo(CGSizeMake(25, 61));
    }];
    
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mask"]];
    [self.contentView addSubview:leftView];
    self.leftView = leftView;
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.width.equalTo(self.contentView).multipliedBy(.5);
    }];
    
   
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = WhiteColor;
    [self.leftView addSubview:titleLabel];
    self.titleLabel= titleLabel;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.leftView);
    }];
    
    
    
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd-HH-mm-ss+0800";
    NSDate *data = [df dateFromString:title];
    df.dateFormat = @"MM月dd";
    self.titleLabel.text = [df stringFromDate:data];
    
}

- (void)setAvdioModel:(AudioModel *)avdioModel {
    _avdioModel = avdioModel;
   
    
}

- (void)startAnimation {
    
         CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
         [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                 self.trayImg.transform = endAngle;
             } completion:^(BOOL finished) {
                 if (!self.stop) {
                      angle += 2; [self startAnimation];
                 }
                 
                 }];
}



@end
