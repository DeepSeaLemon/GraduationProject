//
//  GPNoteModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPNoteModel.h"

@implementation GPNoteModel

- (instancetype)initWith:(NSString *)name image:(UIImage *)image {
    if (self = [super init]) {
        self.name = name;
        self.numberStr = [NSDate getNowTimeTimestamp];
        self.coverImage = image;
        NSData *imageDate = UIImagePNGRepresentation(image);
        self.coverImageStr = [imageDate base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return self;
}

@end
