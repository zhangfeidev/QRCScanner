//
//  ViewController.m
//  QRScannerDemo
//  blog:www.zhangfei.tk
//  Created by zhangfei on 15/10/14.
//  Copyright © 2015年 zhangfei. All rights reserved.
//

#import "ViewController.h"
#import "QRCScannerViewController.h"
#import "UIImage+MDQRCode.h"
#import "QRCScanner.h"

@interface ViewController ()<QRCodeScannerViewControllerDelegate>

@property (nonatomic,strong) UIButton *showQRReaderButton;
@property (nonatomic,strong) UIButton *makeQRCodeButton;
@property (nonatomic,strong) UILabel *qrReaderResultLabel;
@property (nonatomic,strong) UIImageView *qrImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewAndSubViews];
}

#pragma mark  扫描二维码
- (void)showQRReader:(id)sender {
    QRCScannerViewController *VC = [[QRCScannerViewController alloc] init];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark 生成二维码
- (void)makeQRCode:(UIButton *)sender{
    //带有图标的二维码
    self.qrImageView.image = [QRCScanner scQRCodeForString:@"你好，这是二维码的内容！" size:self.qrImageView.bounds.size.width fillColor:[UIColor blackColor] subImage:[UIImage imageNamed:@"jd"]];
}

#pragma mark - 扫描二维码完成后的代理方法
- (void)didFinshedScanning:(NSString *)result{
    self.qrReaderResultLabel.text = result;
}
#pragma mark - 初始化UI
- (void)initViewAndSubViews {
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.showQRReaderButton =
    [[UIButton alloc] initWithFrame:CGRectMake(0, 100, screenWidth, 44)];
    [self.showQRReaderButton setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [self.showQRReaderButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.showQRReaderButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.showQRReaderButton];
    [self.showQRReaderButton addTarget:self action:@selector(showQRReader:)
                      forControlEvents:UIControlEventTouchDown];
    
    self.makeQRCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 150, screenWidth, 44)];
    [self.makeQRCodeButton setTitle:@"生成二维码" forState:UIControlStateNormal];
    [self.makeQRCodeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.makeQRCodeButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.makeQRCodeButton];
    [self.makeQRCodeButton addTarget:self action:@selector(makeQRCode:)
                    forControlEvents:UIControlEventTouchDown];
    
    self.qrReaderResultLabel =
    [[UILabel alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 44)];
    self.qrReaderResultLabel.textAlignment = NSTextAlignmentCenter;
    self.qrReaderResultLabel.font = [UIFont systemFontOfSize:14.0];
    self.qrReaderResultLabel.textColor = [UIColor grayColor];
    self.qrReaderResultLabel.numberOfLines = 0;
    [self.view addSubview:self.qrReaderResultLabel];
    
    float qrimageWidth = 200;
    self.qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - qrimageWidth)/2,250,qrimageWidth,qrimageWidth)];
    [self.view addSubview:self.qrImageView];
}

@end
