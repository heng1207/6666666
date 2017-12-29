//
//  SobelCheckVC.m
//  GPUImageDemo
//
//  Created by 恒 on 2017/12/25.
//  Copyright © 2017年 恒. All rights reserved.
//

#import "SobelCheckVC.h"//Sobel边界检测
#import "GPUImage.h"


@interface SobelCheckVC ()
@property (nonatomic , strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic , strong) GPUImageSobelEdgeDetectionFilter *filter;
@property (nonatomic , strong) GPUImageMovieWriter *movieWriter;
@property (nonatomic , strong) GPUImageView *filterView;

@property (nonatomic , strong) CADisplayLink *mDisplayLink;

@end

@implementation SobelCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    _filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
    _filter.edgeStrength = 2;
    //    _filter.texelWidth = _filter.texelWidth * 2;
    //    _filter.texelHeight = _filter.texelHeight * 2;
    
    _filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = _filterView;
    
    [_videoCamera addTarget:_filter];
    [_filter addTarget:_filterView];
    [_videoCamera startCameraCapture];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
    }];
    
    self.mDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displaylink:)];
    [self.mDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    
    // Do any additional setup after loading the view.
}


- (void)displaylink:(CADisplayLink *)displaylink {
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
