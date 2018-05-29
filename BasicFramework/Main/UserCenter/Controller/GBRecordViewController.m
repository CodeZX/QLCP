//
//  GBRecordViewController.m
//  BasicFramework
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GBRecordViewController.h"
#import "GBresultModel.h"
#import "GBResultCell.h"

@interface GBRecordViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation GBRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}
- (void)viewDidAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupUI  {
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"预约记录";
    UILabel *textLable = [[UILabel alloc]init];
    textLable.textAlignment = NSTextAlignmentCenter;
    textLable.text = @"暂无预约！";
    [self.view addSubview:textLable];
    [textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.bottom.equalTo(self.view);
    }];
    
    tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [tableView.mj_header beginRefreshing];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GBResultCell" bundle:nil] forCellReuseIdentifier:@"GBResultCell"];
}

- (void)loadNewData {
    
    
    NSDictionary *dic = @{
                          @"user":@"admin"

                          };
    [[AFHTTPSessionManager manager] GET:@"http://47.93.28.161:8080/news/api/zx/get_order" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([[responseObject objectForKey:@"code"] intValue] == 200) {
            
            [self.dataSource removeAllObjects];
            NSArray *Ary = [responseObject objectForKey:@"result"];
            for (NSDictionary *dic in Ary ) {
                GBresultModel *model = [[GBresultModel alloc]initWithDic:dic];
                [self.dataSource addObject:model];
                
            }
            [self.tableView reloadData];
//            NSLog(@"%@",responseObject);
            
        }else {
            
            
        }
       
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showToast:@"访问失败"];
        [self.tableView.mj_header endRefreshing];
    }];
    
}
- (void)setupData {
    
    
    
}

#pragma mark -------------------------- tableview delegate ----------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
//    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GBResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GBResultCell"];
//    if (!cell)
//    {
//        [tableView registerNib:[UINib nibWithNibName:@"GBResultCell" bundle:nil] forCellReuseIdentifier:@"GBResultCell"];
//        cell = [tableView dequeueReusableCellWithIdentifier:@"GBResultCell"];
//    }
    cell.resultModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -------------------------- DZNEmptyDataSet Delegate  ----------------------------------------
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    
    return YES;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *str = @"暂无预约";
    return [[NSAttributedString alloc]initWithString:str attributes:nil];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
       
        _dataSource = [[NSMutableArray alloc]init];
    }
    
    return _dataSource;
}
@end
