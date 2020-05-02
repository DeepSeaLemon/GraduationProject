//
//  UIAlertController+GP.m
//  GraduationProject
//
//  Created by CYM on 2020/5/1.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "UIAlertController+GP.h"

@implementation UIAlertController (GP)

+ (void)setTitle:(NSString *)titleStr msg:(NSString *)msgStr ctr:(UIViewController *)ctr sureHandler:(void(^)(UIAlertAction *action))sureHandler cancelHandler:(void(^)(UIAlertAction *action))cancelHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleStr message:msgStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !sureHandler?:sureHandler(action);
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        !cancelHandler?:cancelHandler(action);
    }];
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [ctr presentViewController:alert animated:YES completion:nil];
}

+ (void)setTipsTitle:(NSString *)titleStr msg:(NSString *)msgStr ctr:(UIViewController *)ctr handler:(void(^)(UIAlertAction  * _Nullable action))sureHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleStr message:msgStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        !sureHandler?:sureHandler(action);
    }];
    [alert addAction:sureAction];
    [ctr presentViewController:alert animated:YES completion:nil];
}

+ (void)setSheetTitle:(NSString *)titleStr msg:(NSString *)msgStr ctr:(UIViewController *)ctr items:(NSArray <NSString *>*)itemsArr handler:(void(^)(UIAlertAction * _Nullable action))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleStr message:msgStr preferredStyle:UIAlertControllerStyleActionSheet];
    [itemsArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !handler?:handler(action);
        }];
        [alert addAction:action];
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancle];
    [ctr presentViewController:alert animated:YES completion:nil];
}

+ (void)setTextFieldTitle:(NSString *)titleStr msg:(NSString *)msgStr placeholder:(NSString *)placeholderStr ctr:(UIViewController *)ctr textReturn:(void(^)(NSString * text))textReturn {
    __block NSString *str = placeholderStr;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleStr message:msgStr preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = str;
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        for(UITextField *textField in alert.textFields){
            !textReturn?:textReturn(textField.text);
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [ctr presentViewController:alert animated:YES completion:nil];
}
@end
