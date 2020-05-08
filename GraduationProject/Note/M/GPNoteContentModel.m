//
//  GPNoteContentModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPNoteContentModel.h"

@implementation GPNoteContentModel

- (instancetype)initWithTime:(NSString *)timeStr title:(NSString *)titleStr content:(NSAttributedString *)contentStr image:(UIImage *)image {
    if (self = [super init]) {
        self.timeStr = timeStr;
        self.titleStr = titleStr;
        self.image = image;
        NSData *imageData = UIImagePNGRepresentation(image);
        self.imageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSArray *arr = @[contentStr];
        self.contentData = [NSKeyedArchiver archivedDataWithRootObject:arr];
        self.contentNumberStr = [NSDate getNowTimeTimestamp];
    }
    return self;
}
@end
