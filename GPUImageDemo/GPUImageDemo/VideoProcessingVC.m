//
//  VideoProcessingVC.m
//  GPUImageDemo
//
//  Created by 恒 on 2017/12/12.
//  Copyright © 2017年 恒. All rights reserved.
//

#import "VideoProcessingVC.h"
#import "GPUImage.h"


@interface VideoProcessingVC ()
@property (nonatomic , strong) GPUImageView *mGPUImageView;//显示GPUImage输出
@property (nonatomic , strong) GPUImageVideoCamera *mGPUVideoCamera;
@end

@implementation VideoProcessingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //AVCaptureSessionPreset1280x720
    self.mGPUVideoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];//设置视频 输出大小
    
    /*
    kGPUImageFillModeStretch,                       // Stretch to fill the full view, which may distort the image outside of its normal aspect ratio
    kGPUImageFillModePreserveAspectRatio,           // Maintains the aspect ratio of the source image, adding bars of the specified background color
    kGPUImageFillModePreserveAspectRatioAndFill     // Maintains the aspect ratio of the source image, zooming in on its center to fill the view
    */
    
    self.mGPUImageView.fillMode = kGPUImageFillModeStretch;//图像的填充模式kGPUImageFillModePreserveAspectRatioAndFill;
    self.mGPUImageView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.mGPUImageView.center = self.view.center;
    [self.view addSubview:self.mGPUImageView];
    
    
    GPUImageSepiaFilter* filter = [[GPUImageSepiaFilter alloc] init];
    [self.mGPUVideoCamera addTarget:filter];
    [filter addTarget:self.mGPUImageView];//添加一个目标新帧可用时接收通知。它的下一个可用的目标将被要求纹理。
    
    //这行代码不能添加
//    [self.mGPUVideoCamera addTarget:self.mGPUImageView];
    
    [self.mGPUVideoCamera startCameraCapture];
    
    //监听设备方向改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    // Do any additional setup after loading the view.
}


- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIInterfaceOrientation orientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    self.mGPUVideoCamera.outputImageOrientation = orientation;
    
    self.mGPUImageView.frame = self.view.frame;
    self.mGPUImageView.center = self.view.center;
    
    NSLog(@"%f-----%f",self.view.frame.size.width,self.view.frame.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
