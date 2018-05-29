//
//  GBAboutViewController.m
//  BasicFramework
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GBAboutViewController.h"
#import "UserCenterTableViewCell.h"
#import "UserCenterTableViewCellModel.h"
//#import "GBProductDetailsViewController.h"


@interface GBAboutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSourceAry;
@end

@implementation GBAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI  {
    
    self.view.backgroundColor = WhiteColor;
    self.navigationController.navigationBar.hidden = NO;
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.title = @"关于五福";
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    //    tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.right.bottom.equalTo(self.view);
    }];
    
    
}

- (void)back:(UIButton *)Btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -------------------------- UItableview dataSource ----------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSourceAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    NSArray *sectionAry = self.dataSourceAry[section];
    return sectionAry.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

#pragma mark -------------------------- UItbleView delegate ----------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier = @"UserCenterTableViewCell";
    UserCenterTableViewCell *cell = [UserCenterTableViewCell cellWithTableView:tableView Identifier:Identifier];
    
    NSArray *sectionAry = self.dataSourceAry[indexPath.section];
    UserCenterTableViewCellModel *model = sectionAry[indexPath.row];
    cell.model = model;
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    
    return 20;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view.backgroundColor = RGBCOLOR(237, 237, 237);
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *sectionAry = self.dataSourceAry[indexPath.section];
    UserCenterTableViewCellModel *model = sectionAry[indexPath.row];
    model.actionBlock(nil);
}


#pragma mark -------------------------- lazy load ----------------------------------------
- (NSArray *)dataSourceAry {
    WS(weakSelf)
    if (!_dataSourceAry) {
        
        UserCenterTableViewCellModel *model0 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"联系我们" ActionBlock:^(id cell) {
            
//            GBProductDetailsViewController *VC = [[GBProductDetailsViewController alloc]initWithHtml:@"联系我们"];
//            VC.title = @"联系我们";
//            [weakSelf.navigationController pushViewController:VC animated:YES];
        }];
        
        UserCenterTableViewCellModel *model1 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"企业介绍" ActionBlock:^(id cell) {
            
//            GBProductDetailsViewController *VC = [[GBProductDetailsViewController alloc]initWithHtml:@"企业介绍"];
//            VC.title = @"企业介绍";
//            [weakSelf.navigationController pushViewController:VC animated:YES];
        }];
        
        UserCenterTableViewCellModel *model2 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"企业文化" ActionBlock:^(id cell) {
            
//            GBProductDetailsViewController *VC = [[GBProductDetailsViewController alloc]initWithHtml:@"企业文化"];
//            VC.title = @"企业文化";
//            [weakSelf.navigationController pushViewController:VC animated:YES];
        }];
        
        UserCenterTableViewCellModel *model3 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"企业荣誉" ActionBlock:^(id cell) {
            
//            GBProductDetailsViewController *VC = [[GBProductDetailsViewController alloc]initWithHtml:@"企业荣誉"];
//            VC.title = @"企业荣誉";
//            [weakSelf.navigationController pushViewController:VC animated:YES];
            
            
        }];
        
        UserCenterTableViewCellModel *model4 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"新闻" ActionBlock:^(id cell) {
            
//            GBProductDetailsViewController *VC = [[GBProductDetailsViewController alloc]initWithHtml:@"新闻"];
//            VC.title = @"新闻";
//            [weakSelf.navigationController pushViewController:VC animated:YES];
           
        }];
        
        UserCenterTableViewCellModel *model5 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"合作伙伴" ActionBlock:^(id cell) {
            
//            GBProductDetailsViewController *VC = [[GBProductDetailsViewController alloc]initWithHtml:@"合作伙伴"];
//            VC.title = @"合作伙伴";
//            [weakSelf.navigationController pushViewController:VC animated:YES];
            
        }];
        NSArray *sectionAry0 = @[model0];
        NSArray *sectionAry1 = @[model1,model2,model3];
        NSArray *sectionAry2 = @[model4];
        NSArray *sectionAry3 = @[model5];
        _dataSourceAry = @[sectionAry0,
                           sectionAry1,
                           sectionAry2,
                           sectionAry3
                           ];
    }
    
    return _dataSourceAry;
}

@end
