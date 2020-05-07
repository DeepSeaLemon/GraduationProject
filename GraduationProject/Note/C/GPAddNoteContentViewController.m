//
//  GPAddNoteContentViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAddNoteContentViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "GPPlaceImageView.h"

@interface GPAddNoteContentViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GPPlaceImageViewDelegate>

@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UITextField *titleFiled;
@property (nonatomic, strong)UIView *backView;

@property (nonatomic, strong) UIImagePickerController* pickController;

@end

@implementation GPAddNoteContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新笔记";
    [self setLeftBackButton];
    [self setRightText:@"选项"];
    [self initUI];
}

- (void)clickRightButton:(UIButton *)sender {
    __block NSArray *arr = @[@"完成编辑",@"从相册插入图片",@"拍摄后插入图片"];
    [UIAlertController setSheetTitle:@"选项" msg:@"" ctr:self items:arr handler:^(UIAlertAction * _Nullable action) {
        if ([arr containsObject:action.title]) {
            NSInteger index = [arr indexOfObject:action.title];
            if (index == 0) {
                // 返回内容
            } else if (index == 1) {
                [self intoPhotoLibrary];
            } else {
                [self intoCamera];
            }
        }
    }];
}

- (void)intoPhotoLibrary {
    self.pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.pickController animated:YES completion:nil];
}

- (void)intoCamera {
    if ([UIImagePickerController isSourceTypeAvailable : UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
            NSLog(@"无权限");
        }else{
            self.pickController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.pickController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            [self presentViewController:self.pickController animated:YES completion:nil];
        }
    }else{
        NSLog(@"不存在相机");
    }
}

#pragma mark - GPPlaceImageViewDelegate

- (void)placeImageViewClickClose:(BOOL)isClick {
    if (isClick) {
        // 关闭
    }else {
        // 确认
    }
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {//照片
        UIImage* originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];//取出原生照片
        [self.pickController dismissViewControllerAnimated:YES completion:nil];
        GPPlaceImageView *placeImageView = [[GPPlaceImageView alloc] initWithImage:originalImage];
        placeImageView.delegate = self;
        [self.view addSubview:placeImageView];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.pickController dismissViewControllerAnimated:YES completion:nil];
}


- (void)initUI {
    [self.view addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(65);
        make.height.mas_equalTo(25);
    }];
    
    [self.view addSubview:self.titleFiled];
    [self.titleFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.timeLabel.mas_bottom);
    }];
    
    [self.view addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.titleFiled.mas_bottom).offset(1);
    }];
    
    [self.backView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(0);
    }];
}

#pragma mark - lazy

- (UIImagePickerController *)pickController {
    if (!_pickController) {
        _pickController = [[UIImagePickerController alloc] init];
        _pickController.delegate = self;
        _pickController.allowsEditing = NO;
    }
    return _pickController;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textColor = [UIColor blackColor];
        _textView.backgroundColor = [UIColor whiteColor];
        [_textView becomeFirstResponder];
    }
    return _textView;
}


- (UITextField *)titleFiled {
    if (!_titleFiled) {
        _titleFiled = [[UITextField alloc] init];
        _titleFiled.placeholder = @"笔记标题";
        _titleFiled.backgroundColor = [UIColor whiteColor];
        _titleFiled = [UITextField setTextShowLeftIndent:_titleFiled];
    }
    return _titleFiled;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = GPDeepGrayColor;
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
        _timeLabel.text = [NSString stringWithFormat:@"     %@",[dateFormater stringFromDate:date]];
    }
    return _timeLabel;
}

@end
