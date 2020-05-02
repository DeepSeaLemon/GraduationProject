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

- (instancetype)initWithName:(NSString *)nameStr image:(UIImage *)image paths:(NSMutableArray *)paths {
    if (self = [super init]){
        self.name = nameStr;
        self.image = image;
        self.paths = paths;
        self.imageIndex = [NSNumber numberWithInt:-1];
        NSData *imageD = UIImagePNGRepresentation(image);
        self.imageData = [imageD base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        NSMutableArray *mPaths = [NSMutableArray array];
        NSString *mImages = [NSString string];
        
        for (NSInteger i = 0; i < paths.count; i++) {
            if ([paths[i] isKindOfClass:[UIBezierPath class]]) {
                UIBezierPath *path = paths[i];
                [mPaths addObject:[self convertBezierPathToNSString:path]];
            } else {
                NSData *imageData = UIImagePNGRepresentation(paths[i]);
                mImages = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                self.imageIndex = [NSNumber numberWithInteger:i];
            }
        }
        self.pathsData = [mPaths componentsJoinedByString:@"-"];
        self.pathsImageData = mImages;
        self.numberStr = [NSDate getNowTimeTimestamp];
    }
    return self;
}

- (void)restorePathsArrayWith:(NSString *)pathsStr pathsImage:(NSString *)pathsImageStr imageIndex:(NSNumber *)imageIndex {
    NSArray *stringArray = [pathsStr componentsSeparatedByString:@"-"];
    self.paths = [NSMutableArray array];
    self.imageIndex = imageIndex;
    for (NSInteger i = 0; i<stringArray.count; i++) {
        NSString *str = stringArray[i];
        if (str.length > 3) {
            [self.paths addObject:[self convertNSStringToBezierPath:str]];
        }
    }
    if (pathsImageStr.length > 3) {
        NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:pathsImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *pathImage = [UIImage imageWithData:decodedImageData];
        [self.paths insertObject:pathImage atIndex:[imageIndex integerValue]];
    }
}

- (NSString*)convertBezierPathToNSString:(UIBezierPath*) bezierPath {
    NSString *pathString = @"";
    CGPathRef yourCGPath = bezierPath.CGPath;
    NSMutableArray *bezierPoints = [NSMutableArray array];
    CGPathApply(yourCGPath, (__bridge void *)(bezierPoints), MyCGPathApplierFunc);
    for (int i = 0; i < [bezierPoints count]; ++i) {
        CGPoint point = [bezierPoints[i] CGPointValue];
        pathString = [pathString stringByAppendingString:[NSString stringWithFormat:@"%f",point.x]];
        pathString = [pathString stringByAppendingFormat:@"%@",@","];
        pathString = [pathString stringByAppendingString:[NSString stringWithFormat:@"%f",point.y]];
        pathString = [pathString stringByAppendingString:@"|"];
    }
    return pathString;
}

void MyCGPathApplierFunc (void *info, const CGPathElement *element) {
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    
    switch(type) {
        case kCGPathElementMoveToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddLineToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            break;
            
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
            break;
            
        case kCGPathElementCloseSubpath: // contains no point
            break;
    }
}

- (UIBezierPath*)convertNSStringToBezierPath:(NSString*) bezierPathString {
    NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
    NSInteger length = 0;
    
    //解析字符串
    NSString *separatorString1 = @",";
    NSString *separatorString2 = @"|";
    
    NSScanner *aScanner = [NSScanner scannerWithString:bezierPathString];
    
    while (![aScanner isAtEnd]) {
        
        NSString *xString, *yString;
        
        [aScanner scanUpToString:separatorString1 intoString:&xString];
        [aScanner setScanLocation:[aScanner scanLocation]+1];
        
        [aScanner scanUpToString:separatorString2 intoString:&yString];
        [aScanner setScanLocation:[aScanner scanLocation]+1];
        CGPoint point;
        point.x = [xString floatValue];
        point.y = [yString floatValue];
        
        [pointsArray addObject:[NSValue valueWithCGPoint:point]];
    }
    //首先将字符串解析为CGPoint数组,再将数组初始化UIBeizerPath
    length = [pointsArray count];
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:[pointsArray[0] CGPointValue] ];
    for (NSUInteger j=1; j< length; j++) {
        [bezierPath addLineToPoint:[pointsArray[j] CGPointValue] ];
    }
    return bezierPath;
}

@end
