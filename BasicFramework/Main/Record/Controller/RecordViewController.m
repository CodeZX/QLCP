//
//  RecordViewController.m
//  BasicFramework
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "RecordViewController.h"
#import "FXRecordArcView.h"
#import "AudioModel.h"


typedef NS_ENUM(NSUInteger, AudioState) {
    AudioStateMarch,
    AudioStateEnd,
    AudioStateBegin
};



@interface RecordViewController ()<FXRecordArcViewDelegate,AVAudioPlayerDelegate>
@property (nonatomic,strong) FXRecordArcView *recordView;
@property (nonatomic,weak) UIImageView *imageView;
@property(nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic,strong) NSString *audioName;


@property (nonatomic,weak) UIButton *startBtn;
@property (nonatomic,weak) UIButton *saveBtn;
@property (nonatomic,weak) UIButton *cancelBtn;

@property (nonatomic,assign) AudioState audioState;
@end

@implementation RecordViewController

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
    
    self.navigationItem.title =  @"录音";
    self.view.backgroundColor = WhiteColor;
    self.audioState = AudioStateEnd;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    ;    [self.navigationController.navigationBar setTintColor:WhiteColor];
    
    UIImageView *bgimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back ground"]];
    [self.view addSubview:bgimageView];
    [bgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.recordView = [[FXRecordArcView alloc] initWithFrame:CGRectMake((ScreenWidth - 320) /2, 0, ScreenWidth, 320)];
    [self.view addSubview:self.recordView];
    self.recordView.delegate = self;
    
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_stop"]];
//    imageView.userInteractionEnabled = YES;
//    [self.view addSubview:imageView];
//    self.imageView = imageView;
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.view).offset(100);
//        make.centerX.equalTo(self.view);
//        make.size.equalTo(CGSizeMake(100, 100));
//    }];
    
    
    UIButton *saveBtn = [[UIButton alloc]init];
    saveBtn.alpha = 0.2;
//    saveBtn.backgroundColor =  RandomColor;
    //    [Btn setTitle:@"Btn" forState:UIControlStateNormal];
    //    [Btn setTitle:@"Btn" forState:UIControlStateSelected];
    [saveBtn setImage:[UIImage imageNamed:@"btn_save"] forState:UIControlStateNormal];
    [saveBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    self.saveBtn = saveBtn;
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    cancelBtn.alpha = 0.2;
//    cancelBtn.backgroundColor =  RandomColor;
    //    [Btn setTitle:@"Btn" forState:UIControlStateNormal];
    //    [Btn setTitle:@"Btn" forState:UIControlStateSelected];
    [cancelBtn setImage:[UIImage imageNamed:@"btn_close@2x"] forState:UIControlStateNormal];
    [cancelBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    UIButton *startBtn = [[UIButton alloc]init];
//    startBtn.backgroundColor =  RandomColor;
//    [Btn setTitle:@"Btn" forState:UIControlStateNormal];
//    [Btn setTitle:@"Btn" forState:UIControlStateSelected];
    [startBtn setImage:[UIImage imageNamed:@"btn_stop"] forState:UIControlStateNormal];
    [startBtn setImage:[UIImage imageNamed:@"disc"] forState:UIControlStateSelected];
    [startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    self.startBtn = startBtn;
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    
    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
//    longPress.minimumPressDuration = 0.4;
//    [self.imageView addGestureRecognizer:longPress];
    
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
//    [self.imageView addGestureRecognizer:tapGesture];
}


- (void)share {
    
    //分享的标题
    NSString *textToShare = @"情侣CP";
    //分享的图片
//    UIImage *imageToShare = [UIImage imageNamed:@"312.jpg"];
    //分享的url
//    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
//    NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
    NSArray *activityItems = @[textToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
    
}

#pragma mark -------------------------- recordarcView delegate ----------------------------------------
- (void)recordArcView:(FXRecordArcView *)arcView voiceRecorded:(NSString *)recordPath length:(float)recordLength {

    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"录音" message:@"111" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"试听" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[self fullPathAtCache:self.audioName]] error:nil];
//        self.player.delegate = self;
//        [self.player play];
//    }];
//    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//        [self removeAudio];
//    }];
//
//    [alert addAction:action];
//    [alert addAction:actionCancel];
//
//    [self presentViewController:alert animated:YES completion:nil];
//    [self showToast:recordPath];
    

}

#pragma mark -------------------------- audioPlayer delegate ----------------------------------------
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否保存？" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self saveAudio];
//
//    }];
//    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//         [self removeAudio];
//    }];
//
//    [alert addAction:action];
//    [alert addAction:actionCancel];
//
//    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)longPress:(UILongPressGestureRecognizer *)longPress {
   
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        
        
    }
    
    if (longPress.state == UIGestureRecognizerStateChanged) {
        
    }
    
    if (longPress.state == UIGestureRecognizerStateEnded) {
        

        
        
    }
    
    
}


- (void)tapGesture:(UITapGestureRecognizer *)tapGesture {
    
   
    
}
#pragma mark -------------------------- means ----------------------------------------
- (void)showSaveBtnAndCancelBtn {
    
    
    [self.saveBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(150);
    }];
    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-150);
    }];
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.saveBtn.alpha = 1;
        self.cancelBtn.alpha = 1;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hideSaveBtnAndCancelBtn {
    
    [self.saveBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
    }];
    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
    }];
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.saveBtn.alpha = 0.2;
        self.cancelBtn.alpha = 0.2;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)saveBtnClick:(UIButton *)btn {
    
    [self hideSaveBtnAndCancelBtn];
    [self saveAudio];
    NSString *path = [self fullPathAtDocument:self.audioName];
    AudioModel *avdioModel = [[AudioModel alloc]initWithTitle:@"我就是标题" Path:path];
    AudioManager *audioManager = [AudioManager sharedAudioManager];
    YYCache *audioCache = audioManager.audioCache;
    [audioCache setObject:avdioModel forKey:path];

    AudioModel *avdioModel1 = (AudioModel *) [audioCache objectForKey:path];
    NSLog(@"zxzxzxzxxzxz%@",avdioModel1.path);
}


- (void)cancelBtnClick:(UIButton *)btn {
    
    [self hideSaveBtnAndCancelBtn];
    [self removeAudio];
    
    
}

- (void)startBtnClick:(UIButton *)btn {
    
    if (self.audioState == AudioStateEnd) {
        [self startRecord];
        btn.selected = YES;
        self.audioState = AudioStateMarch;
        
    }else if(self.audioState == AudioStateMarch){
        [self.recordView commitRecording];
        [self showSaveBtnAndCancelBtn];
        btn.selected = NO;
        self.audioState = AudioStateEnd;
        
    }

    
}

- (void)startRecord {
    
    
    [self startAnimation];
    [self playSystemSound];
    self.audioName = [self randomAudioName];
    [self.recordView startForFilePath:[self fullPathAtCache:self.audioName]];
    
}

- (void)startAnimation {
    
    static  int angle;
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction  animations:^{
        self.startBtn.transform = endAngle;
    } completion:^(BOOL finished) {
        if (self.startBtn.selected) {
            angle += 2; [self startAnimation];
        }
        
    }];
}

- (void)playSystemSound  {
//    AudioServicesPlaySystemSound(1006);
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSoundWithCompletion(1057, ^{
        
    });
//    SystemSoundID systemSoundID = 0;
//
//    NSURL *url = [[NSBundle mainBundle]URLForResource:@"123.mp4" withExtension:nil];
//    CFURLRef urlRef = (__bridge CFURLRef)(url);
//
//    AudioServicesCreateSystemSoundID(urlRef, &systemSoundID);
//    AudioServicesPlayAlertSound(systemSoundID);
    
}
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
