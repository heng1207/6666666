//
//  FuzzyPictureVC.m
//  GPUImageDemo
//
//  Created by 恒 on 2017/12/12.
//  Copyright © 2017年 恒. All rights reserved.
//

#import "FuzzyPictureVC.h"
#import "GPUImage.h"

@interface FuzzyPictureVC ()

@property (nonatomic , strong) GPUImagePicture *sourcePicture;
@property (nonatomic , strong) GPUImageTiltShiftFilter *sepiaFilter;

@end

@implementation FuzzyPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //用GPUImagePicture处理源图像，用GPUImageTiltShiftFilter处理模糊效果，用GPUImageView显示。
    GPUImageView *primaryView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = primaryView;
    
    UIImage *inputImage = [UIImage imageNamed:@"face.png"];
    _sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage];
    
    _sepiaFilter = [[GPUImageTiltShiftFilter alloc] init];
    _sepiaFilter.blurRadiusInPixels = 40.0;
    [_sepiaFilter forceProcessingAtSize:primaryView.sizeInPixels];
    [_sourcePicture addTarget:_sepiaFilter];
    [_sepiaFilter addTarget:primaryView];
    [_sourcePicture processImage];
    
    
    // GPUImageContext相关的数据显示
    GLint size = [GPUImageContext maximumTextureSizeForThisDevice];
    GLint unit = [GPUImageContext maximumTextureUnitsForThisDevice];
    GLint vector = [GPUImageContext maximumVaryingVectorsForThisDevice];
    NSLog(@"%d *******%d ------- %d", size, unit, vector);
    
    // Do any additional setup after loading the view.
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    float rate = point.y / self.view.frame.size.height;
    NSLog(@"Processing");
    [_sepiaFilter setTopFocusLevel:rate - 0.1];
    [_sepiaFilter setBottomFocusLevel:rate + 0.1];

    [_sourcePicture processImage];
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
