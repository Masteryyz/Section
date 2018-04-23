//
//  YZCustomCameraViewController.m
//  Section
//
//  Created by QZL on 2018/3/23.
//  Copyright © 2018年 WTF. All rights reserved.
//

#import "YZCustomCameraViewController.h"
#import "YZTableViewCell.h"
static NSString * cellidentifer = @"addressCellIdmwapovjwalvmxiujqbdoaijoi";

@interface YZCustomCameraViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImage * resultImage ;

@property (nonatomic, strong) UIView * cameraCoverView ;

@property (nonatomic, strong) UIButton * doBtn ;

@property (nonatomic, strong) UITableView * tableView ;

@end

@implementation YZCustomCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self cameraDistrict];
    
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 0, H(40), H(30));
    [returnBtn setTitle:@"退出" forState:UIControlStateNormal];
    [returnBtn setTitleColor:[UIColor colorWithHexValue:0x333333 alpha:1] forState:UIControlStateNormal];
    [returnBtn.titleLabel setFont:[UIFont systemFontOfSize:H(12)]];
    returnBtn.x = H(20);
    returnBtn.y = H(20);
    
    returnBtn.layer.borderColor = [UIColor colorWithHexValue:0xD989C7 alpha:1].CGColor;
    returnBtn.layer.cornerRadius = 4;
    returnBtn.layer.borderWidth = 1;
    
    [returnBtn setBackgroundColor:[UIColor whiteColor]];
    [returnBtn addTarget:self action:@selector(clickReturnBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:returnBtn];
    
    
    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(0, 0, H(80), H(30));
    [titleBtn setTitle:@"添加成功" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor colorWithHexValue:0x333333 alpha:1] forState:UIControlStateNormal];
    [titleBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:H(14)]];
    titleBtn.centerX = self.view.width / 2;
    titleBtn.y = H(20);
    
//    titleBtn.layer.borderColor = [UIColor colorWithHexValue:0xD989C7 alpha:1].CGColor;
//    titleBtn.layer.cornerRadius = 4;
//    titleBtn.layer.borderWidth = 1;
    
    [titleBtn setBackgroundColor:[UIColor whiteColor]];
    [titleBtn addTarget:self action:@selector(clickReturnBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:titleBtn];
    
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(H(20), CGRectGetMaxY(returnBtn.frame) + H(20), WIDTH - H(40), HEIGHT - H(50)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    [self.view addSubview:_tableView];
    
    [self.tableView reloadData];
    
    
    _cameraCoverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, H(300), H(189))];
    _cameraCoverView.userInteractionEnabled = YES;
    
    _cameraCoverView.layer.borderColor = [UIColor colorWithHexValue:0x78AFE7 alpha:1].CGColor;
    _cameraCoverView.layer.cornerRadius = H(4);
    _cameraCoverView.layer.borderWidth = 2;
    
//    [self.view addSubview:_cameraCoverView];
    
    _cameraCoverView.center = self.view.center;
    
    
    _doBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _doBtn.frame = CGRectMake(0, 0, H(60), H(60));
    [_doBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [_doBtn setTitleColor:[UIColor colorWithHexValue:0xffffff alpha:1] forState:UIControlStateNormal];
    [_doBtn.titleLabel setFont:[UIFont systemFontOfSize:H(12)]];
    _doBtn.centerX = self.view.width / 2;
    _doBtn.y = self.view.height - H(20) -H(60);
    
    _doBtn.layer.borderColor = [UIColor colorWithHexValue:0xD989C7 alpha:1].CGColor;
    _doBtn.layer.cornerRadius = H(30);
    _doBtn.layer.borderWidth = 3;
    
    [_doBtn setBackgroundColor:[UIColor colorWithHexValue:0x78AFE7 alpha:1]];
    [_doBtn addTarget:self action:@selector(photoBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:_doBtn];
    
    
}

#pragma mark -- tableView delegate and datasource --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return H(105);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (!cell) {
        cell = [[YZTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifer];
    }
    
    NSDictionary * dataDic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)[_dataArray objectAtIndex:indexPath.row]];
    cell.dataDic = dataDic;
//    cell.textLabel.text = [NSString stringWithFormat:@"%@" , [dataDic valueForKey:@"statiumName"]];
//    
//    NSString * birthdayStr = [NSString stringWithFormat:@"%@" , [dataDic valueForKey:@"birthday"]];
//    
//    if (birthdayStr.length > 10) {
//        birthdayStr = [birthdayStr substringToIndex:10];
//    }
//    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ -- %@" , [dataDic valueForKey:@"englishName"] , birthdayStr];
    
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor randomColor].CGColor;
    cell.layer.cornerRadius = H(4);
    cell.layer.masksToBounds = YES;
    
    return cell;
}

- (void) clickReturnBtn:(id) sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)cameraDistrict
{
    //    AVCaptureDevicePositionBack  后置摄像头
    //    AVCaptureDevicePositionFront 前置摄像头
    self.device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    self.session = [[AVCaptureSession alloc] init];
    //     拿到的图像的大小可以自行设定
    //    AVCaptureSessionPreset320x240
    //    AVCaptureSessionPreset352x288
    //    AVCaptureSessionPreset640x480
    //    AVCaptureSessionPreset960x540
    //    AVCaptureSessionPreset1280x720
    //    AVCaptureSessionPreset1920x1080
    //    AVCaptureSessionPreset3840x2160
    self.session.sessionPreset = AVCaptureSessionPreset1920x1080;
    //输入输出设备结合
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
    //预览层的生成
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    if ([_device lockForConfiguration:nil]) {
        //自动闪光灯，
        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡,但是好像一直都进不去
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }
    
    //设备取景开始
    [self.session startRunning];
    
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}

- (void)photoBtnDidClick:(id) sender
{
    AVCaptureConnection *conntion = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
    }
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        self.resultImage = [UIImage imageWithData:imageData];
        [self.session stopRunning];
        
        if (self.resultImageBlock) {
            self.resultImageBlock(_resultImage);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
//        [self.view addSubview:self.resultImageView];
    }];
    
    
}

+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}

- (void)changeCamera{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        //给摄像头的切换添加翻转动画
        CATransition *animation = [CATransition animation];
        animation.duration = .5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"oglFlip";
        
        AVCaptureDevice *newCamera = nil;
        AVCaptureDeviceInput *newInput = nil;
        //拿到另外一个摄像头位置
        AVCaptureDevicePosition position = [[_input device] position];
        if (position == AVCaptureDevicePositionFront){
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            animation.subtype = kCATransitionFromLeft;//动画翻转方向
        }
        else {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            animation.subtype = kCATransitionFromRight;//动画翻转方向
        }
        //生成新的输入
        newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
        [self.previewLayer addAnimation:animation forKey:nil];
        if (newInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.input];
            if ([self.session canAddInput:newInput]) {
                [self.session addInput:newInput];
                self.input = newInput;
                
            } else {
                [self.session addInput:self.input];
            }
            [self.session commitConfiguration];
            
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
