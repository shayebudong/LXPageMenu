//
//  ViewController.m
//  Menu
//
//  Created by ee on 16/8/13.
//  Copyright © 2016年 ee. All rights reserved.
//

#import "ViewController.h"
#import "lxMenuViewController.h"
#import "lxTestViewController.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //创建菜单视图控制器
    lxMenuViewController *menu  = [[lxMenuViewController alloc]init];
    
    //创建标题栏按钮的标题
    NSArray *array = @[@"全部",@"视频",@"声音",@"科技",@"体育",@"文化",@"军事"];
    [menu.btnArray addObjectsFromArray:array];
    
    //给菜单控制器添加子控制器
    lxTestViewController *test1= [[lxTestViewController alloc]init];
    [menu addChildVc:test1];
    lxTestViewController *test2= [[lxTestViewController alloc]init];
    [menu addChildVc:test2];
    lxTestViewController *test3= [[lxTestViewController alloc]init];
    [menu addChildVc:test3];
    lxTestViewController *test4= [[lxTestViewController alloc]init];
    [menu addChildVc:test4];
    lxTestViewController *test5= [[lxTestViewController alloc]init];
    [menu addChildVc:test5];
    lxTestViewController *test6= [[lxTestViewController alloc]init];
    [menu addChildVc:test6];
    lxTestViewController *test7= [[lxTestViewController alloc]init];
    [menu addChildVc:test7];
    
    //默认显示5个,可以根据实际情况设置
    menu.titleRowNumber = 5;
    
    //添加到当前控制器
    [self.view addSubview:menu.view];
    [self addChildViewController:menu];
}
@end




