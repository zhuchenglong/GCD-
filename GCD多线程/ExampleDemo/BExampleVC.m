//
//  BExampleVC.m
//  GCD多线程
//
//  Created by zhuchenglong on 16/7/29.
//  Copyright © 2016年 zhuchenglong. All rights reserved.
//

#import "BExampleVC.h"
#import "RequestManager.h"
#import "MBProgressHUD+HUD.h"
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width
@interface BExampleVC ()

@end

@implementation BExampleVC

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
     使用GCD进行多文件下载时，可以使用dispatch_group进行管理。可以等到他们都响应完，在执行下一步操作，
     把耗时的下载图片的的任务加到全局队列中，以group为单位可以很方便的管理下载后再执行什么操作
     */
    
    //队列：全局队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    //创建group
    dispatch_group_t group = dispatch_group_create();
    
    //执行方式：dispath_group_async()
    dispatch_group_async(group, globalQueue, ^{
        //并行执行的线程一
        NSLog(@"下载图片1的线程--->%@",[NSThread currentThread]);
        [self downLoad1];
    });
    
    dispatch_group_async(group, globalQueue, ^{
        //并行执行的线程二
        NSLog(@"下载图片2的线程--->%@",[NSThread currentThread]);
        [self downLoad2];
    });
    
    dispatch_group_async(group, globalQueue, ^{
        //并行执行的线程三
        NSLog(@"下载图片3的线程--->%@",[NSThread currentThread]);
        [self downLoad3];
    });
    
    dispatch_group_async(group, globalQueue, ^{
        //并行执行的线程四
        NSLog(@"下载图片4的线程--->%@",[NSThread currentThread]);
        [self downLoad4];
    });
    //通知以上图片下载完毕
    dispatch_group_notify(group, globalQueue, ^{
        
        NSLog(@"全部下载完毕！,线程---->%@",[NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = @"下载完毕";
            NSLog(@"回到主线程更新UI---->%@",[NSThread currentThread]);
        });
    });
    

}


-(void)downLoadImage{
    
    [self downLoad1];
    [self downLoad2];
    [self downLoad3];
    [self downLoad4];
}

-(void)downLoad1{
    
    NSLog(@"下载图片1");
    NSString *url1 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_1.jpg";
    UIImageView *imageView1 = (UIImageView *)[self.view viewWithTag:11];
    [MBProgressHUD showLoadHUDMsg:@"正在加载..." fromView:imageView1];
    UIImage *image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url1]]];
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView1.image = image1;
    });
    [MBProgressHUD showCustomViewFrom:imageView1 msg:@"成功" imageName:@"succeed"];
    NSLog(@"图片1下载完毕");
}

-(void)downLoad2{
    
    NSLog(@"下载图片2");
    NSString *url2 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_2.jpg";
    UIImageView *imageView2 = (UIImageView *)[self.view viewWithTag:12];
    [MBProgressHUD showLoadHUDMsg:@"正在加载..." fromView:imageView2];
    UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url2]]];
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView2.image = image2;
    });
    [MBProgressHUD showCustomViewFrom:imageView2 msg:@"成功" imageName:@"succeed"];
    NSLog(@"图片2下载完毕");
}

-(void)downLoad3{
    
    NSLog(@"下载图片3");
    NSString *url3 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg";
    UIImageView *imageView3 = (UIImageView *)[self.view viewWithTag:13];
    [MBProgressHUD showLoadHUDMsg:@"正在加载..." fromView:imageView3];
    UIImage *image3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url3]]];
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView3.image = image3;
    });
    [MBProgressHUD showCustomViewFrom:imageView3 msg:@"成功" imageName:@"succeed"];
    NSLog(@"图片3下载完毕");
}

-(void)downLoad4{
    
    NSLog(@"下载图片4");
    NSString *url4 = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_4.jpg";
    UIImageView *imageView4 = (UIImageView *)[self.view viewWithTag:14];
    [MBProgressHUD showLoadHUDMsg:@"正在加载..." fromView:imageView4];
    UIImage *image4 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url4]]];
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView4.image = image4;
    });
    [MBProgressHUD showCustomViewFrom:imageView4 msg:@"成功" imageName:@"succeed"];
    NSLog(@"图片4下载完毕");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
