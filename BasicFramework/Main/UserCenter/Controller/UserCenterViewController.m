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
#import "GBAboutViewController.h"
#import "GBSettingViewController.h"
#import "GBPurchaseViewController.h"
#import "GBRecordViewController.h"
#import "LYLAlertView.h"

//#import "UIImage+Data.h"




#define backimageViewHeight 250
#define headImageViewHeight 250 - 64


@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIImageView *headImageView;
@property (nonatomic,strong) NSMutableArray *dataSurceAry;
@property (nonatomic,weak) UINavigationBar *navBar;
@property (nonatomic,weak) UIImageView *backImageView;
@property (nonatomic,weak) UIImageView *portraitImageView;
@property (nonatomic,weak) UILabel *nameLable;
@property (nonatomic,strong) UIView *tablefootView;


@property (nonatomic,strong) NSArray *dataSourceAry;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = YES;
   
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
     self.navigationController.navigationBar.hidden = NO;
}


- (void)setupUI {
    
    self.view.backgroundColor = RGBCOLOR(237, 237, 237);

    self.navigationItem.title = @"我的";
   
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:nil];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStyleDone target:self action:nil];
  
    
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:backImageView];
    self.backImageView = backImageView;
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(backimageViewHeight);
    }];
//    backImageView.backgroundColor = [UIColor redColor];
    

    
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
    tableView.backgroundColor  = ClearColor;
    tableView.tableFooterView = self.tablefootView;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    imageView.userInteractionEnabled = YES;
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
    
    
    
    UIImageView *portraitImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_head"]];
    portraitImageView.userInteractionEnabled = YES;
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
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userIconChange)];
    [portraitImageView addGestureRecognizer:tapGesture];
    
    
    UILabel *nameLable = [[UILabel alloc]init];
    nameLable.text = @"用户001";
    [self.headImageView addSubview:nameLable];
    self.nameLable= nameLable;
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headImageView);
        make.bottom.equalTo(self.headImageView).offset(-10);
    }];
//    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
//    [self.view addSubview:navBar];
//    self.navBar = navBar;
//
//    navBar.backgroundColor = [UIColor yellowColor];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
   
    UsersManager *manager  = [UsersManager sharedusersManager];
    if ([manager.currentUser.token isEqualToString:@"1"]) {
        
        UIImage *image = [UIImage imageWithData:manager.currentUser.imageData];
        if (image) {
             self.portraitImageView.image =[UIImage imageWithData:manager.currentUser.imageData];
        }
       
        self.nameLable.text = manager.currentUser.name;
    }
}


#pragma mark --------------------------respond means ----------------------------------------

-(void) userIconChange{
    
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle: @"更换头像" message: @"拍照或从相册中选择" preferredStyle: UIAlertControllerStyleActionSheet];
    
    [actionSheetController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
        [self takePhoto];
        
    }]];
    
    [actionSheetController addAction: [UIAlertAction actionWithTitle:@"打开相册"style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self LocalPhoto];
        
    }]];
    
    [actionSheetController addAction: [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {}]];
    
    [self presentViewController: actionSheetController animated:YES completion:^{}];
    
}

- (void)takePhoto {
    
    /*资源类型为照相机*/
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    UIImagePickerControllerQualityType qualityType = UIImagePickerControllerQualityTypeHigh;
    
    /*判断是否有相机*/
    
    if([UIImagePickerController isSourceTypeAvailable : UIImagePickerControllerSourceTypeCamera]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.delegate=self;
        
        /*设置拍照后的图片可被编辑*/
        
        picker.allowsEditing=YES;
        
        /*资源类型为照相机*/
        
        picker.sourceType= sourceType;
        
        /*品质为高*/
        
        picker.videoQuality= qualityType;
        
        [self presentViewController: picker animated:YES completion:^{}];
        
    }else
        
    {NSLog(@"该设备无摄像头");}


    
}
- (void)LocalPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    /*资源类型为图片库*/
    
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate=self;
    
    /*设置选择后的图片可被编辑*/
    
    picker.allowsEditing=YES;
    
    [self presentViewController:picker animated:YES completion:^{}];
    
   
    
    
}

#pragma mark -------------------------- UIImagePickerController delegate ----------------------------------------

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    NSLog(@"keys %@",[info allKeys]);
    self.portraitImageView.image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [[UsersManager sharedusersManager] setPortrait:self.portraitImageView.image];
//    [UsersManager sharedusersManager] 
    [picker dismissViewControllerAnimated:YES completion:nil];
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
        return 10;
    }
    
    return 30;
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

- (NSArray *)dataSourceAry {
    WS(weakSelf)
    if (!_dataSourceAry) {
       
        UserCenterTableViewCellModel *model0 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"已购产品" ActionBlock:^(id cell) {
            
//             [weakSelf.navigationController pushViewController:[[ZXLoginViewController alloc]init] animated:YES];
            

            
            GBPurchaseViewController *VC = [[GBPurchaseViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }];
        
        UserCenterTableViewCellModel *model1 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"预约记录" ActionBlock:^(id cell) {
            
            GBRecordViewController *VC = [[GBRecordViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
            
        }];
        
        UserCenterTableViewCellModel *model2 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"设置" ActionBlock:^(id cell) {
            GBSettingViewController *VC = [[GBSettingViewController alloc]init];
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }];
        
        UserCenterTableViewCellModel *model3 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"关于五福" ActionBlock:^(id cell) {
            
            
            GBAboutViewController *aboutVC = [[GBAboutViewController alloc]init];
            [weakSelf.navigationController pushViewController:aboutVC animated:YES];
        }];
        
//        UserCenterTableViewCellModel *model4 = [[UserCenterTableViewCellModel alloc]initWithRightName:@"" Title:@"退出登录" ActionBlock:^(id cell) {
//
//
//            GBAboutViewController *aboutVC = [[GBAboutViewController alloc]init];
//            [weakSelf.navigationController pushViewController:aboutVC animated:YES];
//        }];
        NSArray *sectionAry0 = @[model0,model1];
        NSArray *sectionAry1 = @[model2];
        NSArray *sectionAry2 = @[model3];
        _dataSourceAry = @[sectionAry0,
                          sectionAry1,
                          sectionAry2
                     ];
    }
    
    return _dataSourceAry;
}


- (UIView *)tablefootView {
    
    if (!_tablefootView) {
        
        _tablefootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 44)];
        _tablefootView.backgroundColor = [UIColor redColor];
        UIButton *Btn = [[UIButton alloc]init];
        [Btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tablefootView addSubview:Btn];
        [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_tablefootView);
        }];
    }
    
    return _tablefootView;
}

- (void)BtnClick:(id)sender {
    
//    [[UsersManager sharedusersManager] logOut];
    
    LYLAlertView *alertView = [[LYLAlertView alloc]initDropAlertWithTitle:@"" andText:@"是否要退出登录吗？" andCancelButton:NO forAlertType:AlertFailure withCompletionHandler:^(LYLAlertView *alertView, UIButton *currentBT) {
        [[UsersManager sharedusersManager] logOut];
        UIWindow *window =   [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [[ZXLoginViewController alloc]init];
    }];
    [alertView show];
    
    
}
@end

