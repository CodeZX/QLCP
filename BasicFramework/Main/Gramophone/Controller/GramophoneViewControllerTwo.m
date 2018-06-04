//
//  GramophoneViewControllerTwo.m
//  BasicFramework
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "GramophoneViewControllerTwo.h"
#import "GramophoneViewControllerCellTwo.h"
#import <AVFoundation/AVFoundation.h>


static NSString *const collectionViewCellIdentifier =  @"collectionViewCellIdentifier";
static NSString *audioPath = @"QLCP";


@interface GramophoneViewControllerTwo ()<UICollectionViewDelegate,UICollectionViewDataSource,AVAudioPlayerDelegate>
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,weak) UIImageView *headImageView; ;
@property(nonatomic, strong) AVAudioPlayer *player;
@end

@implementation GramophoneViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //设置导航栏透明
    //    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //    [self.tabBarController.tabBar setTranslucent:true];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBarController.tabBar setShadowImage:[UIImage new]];
    
    
}


- (void)setupUI  {
    
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"留声机";
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg1"]];
    [self.view addSubview:imageView];
    self.headImageView = imageView;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 300));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 50)/ 2, (SCREEN_WIDTH - 50)/ 2);
    layout.sectionInset  = UIEdgeInsetsMake(0, 20, 0, 20);
    
    UICollectionView *collectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, SCREEN_HEIGHT - 250) collectionViewLayout:layout];
    collectionView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    collectionView.backgroundColor = WhiteColor;
    collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self.collectionView registerClass:[GramophoneViewControllerCellTwo class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    
    self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark -------------------------- means ----------------------------------------

#pragma mark custom menas

//- (NSArray *)getAllFileByName:(NSString *)path
//{
//    NSFileManager *defaultManager = [NSFileManager defaultManager];
//    NSArray *array = [defaultManager contentsOfDirectoryAtPath:path error:nil];
//    return array;
//}

- (NSArray *)getAllfileByName:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray * fileAndFloderArr = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
    NSMutableArray *fileArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    //在上面那段程序中获得的fileList中列出文件夹名
    for (NSString * file in fileAndFloderArr){
        
        NSString *paths = [path stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:paths isDirectory:(&isDir)];
        if (!isDir) {
            [fileArray addObject:file];
        }
        isDir = NO;
    }
    return fileArray;
}

- (NSString *)fullPathAtDocument:(NSString *)fileName{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *directoryPath = [documentPath stringByAppendingPathComponent:@"QLCP"];
    if (![fm fileExistsAtPath:directoryPath]) {
        [fm createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [directoryPath stringByAppendingPathComponent:fileName];
}
- (NSString *)getAudiosPath {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *directoryPath = [documentPath stringByAppendingPathComponent:audioPath];
    if ([fm fileExistsAtPath:directoryPath]) {
        return directoryPath;
    }
    return nil;
}


#pragma mark respond  means
- (void)loadNewData {
    
    [self.collectionView.mj_header endRefreshing];
   
    
    self.dataSource = (NSMutableArray *) [self getAllfileByName:[self getAudiosPath]];
    
    [self.collectionView reloadData];
    
}

#pragma mark -------------------------- collectionView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //    return self.dataSource.count;
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GramophoneViewControllerCellTwo *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    //    cell.contentView.backgroundColor = RandomColor;
//    <#class#> *model =  self.searchDataSource ? self.searchDataSource[indexPath.row]:self.dataSource[indexPath.row];
//    cell.specialistModel = model;
    cell.backgroundColor = RandomColor;
    cell.title = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GramophoneViewControllerCellTwo *cell = (GramophoneViewControllerCellTwo *) [collectionView cellForItemAtIndexPath:indexPath];
    cell.stop = NO;
    NSString *audioPath = [self fullPathAtDocument:self.dataSource[indexPath.row]];
//    [self.player stop];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:audioPath] error:nil];
    self.player.delegate = self;
    [self.player play];
    [cell startAnimation];
    
    
}

#pragma mark -------------------------- audioPlayer delegate ----------------------------------------

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sotpPlayer" object:nil userInfo:nil];
}

#pragma mark -------------------------- Lazy load ----------------------------------------

- (AVAudioPlayer *)player {
    
    if (!_player) {
        _player = [[AVAudioPlayer alloc]init];
    }
    return _player;
}

@end
