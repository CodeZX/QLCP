//
//  GramophoneViewController.m
//  BasicFramework
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GramophoneViewController.h"
#import "GramophoneTableViewCell.h"
#import "AvdioModel.h"


static NSString *Identifier = @"GramophoneTableViewCell";
@interface GramophoneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIView *headerView;
@end

@implementation GramophoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setHidden:YES];
}


- (void)setupUI {
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"留声机";
    
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    v.backgroundColor = RandomColor;
    [self.view addSubview:v];
    
//    UITableView *tableView = [[UITableView alloc]init];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self.view addSubview:tableView];
//    self.tableView = tableView;
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.top.equalTo(self.view);
//        make.right.bottom.equalTo(self.view);
//    }];
//    [self.tableView registerNib:[UINib nibWithNibName:@"GramophoneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Identifier];
//    
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, 300)];
//    headerView.backgroundColor = RandomColor;
//    self.headerView = headerView;
//    self.tableView.tableHeaderView = headerView;
}


#pragma mark -------------------------- tableView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GramophoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSObject *Model = self.dataSource[indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
////    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
////    return headerview;
//}

#pragma mark -------------------------- lazy load ----------------------------------------

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        AvdioModel *avdio1 = [[AvdioModel alloc]init];
        AvdioModel *avdio2 = [[AvdioModel alloc]init];
        AvdioModel *avdio3 = [[AvdioModel alloc]init];
        _dataSource = [NSMutableArray arrayWithArray: @[avdio1,avdio2,avdio3]];
    }
    return _dataSource;
}

@end
