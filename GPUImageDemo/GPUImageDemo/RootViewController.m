//
//  RootViewController.m
//  GPUImageDemo
//
//  Created by 恒 on 2017/12/12.
//  Copyright © 2017年 恒. All rights reserved.
//

#import "RootViewController.h"

#import "PictureProcessingVC.h"
#import "VideoProcessingVC.h"
#import "BeautifyVC.h"
#import "FuzzyPictureVC.h"
#import "FilterVideo.h"
#import "WatermarkVideoVC.h"
#import "WatermarkTextPictureVC.h"
#import "VideoMergeVC.h"
#import "PictureInOutVC.h"
#import "GPUImageInstructVC.h"
//#import "FaceRecognitionVC.h"
#import "SobelCheckVC.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSArray *dataArr;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"GPUImage";
        

    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    

    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if (cell==nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        PictureProcessingVC *vc=[PictureProcessingVC new];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==1){
        VideoProcessingVC *vc=[VideoProcessingVC new];
   [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==2){
        BeautifyVC *vc=[BeautifyVC new];
    [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==3){
        FuzzyPictureVC *vc=[FuzzyPictureVC new];
       [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==4){
        FilterVideo *vc=[FilterVideo new];
         [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==5){
        WatermarkVideoVC *vc=[WatermarkVideoVC new];
    [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==6){
        WatermarkTextPictureVC *vc=[WatermarkTextPictureVC new];
     [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==7){
        VideoMergeVC *vc=[VideoMergeVC new];
       [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==8){
        PictureInOutVC *vc=[PictureInOutVC new];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==9){
        GPUImageInstructVC *vc=[GPUImageInstructVC new];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==10){
//        FaceRecognitionVC *vc=[FaceRecognitionVC new];
//        [self presentViewController:vc animated:YES completion:nil];
    }
    else if (indexPath.row==11){
        SobelCheckVC *vc=[SobelCheckVC new];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        
        _dataArr = @[@"简单图片处理",@"简单视频处理",@"实时美颜滤镜",@"模糊图片处理",@"滤镜视频录制",@"用视频做视频水印",@"文字水印和动态图像水印",@"视频合并混音",@"图像的输入输出和滤镜通道",@"用GPUImage和指令配合合并视频",@"美颜+人脸识别",@"Sobel边界检测"];
    }
    return _dataArr;
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
