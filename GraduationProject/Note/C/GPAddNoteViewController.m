//
//  GPAddNoteViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/25.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAddNoteViewController.h"
#import "GPNoteContentViewController.h"
#import "GPnoteModel.h"
#import <AVFoundation/AVFoundation.h>

@interface GPAddNoteViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIView *nameBackView;
@property (nonatomic, strong) UIView *coverBackView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *coverLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *selectImageButton;
@property (nonatomic, strong) UIImagePickerController* pickController;

@end

@implementation GPAddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加笔记本";
    [self setLeftBackButton];
    [self initUI];
}

- (void)selectImageButtonClick:(UIButton *)sender {
    __block NSArray <NSString *>*items = @[@"相册",@"相机"];
    [UIAlertController setSheetTitle:@"提示" msg:@"选择图片来源" ctr:self items:items handler:^(UIAlertAction * _Nullable action) {
        if ([items containsObject:action.title]) {
            NSInteger index = [items indexOfObject:action.title];
            if (index == 1) { // 进入相机
                [self intoCamera];
            } else { // 进入相册
                [self intoPhotoLibrary];
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

- (void)sureButtonClicked:(UIButton *)sender {
    if (self.nameTextField.text.length < 1) {
        [UIAlertController setTipsTitle:@"提示" msg:@"笔记本名字不能为空" ctr:self handler:^(UIAlertAction * _Nullable action) {
            // 无操作
        }];
    } else {
        GPNoteModel *model = [[GPNoteModel alloc] initWith:self.nameTextField.text image:self.coverImageView.image];
        !self.returnBlock?:self.returnBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {//照片
        UIImage* originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];//取出原生照片
        self.coverImageView.image = originalImage;
        [self.pickController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.pickController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy

- (void)initUI {
    [self.view addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(100);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(135);
    }];
    
    [self.backView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(5);
        make.right.bottom.mas_equalTo(-5);
    }];
    
    [self.view addSubview:self.nameBackView];
    [self.nameBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.backView.mas_bottom).offset(20);
    }];
    
    [self.nameBackView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self.nameBackView);
    }];
    
    [self.nameBackView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(self.nameBackView);
        make.left.equalTo(self.nameLabel.mas_right).offset(5);
    }];
    
    [self.view addSubview:self.coverBackView];
    [self.coverBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
        make.top.equalTo(self.nameBackView.mas_bottom).offset(1);
    }];
    
    [self.coverBackView addSubview:self.coverLabel];
    [self.coverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self.coverBackView);
    }];
    
    [self.coverBackView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self.coverBackView);
    }];
    
    [self.coverBackView addSubview:self.selectImageButton];
    [self.selectImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.coverBackView);
    }];
    
    [self.view addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.coverBackView.mas_bottom).offset(45);
        make.width.mas_equalTo(145);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - lazy

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowImageView;
}

- (UILabel *)coverLabel {
    if (!_coverLabel) {
        _coverLabel = [[UILabel alloc] init];
        _coverLabel.font = [UIFont systemFontOfSize:17];
        _coverLabel.textColor = [UIColor blackColor];
        _coverLabel.text = @"选择封面";
    }
    return _coverLabel;
}

- (UIView *)coverBackView {
    if (!_coverBackView) {
        _coverBackView = [[UIView alloc] init];
        _coverBackView.backgroundColor = [UIColor whiteColor];
    }
    return _coverBackView;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.textColor = [UIColor blackColor];
        _nameTextField.font = [UIFont systemFontOfSize:17];
        _nameTextField.placeholder = @"给笔记本起一个喜欢的名字吧";
        _nameTextField.textAlignment = NSTextAlignmentRight;
        [_nameTextField becomeFirstResponder];
    }
    return _nameTextField;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"笔记本名";
    }
    return _nameLabel;
}
- (UIView *)nameBackView {
    if (!_nameBackView) {
        _nameBackView = [[UIView alloc] init];
        _nameBackView.backgroundColor = [UIColor whiteColor];
    }
    return _nameBackView;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noteCover"]];
        _coverImageView.backgroundColor = GPBackgroundColor;
        _coverImageView.layer.masksToBounds = YES;
        _coverImageView.layer.cornerRadius = 5;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.shadowOpacity = 0.5f;
        _backView.layer.shadowOffset = CGSizeMake(1, 1);
        _backView.layer.shadowRadius = 2.0f;
        _backView.layer.shouldRasterize = YES;
        _backView.layer.masksToBounds = NO;
    }
    return _backView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        _sureButton.backgroundColor = GPBlueColor;
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _sureButton.titleLabel.textColor = [UIColor whiteColor];
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = 20;
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (UIButton *)selectImageButton {
    if (!_selectImageButton) {
        _selectImageButton = [[UIButton alloc] init];
        _selectImageButton.backgroundColor = [UIColor clearColor];
        [_selectImageButton addTarget:self action:@selector(selectImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectImageButton;
}

- (UIImagePickerController *)pickController {
    if (!_pickController) {
        _pickController = [[UIImagePickerController alloc] init];
        _pickController.delegate = self;
        _pickController.allowsEditing = NO;
    }
    return _pickController;
}
@end
