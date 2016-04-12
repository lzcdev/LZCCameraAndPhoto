//
//  ViewController.m
//  LZCCameraAndPhoto
//
//  Created by trustway_mac on 16/4/12.
//  Copyright © 2016年 trustway_mac. All rights reserved.
//
#define ScreenX [UIScreen mainScreen].bounds.size.width/375
#define ScreenY [UIScreen mainScreen].bounds.size.height/667
#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIActionSheet *actionSheet;
@property(nonatomic,strong)UIImageView *imageMain;

@end

@implementation ViewController

@synthesize actionSheet = _actionSheet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createUI];
    NSLog(@"lzc");
}

- (void)createUI
{
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cameraBtn.frame = CGRectMake(100*ScreenX, 100*ScreenY, 175*ScreenX, 40*ScreenY);
    [cameraBtn setTitle:@"选择照片" forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: cameraBtn];
    
    
    _imageMain = [[UIImageView alloc]initWithFrame:CGRectMake(100*ScreenX, 200*ScreenY, 175*ScreenX, 175*ScreenY)];
    [self.view addSubview:self.imageMain];

}
- (void)cameraBtnClick:(UIButton *)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    [self.actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                //来源:相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                //来源:相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    }
    else {
        if (buttonIndex == 1) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    //赋值
    _imageMain.image = [info objectForKey:UIImagePickerControllerOriginalImage];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
