//
//  BeautifyVC.m
//  GPUImageDemo
//
//  Created by 恒 on 2017/12/12.
//  Copyright © 2017年 恒. All rights reserved.
//

#import "BeautifyVC.h"
#import "GPUImage.h"
#import "GPUImageBeautifyFilter.h"
#import <AssetsLibrary/ALAssetsLibrary.h> //iOS8以下的版本
#import <Photos/Photos.h> //iOS8以上的版本


@interface BeautifyVC ()

@property (nonatomic , strong) UILabel  *mLabel;

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic , strong) GPUImageMovieWriter *movieWriter;
@property (nonatomic, strong) GPUImageView *filterView;

//http://blog.csdn.net/u014128241/article/details/53333435

@end

@implementation BeautifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.filterView.center = self.view.center;
    [self.view addSubview:self.filterView];
    
    
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    unlink([pathToMovie UTF8String]);
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    
    _movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(640.0, 480.0)];
    
    self.videoCamera.audioEncodingTarget = _movieWriter;
    _movieWriter.encodingLiveVideo = YES;
    [self.videoCamera startCameraCapture];
    GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
    [self.videoCamera addTarget:beautifyFilter];
    [beautifyFilter addTarget:self.filterView];
    [beautifyFilter addTarget:_movieWriter];
    [_movieWriter startRecording];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [beautifyFilter removeTarget:_movieWriter];
        [_movieWriter finishRecording];
        
//        [self saveVideo:pathToMovie];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToMovie))
        {
            
            //(NSString *)filePath: 视频的文件路径
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                
                [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL fileURLWithPath:pathToMovie]];
                
            } completionHandler:^(BOOL success, NSError *error) {
                if (success==YES) {
                    
                }
                else{
                    
                }
                
            }];
            
            
//            [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error)
//             {
//                 dispatch_async(dispatch_get_main_queue(), ^{
//
//                     if (error) {
//                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存失败" message:nil
//                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                         [alert show];
//                     } else {
//                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存成功" message:nil
//                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                         [alert show];
//                     }
//                 });
//             }];
        }
        else {
            NSLog(@"error mssg)");
        }
        
    });

    
    // Do any additional setup after loading the view.
}

//iOS 新的保存视频方法
-(void)saveVideo:(NSString*)videoPath {
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoPath)) {
        //保存相册核心代码
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
    }
    
}


//保存视频完成之后的回调
- (void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败%@", error.localizedDescription);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存失败" message:nil
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        NSLog(@"保存视频成功");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存成功" message:nil
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
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
