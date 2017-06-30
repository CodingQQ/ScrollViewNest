//
//  UpTitleDownLineBtn.m
//  Mooc
//
//  Created by LeeQQ on 17/1/5.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import "UpTitleDownLineBtn.h"
#define LineH 2

@implementation UpTitleDownLineBtn


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    CGRect rect = titleRect;
    rect.origin.y = contentRect.size.height - LineH;
    rect.size.height = LineH;
    return rect;
    
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGRect rect = [super titleRectForContentRect:contentRect];
    rect.origin.y = rect.origin.y - LineH;
    
    return rect;
}

@end
