//
//  QRCScannerViewController.m
//  QRScannerDemo
//  blog:www.zhangfei.tk
//  Created by zhangfei on 15/10/15.
//  Copyright © 2015年 zhangfei. All rights reserved.
//

#import "QRCScannerViewController.h"
#import "QRCScanner.h"

@interface QRCScannerViewController ()<QRCodeScanneDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation QRCScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QRCScanner *scanner = [[QRCScanner alloc]initQRCScannerWithView:self.view];
    scanner.delegate = self;
    [self.view addSubview:scanner];
    
    //从相册选取二维码
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(readerImage)];
    
}
#pragma mark - 扫描二维码成功后结果的代理方法
- (void)didFinshedScanningQRCode:(NSString *)result{
    
    if ([self.delegate respondsToSelector:@selector(didFinshedScanning:)]) {
        [self.delegate didFinshedScanning:result];
    }
    else{
        NSLog(@"没有收到扫描结果，看看是不是没有实现协议！");
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 从相册获取二维码图片
- (void)readerImage{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoPicker.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:photoPicker animated:YES completion:NULL];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *result = [QRCScanner scQRReaderForImage:srcImage];
    
    if ([self.delegate respondsToSelector:@selector(didFinshedScanning:)]) {
        [self.delegate didFinshedScanning:result];
    }
    else{
        NSLog(@"没有收到扫描结果，看看是不是没有实现协议！");
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
