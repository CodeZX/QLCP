//
//  UserCenterViewController.m
//  BasicFramework
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserCenterTableViewCell.h"
#import "UserCenterTableViewCellModel.h"



#define backimageViewHeight 250
#define headImageViewHeight 250 - 64


@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIImageView *headImageView;
@property (nonatomic,strong) NSMutableArray *dataSurceAry;
@property (nonatomic,weak) UINavigationBar *navBar;
@property (nonatomic,weak) UIImageView *backImageView;
@property (nonatomic,weak) UIImageView *portraitImageView;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}


- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的";
    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStyleDone target:self action:nil];
    
    
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self.view addSubview:backImageView];
    self.backImageView = backImageView;
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(backimageViewHeight);
    }];
    backImageView.backgroundColor = [UIColor redColor];
    

    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(NavgationBar_Height);
        make.right.bottom.equalTo(self.view);
    }];
    tableView.backgroundColor  = ClearColor;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self.view addSubview:imageView];
    self.headImageView = imageView;
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, headImageViewHeight);
//    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.top.equalTo(self.view);
//        //        make.right.equalTo(self.view);
//        //        make.bottom.equalTo(self.view);
//        make.height.equalTo(200);
//        make.width.equalTo(SCREEN_WIDTH);
//    }];

    [tableView setTableHeaderView:imageView];
    
    
    
    UIImageView *portraitImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    portraitImageView.layer.cornerRadius= 44;//裁成圆角
    portraitImageView.layer.masksToBounds=YES;//隐藏裁剪掉的部分
    //  给图片加一个圆形边框
    portraitImageView.layer.borderWidth = 1.5f;//边框宽度
    portraitImageView.layer.borderColor = [UIColor whiteColor].CGColor;//边框颜色
    [self.headImageView addSubview:portraitImageView];
    self.portraitImageView = portraitImageView;
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headImageView);
        make.size.equalTo(CGSizeMake(88, 88));
    }];
    portraitImageView.backgroundColor = RandomColor;

    
//    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
//    [self.view addSubview:navBar];
//    self.navBar = navBar;
//
//    navBar.backgroundColor = [UIColor yellowColor];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
   
}

#pragma mark -------------------------- UItableview dataSource ----------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSurceAry.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88;
}

#pragma mark -------------------------- UItbleView delegate ----------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier = @"UserCenterTableViewCell";
    UserCenterTableViewCell *cell = [UserCenterTableViewCell cellWithTableView:tableView Identifier:Identifier];
    cell.model = self.dataSurceAry[indexPath.row];
    return cell;
    
}

#pragma mark -------------------------- scrollView dalegate ----------------------------------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int contentOffsety = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y<=170) {
//        self.NavView.headBackView.alpha = scrollView.contentOffset.y/170;
//        self.NavView.left_bt_Image = @"left_";
//        self.NavView.right_bt_Image = @"Setting";
//        self.NavView.color = [UIColor whiteColor];

//        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//        self.navigationController.navigationBar.alpha = 1 - contentOffsety/170.0;
//        self.headImageView.alpha = 1 - contentOffsety/170.0;
    }else{
//        self.navigationController.navigationBar.alpha = 1;
//        self.NavView.headBackView.alpha = 1;
//
//        self.NavView.left_bt_Image = @"left@3x.png";
//        self.NavView.right_bt_Image = @"Setting_";
//        self.NavView.color = kColor(87, 173, 104, 1);
//        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    if (contentOffsety<0) {
//        CGRect rect = _backgroundImgV.frame;
//        rect.size.height = _backImgHeight-contentOffsety;
//        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
//        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
//        rect.origin.y = 0;
//        _backgroundImgV.frame = rect;
        
        CGFloat scale = -contentOffsety/200.0;
        self.backImageView.transform = CGAffineTransformMakeScale( 1 + scale ,1 + scale );
    }else{
        
//        CGRect rect = _backgroundImgV.frame;
//        rect.size.height = _backImgHeight;
//        rect.size.width = _backImgWidth;
//        rect.origin.x = 0;
//        rect.origin.y = -contentOffsety;
//        _backgroundImgV.frame = rect;
        
        [self.backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-contentOffsety);
        }];
        
    }
}
#pragma mark -------------------------- lazy load ----------------------------------------

- (NSMutableArray *)dataSurceAry {
    
    if (!_dataSurceAry) {
        
        _dataSurceAry = [[NSMutableArray alloc]init];
        UserCenterTableViewCellModel *model1 = [[UserCenterTableViewCellModel alloc]init];
        model1.title = @"model1";
        model1.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model1");
        };
         [_dataSurceAry addObject:model1];
        UserCenterTableViewCellModel *model2 = [[UserCenterTableViewCellModel alloc]init];
        model2.title = @"model2";
        model2.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model2");
        };
        [_dataSurceAry addObject:model2];
        
        UserCenterTableViewCellModel *model3 = [[UserCenterTableViewCellModel alloc]init];
        model3.title = @"model3";
        model3.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model3");
        };
        [_dataSurceAry addObject:model3];
        
        UserCenterTableViewCellModel *model4 = [[UserCenterTableViewCellModel alloc]init];
        model4.title = @"model2";
        model4.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model4");
        };
        [_dataSurceAry addObject:model4];
        
        UserCenterTableViewCellModel *model5 = [[UserCenterTableViewCellModel alloc]init];
        model5.title = @"model3";
        model5.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model5");
        };
        [_dataSurceAry addObject:model5];
        
        UserCenterTableViewCellModel *model6 = [[UserCenterTableViewCellModel alloc]init];
        model6.title = @"model2";
        model6.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model6");
        };
        [_dataSurceAry addObject:model6];
        
        UserCenterTableViewCellModel *model7 = [[UserCenterTableViewCellModel alloc]init];
        model7.title = @"model3";
        model7.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model7");
        };
        [_dataSurceAry addObject:model7];
        
        UserCenterTableViewCellModel *model8 = [[UserCenterTableViewCellModel alloc]init];
        model8.title = @"model2";
        model8.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model8");
        };
        [_dataSurceAry addObject:model8];
        
        UserCenterTableViewCellModel *model9 = [[UserCenterTableViewCellModel alloc]init];
        model9.title = @"model3";
        model9.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model9");
        };
        [_dataSurceAry addObject:model9];
        
        UserCenterTableViewCellModel *model10 = [[UserCenterTableViewCellModel alloc]init];
        model10.title = @"model2";
        model10.actionBlock = ^(id cell) {
            NSLog(@"%@",@"model10");
        };
        [_dataSurceAry addObject:model10];
    }
    
    return _dataSurceAry;
}

@end
