//
//  GBSettingViewController.m
//  BasicFramework
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GBSettingViewController.h"

@interface GBSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@end

@implementation GBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupUI {
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"设置";
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.separatorStyle = UITableViewScrollPositionNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.bottom.equalTo(self.view);
    }];
    
}

#pragma mark -------------------------- tableiView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier = @"cell";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"接受通知";
    }
    if(indexPath.row == 1){
        
        cell.textLabel.text = @"清除缓存";
    }
    
    if(indexPath.row == 2) {
        
        cell.textLabel.text = @"个人信息";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        [self showToast:@"已开启"];
    }
    
    if(indexPath.row == 1) {
       [self showToast:@"清除成功"];
        
    }
    
    if ((indexPath.row == 2)) {
        [self showToast:@"服务器错误"];
        
    }
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
