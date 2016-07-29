//
//  EExampleVC.m
//  GCD多线程
//
//  Created by zhuchenglong on 16/7/29.
//  Copyright © 2016年 zhuchenglong. All rights reserved.
//

#import "EExampleVC.h"
#import "RequestManager.h"
#import "MBProgressHUD+HUD.h"
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width
@interface EExampleVC ()

@end

@implementation EExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor =[UIColor whiteColor];
    
    for (int i =0 ; i<4; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, i*(140+5), kWidth, 140)];
        imageView.tag = i+11;
        [self.view addSubview:imageView];
    }
    
    
    /*
     dispatch_async(dispatch_get_main_queue(), ^{
     
     });
     注意：并没有开启新的线程
     */
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self downLoadImage];
    });
    NSLog(@"这是主队列并行执行");
}

//经测试，SDWebImage自带异步加载
//[imageView1 sd_setImageWithURL:[NSURL URLWithString:url1]];
-(void)downLoadImage{
    
    NSLog(@"当前线程----->%@",[NSThread currentThread]);
    [self downLoad1];
    [self downLoad2];
    [self downLoad3];
    [self downLoad4];
    NSLog(@"全部下载完毕");
}
-(void)downLoad1{
    
    NSLog(@"下载图片1");
    NSString *url1 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_1.jpg";
    UIImageView *imageView1 = (UIImageView *)[self.view viewWithTag:11];
    [MBProgressHUD showLoadHUDMsg:@"正在加载..." fromView:imageView1];
    imageView1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url1]]];
    [MBProgressHUD showCustomViewFrom:imageView1 msg:@"成功" imageName:@"succeed"];
    NSLog(@"图片1下载完毕");
}
-(void)downLoad2{
    
    NSLog(@"下载图片2");
    NSString *url2 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_2.jpg";
    UIImageView *imageView2 = (UIImageView *)[self.view viewWithTag:12];
    [MBProgressHUD showLoadHUDMsg:@"正在加载..." fromView:imageView2];
    imageView2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url2]]];
    [MBProgressHUD showCustomViewFrom:imageView2 msg:@"成功" imageName:@"succeed"];
    NSLog(@"图片2下载完毕");
}
-(void)downLoad3{
    
    NSLog(@"下载图片3");
    NSString *url3 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg";
    UIImageView *imageView3 = (UIImageView *)[self.view viewWithTag:13];
    [MBProgressHUD showLoadHUDMsg:@"正在加载..." fromView:imageView3];
    imageView3.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url3]]];
    [MBProgressHUD showCustomViewFrom:imageView3 msg:@"成功" imageName:@"succeed"];
    NSLog(@"图片3下载完毕");
}
-(void)downLoad4{
    
    NSLog(@"下载图片4");
    NSString *url4 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_4.jpg";
    UIImageView *imageView4 = (UIImageView *)[self.view viewWithTag:14];
    [MBProgressHUD showLoadHUDMsg:@"正在加载..." fromView:imageView4];
    imageView4.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url4]]];
    [MBProgressHUD showCustomViewFrom:imageView4 msg:@"成功" imageName:@"succeed"];
    NSLog(@"图片4下载完毕");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
