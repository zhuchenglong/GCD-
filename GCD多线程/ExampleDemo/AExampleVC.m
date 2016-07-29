//
//  AExampleVC.m
//  GCD多线程
//
//  Created by zhuchenglong on 16/7/29.
//  Copyright © 2016年 zhuchenglong. All rights reserved.
//

#import "AExampleVC.h"
#import "RequestManager.h"
#import "MBProgressHUD+HUD.h"
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width
@interface AExampleVC ()

@end

@implementation AExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    for (int i =0 ; i<4; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, i*(140+5), kWidth, 140)];
        imageView.tag = i+1;
        [self.view addSubview:imageView];
    }
    
    [self downLoadImage];
}

-(void)downLoadImage{
    
    NSString *url1 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_1.jpg";
    UIImageView *imageView1 = (UIImageView *)[self.view viewWithTag:1];
    [self downLoadWithURL:url1 imageView:imageView1];
    
    NSString *url2 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_2.jpg";
    UIImageView *imageView2 = (UIImageView *)[self.view viewWithTag:2];
    [self downLoadWithURL:url2 imageView:imageView2];
    
    NSString *url3 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg";
    UIImageView *imageView3 = (UIImageView *)[self.view viewWithTag:3];
    [self downLoadWithURL:url3 imageView:imageView3];
    
    NSString *url4 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_4.jpg";
    UIImageView *imageView4 = (UIImageView *)[self.view viewWithTag:4];
    [self downLoadWithURL:url4 imageView:imageView4];
    
}

-(void)downLoadWithURL:(NSString *)url imageView:(UIImageView *)imageView{
    
    [MBProgressHUD showCircularHUDProgress:imageView];
    [RequestManager downLoadWithUrl:url progress:^(double progress) {
        // NSLog(@"下载进度--->%f",progress);
        //必须在主线程中更新progress！！！！
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD getHUDProgressFromView:imageView].progress = progress;
        });
    } success:^(id responseObject) {
        
        [MBProgressHUD showCustomViewFrom:imageView msg:@"成功" imageName:@"succeed"];
        imageView.image = [UIImage imageWithData:responseObject];
        
    } fail:^(NSError *error) {
        
        [MBProgressHUD showCustomViewFrom:imageView msg:@"失败" imageName:@"failed"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
