//
//  BaseNavigationController.m
//  LearnOpenGLES
//
//  Created by 恒 on 2018/1/18.
//  Copyright © 2018年 恒. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     tintColor: 导航栏的按钮(如返回)颜色
     titleTextAttributes: 标题颜色
     barTintColor: 背景颜色
     translucent: 是否透明
     */
    
    self.navigationBar.barTintColor=[UIColor whiteColor]; //导航栏背景颜色
    //    self.navigationBar.tintColor = [UIColor redColor]; //导航栏字体颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor yellowColor]}];
    
    // Do any additional setup after loading the view.
}

#pragma delegate
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"%lu",(unsigned long)self.viewControllers.count);
    if (self.viewControllers.count != 0) {
        
        //方法就是在初始化图片时，将图片的渲染模式设置
        UIImage *leftImage = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem  alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)pop {
    [self popViewControllerAnimated:YES];
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
