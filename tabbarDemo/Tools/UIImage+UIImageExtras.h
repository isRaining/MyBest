//
//  UIImage+UIImageExtras.h
//  Micro Language
//
//  Created by apple on 14-12-1.
//  Copyright (c) 2014年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageExtras)

//用来缩放图片，设置目标CGSize
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
@end
