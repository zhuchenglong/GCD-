//
//  ViewController.m
//  GCD多线程
//
//  Created by zhuchenglong on 16/6/17.
//  Copyright © 2016年 zhuchenglong. All rights reserved.
//

#import "ViewController.h"
#import "RequestManager.h"
#import "MBProgressHUD+HUD.h"

#import "AExampleVC.h"
#import "BExampleVC.h"
#import "CExampleVC.h"
#import "DExampleVC.h"
#import "EExampleVC.h"
#import "FExampleVC.h"
#import "GExampleVC.h"

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.title = @"GCD多线程";

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSArray *array = @[@"➣AF执行下载任务（自带多线程）✔︎",@"➣全局异步并行加载（以Group为单位）✔︎",@"➣全局异步并行加载 ✔︎",@"➣异步串行加载（根据需求使用）✔︎",@"➣主队列异步并行加载 ✘",@"➣主队列同步串行加载图片 ✘",@"➣dispatch_after延时执行✔︎"];
    
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        AExampleVC *avc = [AExampleVC new];
        avc.title = @"AF执行下载任务";
        [self.navigationController pushViewController:avc animated:YES];
    }

    if (indexPath.row == 1) {
        BExampleVC *bvc = [BExampleVC new];
        bvc.title = @"全局异步并行加载(group)";
        [self.navigationController pushViewController:bvc animated:YES];
    }
    if (indexPath.row == 2) {
        CExampleVC *cvc = [CExampleVC new];
        cvc.title = @"全局异步并行加载";
        [self.navigationController pushViewController:cvc animated:YES];
    }
    if (indexPath.row == 3) {
        DExampleVC *dvc = [DExampleVC new];
        dvc.title = @"异步串行加载";
        [self.navigationController pushViewController:dvc animated:YES];
    }
    if (indexPath.row == 4) {
        EExampleVC *evc = [EExampleVC new];
        evc.title = @"主队列异步并行加载";
        [self.navigationController pushViewController:evc animated:YES];
    }
    if (indexPath.row == 5) {
        FExampleVC *fvc = [FExampleVC new];
        fvc.title = @"主队列同步串行";
        [self.navigationController pushViewController:fvc animated:YES];
    }
    if (indexPath.row == 6) {
        GExampleVC *gvc = [GExampleVC new];
        gvc.title = @"dispatch_after延时执行";
        [self.navigationController pushViewController:gvc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
