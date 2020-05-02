//
//  GPDrawModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/2.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPDrawModel.h"

@implementation GPDrawModel

- (instancetype)initWithName:(NSString *)nameStr image:(UIImage *)image paths:(NSMutableArray *)paths {
    if (self = [super init]){
        self.name = nameStr;
        self.image = image;
        self.imageData = UIImagePNGRepresentation(image);
        self.paths = paths;
        self.pathsData = [NSJSONSerialization dataWithJSONObject:paths options:NSJSONWritingPrettyPrinted error:nil];
        self.numberStr = [NSDate getNowTimeTimestamp];
    }
    return self;
}

@end
