//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  在分类方法中声明@property，只会生成方的生命，不会生成方法的实现和带有下划线_的成员变量
    -(CGFloat)x; //get方法
    -(void)setX:(CGFloat)x; // set方法
*/
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@end
