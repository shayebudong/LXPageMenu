//
//  lxMenuViewController.h
//  Menu
//
//  Created by ee on 16/8/18.
//  Copyright © 2016年 ee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lxMenuViewController : UIViewController


/**
 *  添加字控制器
 */
-(void)addChildVc:(UIViewController *)vc;

/**
 *  设置标题栏按钮显示的个数
 */
@property (nonatomic,assign) NSInteger titleRowNumber;

/**
 *  设置标题栏上按钮的文字
 */
-(NSMutableArray *)btnArray;
@end
