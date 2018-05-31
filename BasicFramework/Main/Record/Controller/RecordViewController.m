//
//  RecordViewController.m
//  BasicFramework
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "RecordViewController.h"
#import "FXRecordArcView.h"

@interface RecordViewController ()<FXRecordArcViewDelegate,AVAudioPlayerDelegate>
@property (nonatomic,strong) FXRecordArcView *recordView;
@property (nonatomic,weak) UIImageView *imageView;
@property(nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic,strong) NSString *audioName;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI  {
    
    self.navigationItem.title =  @"录音";
    self.view.backgroundColor = WhiteColor;
    
    self.recordView = [[FXRecordArcView alloc] initWithFrame:CGRectMake(20, 0, 320, 320)];
    [self.view addSubview:self.recordView];
    self.recordView.delegate = self;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_stop"]];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration = 0.4;
    [self.imageView addGestureRecognizer:longPress];
    
}


#pragma mark -------------------------- recordarcView delegate ----------------------------------------
- (void)recordArcView:(FXRecordArcView *)arcView voiceRecorded:(NSString *)recordPath length:(float)recordLength {

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"录音" message:@"111" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"试听" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[self fullPathAtCache:self.audioName]] error:nil];
        self.player.delegate = self;
        [self.player play];
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self removeAudio];
    }];
   
    [alert addAction:action];
    [alert addAction:actionCancel];
    
    [self presentViewController:alert animated:YES completion:nil];
//    [self showToast:recordPath];
    

}

#pragma mark -------------------------- audioPlayer delegate ----------------------------------------
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否保存？" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveAudio];
        
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         [self removeAudio];
    }];
    
    [alert addAction:action];
    [alert addAction:actionCancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)longPress:(UILongPressGestureRecognizer *)longPress {
   
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        self.audioName = [self randomAudioName];
        [self.recordView startForFilePath:[self fullPathAtCache:self.audioName]];
    }
    
    if (longPress.state == UIGestureRecognizerStateChanged) {
        
    }
    
    if (longPress.state == UIGestureRecognizerStateEnded) {
        

         [self.recordView commitRecording];
        
    }
    
    
}
#pragma mark -------------------------- means ----------------------------------------
- (NSString *)randomAudioName {
    
    NSDate *data = [NSDate date];
    NSDateFormatter *DF = [[NSDateFormatter alloc]init];
    DF.dateFormat = @"yyyy-MM-dd-HH-mm-ss+0800";
    return  [DF stringFromDate:data];
    
}

- (void)saveAudio {

    BOOL result = NO;
    NSError * error = nil;
    NSString *toPath = [self fullPathAtDocument:self.audioName];
    NSString *path = [self fullPathAtCache:self.audioName];
    result = [[NSFileManager defaultManager]copyItemAtPath:path toPath:toPath error:&error ];
    if (error){
        NSLog(@"copy失败：%@",[error localizedDescription]);
    }else {
        [self showToast:@"保存成功"];
    }
}


- (void)removeAudio {
    
    
    [self showToast:@"删除成功！"];
}

- (NSString *)fullPathAtCache:(NSString *)fileName{
    NSError *error;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (YES != [fm fileExistsAtPath:path]) {
        if (YES != [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"create dir path=%@, error=%@", path, error);
        }
    }
    return [path stringByAppendingPathComponent:fileName];
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


@end
