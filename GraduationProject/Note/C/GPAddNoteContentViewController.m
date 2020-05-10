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
#import "GPNoteContentModel.h"

@interface GPAddNoteContentViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GPPlaceImageViewDelegate>

@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UITextField *titleFiled;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIView *backImageView;
@property (nonatomic, strong)UIImagePickerController* pickController;
@property (nonatomic, strong)GPPlaceImageView *placeImageView;
@end

@implementation GPAddNoteContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = (self.contentModel)?self.contentModel.titleStr:@"新笔记";
    [self setLeftBackButton];
    [self setRightText:@"选项"];
    [self initUI];
}

- (void)setContentModel:(GPNoteContentModel *)contentModel {
    _contentModel = contentModel;
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:contentModel.contentData];
    self.textView.attributedText = arr.firstObject;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.timeLabel.text = [NSString stringWithFormat:@"     %@",[dateFormater stringFromDate:date]];
    self.titleFiled.text = contentModel.titleStr;
}

- (void)clickRightButton:(UIButton *)sender {
    __block NSArray *arr = @[@"完成编辑",@"从相册插入图片",@"拍摄后插入图片"];
    [UIAlertController setSheetTitle:@"选项" msg:@"" ctr:self items:arr handler:^(UIAlertAction * _Nullable action) {
        if ([arr containsObject:action.title]) {
            NSInteger index = [arr indexOfObject:action.title];
            if (index == 0) {
                self.titleFiled.userInteractionEnabled = NO;
                self.textView.userInteractionEnabled = NO;
                NSAttributedString *attStr = (self.textView.attributedText.length < 1)?[[NSAttributedString alloc] initWithString:self.textView.text]:self.textView.attributedText;
                UIImage *image = [UIImage convertViewToImage:self.backImageView];
                if (self.contentModel) {
                    GPNoteContentModel *model = [[GPNoteContentModel alloc] initWithTime:self.timeLabel.text title:self.titleFiled.text content:attStr image:image];
                    self.contentModel.timeStr = model.timeStr;
                    self.contentModel.titleStr = model.titleStr;
                    self.contentModel.image = model.image;
                    self.contentModel.imageStr = model.imageStr;
                    self.contentModel.contentData = model.contentData;
                    !self.returnBlock?:self.returnBlock(self.contentModel);
                } else {
                    GPNoteContentModel *model = [[GPNoteContentModel alloc] initWithTime:self.timeLabel.text title:self.titleFiled.text content:attStr image:image];
                    model.numberStr = self.numberStr;
                    !self.returnBlock?:self.returnBlock(model);
                }
                [self.navigationController popViewControllerAnimated:YES];
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
        self.placeImageView = nil;
    }else {
        // 确认
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.textView.text];
        NSTextAttachment *attchment = [[NSTextAttachment alloc] init];
        attchment.bounds = self.placeImageView.frame;//设置frame
        attchment.image = [UIImage scaleImage:self.placeImageView.placeImage toScale:self.placeImageView.frame.size.width/self.placeImageView.placeImage.size.width];
        NSAttributedString* string = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attchment)];
        [attributedString appendAttributedString:string]; //添加到尾部
        self.textView.attributedText = attributedString;
        self.textView.font = [UIFont systemFontOfSize:17];
        [self.placeImageView removeFromSuperview];
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
        self.placeImageView = placeImageView;
        [self.textView addSubview:placeImageView];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.pickController dismissViewControllerAnimated:YES completion:nil];
}


- (void)initUI {
    [self.view addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(Height_NavBar+1);
    }];
    
    [self.backImageView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    
    [self.backImageView addSubview:self.titleFiled];
    [self.titleFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.timeLabel.mas_bottom);
    }];
    
    [self.backImageView addSubview:self.backView];
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

- (UIView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIView alloc] init];
        _backImageView.backgroundColor = GPGrayColor;
    }
    return _backImageView;
}

@end
