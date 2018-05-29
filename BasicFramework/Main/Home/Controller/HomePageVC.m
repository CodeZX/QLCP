//
//  HomePageVC.m
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "HomePageVC.h"
#import "HomeTableViewCell.h"
#import "DetailsViewController.h"

@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
   
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView   = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.size.equalTo(self.view.size);
    }];
    
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        
    }];
    
}

- (void)loadNewData {
    
    
    
    
}

- (void)loadMoreDate {
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------------- tableView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HomeTableViewCell *cell =[HomeTableViewCell cellWithTableView:tableView Identifier:@"HomeCell"];
    
//    cell.textLabel.text = @"2222";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DetailsViewController *detailsVC  = [DetailsViewController new];
//    [self presentViewController:detailsVC animated:YES completion:^{
    
//    }];
    
    [self.navigationController pushViewController:detailsVC animated:YES];
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
