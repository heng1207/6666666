//
//  PictureProcessingVC.m
//  GPUImageDemo
//
//  Created by 恒 on 2017/12/12.
//  Copyright © 2017年 恒. All rights reserved.
//

#import "PictureProcessingVC.h"
#import "GPUImage.h"



@interface PictureProcessingVC ()
@property (nonatomic , strong) UIImageView* mImageView;

@end

@implementation PictureProcessingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    self.mImageView = imageView;
    [self onCustom];
    
    
    // Do any additional setup after loading the view.
}

- (void)onCustom {
    
    //方法一：
    GPUImageFilter *filter = [[GPUImageSepiaFilter alloc] init];
    UIImage *image = [UIImage imageNamed:@"face"];
    if (image) {
//        self.mImageView.image = image;
        self.mImageView.image = [filter imageByFilteringImage:image];
    }
    
    
    //方法二：
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc] init];

    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];

    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    self.mImageView.image = currentFilteredVideoFrame;
    
    
    
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
