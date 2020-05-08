//
//  GPDrawViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/21.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPDrawViewController.h"
#import "GPDrawView.h"
#import "GPDrawControlView.h"
#import "GPColorPickerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "GPDrawModel.h"

@interface GPDrawViewController ()<GPDrawControlViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) GPDrawView *drawView;
@property (nonatomic, strong) GPDrawControlView *controlView;
@property (nonatomic, strong) UIImagePickerController* pickController;
@property (nonatomic, assign) BOOL isSaved;

@end

@implementation GPDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setRightImageWithName:@"arrow_up"];
    if (!self.drawModel) {
        self.title = @"新画板";
    }
    self.isSaved = NO;
    [self initUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isSaved) {
        !self.refreshBlock?:self.refreshBlock();
    }
}

- (void)setDrawModel:(GPDrawModel *)drawModel {
    _drawModel = drawModel;
    [self.drawView setPathsForView:drawModel.paths colors:drawModel.colors];
    self.title = drawModel.name;
}

- (void)initUI {
    [self.view addSubview:self.drawView];
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(65);
    }];
    
    [self.view addSubview:self.controlView];
}

- (void)clickRightButton:(UIButton *)sender {
    if (self.controlView.isRetract) {
        [self setRightImageWithName:@"arrow_up"];
    } else {
        [self setRightImageWithName:@"arrow_down"];
    }
    [self.controlView startUIViewAnimation];
}

#pragma mark - GPDrawControlViewDelegate

- (void)lineWideTextFieldDidEndEditing:(UITextField *)textField {
    NSInteger num = [textField.text integerValue];
    if (num > 50) {
        // 提示
    } else {
        self.drawView.lineWidth = num;
    }
}

- (void)itemDidClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            // 撤回
            [self.drawView undo];
            break;
        case 1:
            // 保存
        {
            __weak typeof(self) weakself = self;
            if (!self.drawModel) {
                [UIAlertController setTextFieldTitle:self.title msg:@"图片将会保存一份到相册" placeholder:@"为图片输入一个名字" ctr:self textReturn:^(NSString * _Nonnull text) {
                    if (text.length < 1) {
                        [UIAlertController setTipsTitle:@"提示" msg:@"图片名字不能为空，请重新保存！" ctr:self handler:^(UIAlertAction * _Nullable action) {
                            //
                        }];
                    } else {
                        [self.drawView save];
                        self.drawView.imageSaveBlock = ^(UIImage * _Nonnull image, NSError * _Nullable error, NSMutableArray * _Nonnull paths, NSMutableArray * _Nonnull colors) {
                            if (error) {
                                [UIAlertController setTipsTitle:@"错误提示" msg:error.description ctr:weakself handler:^(UIAlertAction * _Nullable action) {
                                    //
                                }];
                            } else {
                                GPDrawModel *model = [[GPDrawModel alloc] initWithName:text image:image paths:paths colors:colors];
                                [[DBTool shareInstance] saveDrawingWith:model complate:^(BOOL success) {
                                    // HUD和提示
                                    weakself.isSaved = success;
                                    [weakself.navigationController popViewControllerAnimated:YES];
                                }];
                            }
                        };
                    }
                }];
            } else {
                [self.drawView save];
                self.drawView.imageSaveBlock = ^(UIImage * _Nonnull image, NSError * _Nullable error, NSMutableArray * _Nonnull paths, NSMutableArray * _Nonnull colors) {
                    if (error) {
                        [UIAlertController setTipsTitle:@"错误提示" msg:error.description ctr:weakself handler:^(UIAlertAction * _Nullable action) {
                            //
                        }];
                    } else {
                        GPDrawModel *model = [[GPDrawModel alloc] initWithName:weakself.drawModel.name image:image paths:weakself.drawModel.paths colors:colors];
                        model.numberStr = weakself.drawModel.numberStr;
                        [[DBTool shareInstance] saveDrawingWith:model complate:^(BOOL success) {
                            // HUD和提示
                            weakself.isSaved = success;
                            [weakself.navigationController popViewControllerAnimated:YES];
                        }];
                    }
                };
            }
        }
            break;
        case 2:
            // 图片选择
        {
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
            break;
        case 3:
            // 橡皮擦
            [self.drawView eraser];
            break;
        case 4:
            // 画笔
            [self.drawView resetPen];
            break;
        default:
            break;
    }
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

- (void)colorButtonClicked:(UIButton *)sender {
    GPColorPickerViewController *vc = [[GPColorPickerViewController alloc] init];
    vc.colorBlock = ^(UIColor * _Nonnull pickerColor) {
        self.drawView.pathColor = !pickerColor?[UIColor blackColor]:pickerColor;
        sender.backgroundColor = pickerColor;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.controlView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {//照片
        UIImage* originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];//取出原生照片
        self.drawView.image = originalImage;
        [self.pickController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.pickController dismissViewControllerAnimated:YES completion:nil];
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

- (GPDrawView *)drawView{
    if (!_drawView) {
        _drawView = [[GPDrawView alloc]init];
    }
    return _drawView;
}

- (GPDrawControlView *)controlView {
    if (!_controlView) {
        _controlView = [[GPDrawControlView alloc] initWithFrame:CGRectZero];
        _controlView.delegate = self;
    }
    return _controlView;
}
@end
