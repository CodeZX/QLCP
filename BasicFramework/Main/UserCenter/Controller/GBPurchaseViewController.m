//
//  GBPurchaseViewController.m
//  BasicFramework
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GBPurchaseViewController.h"

@interface GBPurchaseViewController ()

@end

@implementation GBPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)setupUI  {
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"已购产品";
    
    UILabel *textLable = [[UILabel alloc]init];
    textLable.textAlignment = NSTextAlignmentCenter;
    textLable.text = @"暂无购买产品！";
    [self.view addSubview:textLable];
    [textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
