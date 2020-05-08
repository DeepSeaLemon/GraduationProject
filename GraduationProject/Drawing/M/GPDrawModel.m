//
//  GPDrawModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/2.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPDrawModel.h"

@interface GPDrawModel ()

@end

@implementation GPDrawModel

- (instancetype)initWithName:(NSString *)nameStr image:(UIImage *)image paths:(NSMutableArray *)paths colors:(nonnull NSMutableArray *)colors{
    if (self = [super init]){
        self.name = nameStr;
        self.image = image;
        self.paths = paths;
        self.colors = colors;
        self.imageData = [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        self.pathsData = [NSKeyedArchiver archivedDataWithRootObject:paths];
        self.colorsData = [NSKeyedArchiver archivedDataWithRootObject:colors];
        self.numberStr = [NSDate getNowTimeTimestamp];
    }
    return self;
}
@end
