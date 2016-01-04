//
//  QJComposeViewController.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/1.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJComposeViewController.h"
#import "QJTextView.h"
#import "QJAccount.h"
#import "QJComposeToolbar.h"
#import "QJComposePhotosView.h"
#import "QJHttpTool.h"
#import "MBProgressHUD+MJ.h"

@interface QJComposeViewController () <UITextViewDelegate, QJComposeToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, weak) QJTextView *textView;
@property(nonatomic, weak) QJComposeToolbar *toolbar;
@property(nonatomic, weak) QJComposePhotosView *photosView;
@end

@implementation QJComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self SetupNavBar];
    
    [self SetupTextView];
    
    [self SetupToolbar];
    
    [self SetupPhotosView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.textView resignFirstResponder];
}

- (void)SetupPhotosView
{
    QJComposePhotosView *photosView = [[QJComposePhotosView alloc]init];
    CGFloat photosViewY = 100;
    photosView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - photosViewY);
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

- (void)SetupNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(ComposeView_CancleBarBtn_Click)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(ComposeView_SendBarBtn_Click)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

- (void)ComposeView_CancleBarBtn_Click
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ComposeView_SendBarBtn_Click
{
    if (self.photosView.photosViewTotalImages.count) {
        [self SendWithImageStatus];
    }else{
        [self SendWithoutImageStatus];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)SendWithImageStatus
{
    QJAccount *account = unArchiveAccount();
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = account.access_token;
    
    NSArray *images = self.photosView.photosViewTotalImages;

    [QJHttpTool postWithURL:QJAPP_POST_Compose_Picture_Status params:params imageArray:images success:^(id response) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)SendWithoutImageStatus
{
    QJAccount *account = unArchiveAccount();
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = account.access_token;

    [QJHttpTool postWithURL:QJAPP_POST_Compose_Status params:params success:^(id response) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        ALog(@"failure:%@", error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}


- (void)SetupTextView
{
    QJTextView *textView = [[QJTextView alloc]init];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    textView.font = [UIFont systemFontOfSize:15];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    self.textView = textView;
    self.textView.placeholder = @"分享新鲜事...";
    [QJNotification addObserver:self selector:@selector(Compose_TextDidChang) name:UITextViewTextDidChangeNotification object:textView];
    
    [QJNotification addObserver:self  selector:@selector(Compose_KeyboaredWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [QJNotification addObserver:self  selector:@selector(Compose_KeyboaredWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)Compose_KeyboaredWillShow:(NSNotification *)note
{
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
    }];
}

- (void)Compose_KeyboaredWillHide:(NSNotification *)note
{
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

- (void)Compose_TextDidChang
{
    self.navigationItem.rightBarButtonItem.enabled = !(self.textView.text.length == 0);
    if (self.textView.text.length) {
        self.textView.placeholder = nil;
    }else{
        self.textView.placeholder = @"分享新鲜事...";
    }
}


- (void)SetupToolbar
{
    QJComposeToolbar *toolbar = [[QJComposeToolbar alloc]init];
    
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
}
#pragma mark -- QJComposeToolbar delegate
- (void)composeToolbar:(QJComposeToolbar *)toolbar didClickedButton:(QJComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case QJComposeToolbarButtonTypeCamera:
            [self Compose_OpenCamera];
            break;
        case QJComposeToolbarButtonTypePicture:
            [self Compose_OpenPhotoLibrary];
            break;
        default:
            break;
    }
}

- (void)Compose_OpenCamera
{
    UIImagePickerController *imagePickCtrl = [[UIImagePickerController alloc]init];
    imagePickCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickCtrl.delegate = self;
    [self presentViewController:imagePickCtrl animated:YES completion:nil];
}

- (void)Compose_OpenPhotoLibrary
{
    UIImagePickerController *imagePickCtrl = [[UIImagePickerController alloc]init];
    imagePickCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickCtrl.delegate = self;
    [self presentViewController:imagePickCtrl animated:YES completion:nil];
}

#pragma mark -- imagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma  mark -- textview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [QJNotification removeObserver:self];
}
@end
