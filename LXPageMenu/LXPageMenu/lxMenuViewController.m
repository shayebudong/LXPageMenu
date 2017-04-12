//
//  lxMenuViewController.m
//  Menu
//
//  Created by ee on 16/8/18.
//  Copyright © 2016年 ee. All rights reserved.
//

#import "lxMenuViewController.h"
#import "UIView+Extension.h"
#import "lxTestViewController.h"

#define statusAndNavBarHeight 64
#define tabbarHeight 49
#define titleDefaltHeight 35
#define btnsDefaultNumber 5
@interface lxMenuViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,strong) UIScrollView *titleScrollView;
@property (nonatomic,assign) CGFloat btnwidth;
@property (nonatomic,weak) UIView *indicator;
@property (nonatomic,strong) UIButton *seclctedBtn;
@property (nonatomic,strong) UIScrollView *contentView;

@property (nonatomic,assign) NSInteger indexLast;


@end

@implementation lxMenuViewController

/**
 *  创建标题栏滚动的scrollView
 */
-(UIScrollView *)titleScrollView{
    if (_titleScrollView == nil) {
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, statusAndNavBarHeight, self.view.width, titleDefaltHeight)];
        _titleScrollView.backgroundColor = [UIColor clearColor];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_titleScrollView];
        
    }
    return _titleScrollView;
}

/**
 *  接受标题图标名称的数组
 */
-(NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

/**
 * 设置标题栏所要显示的按钮个数，默认是五个，不超过五个按照实际个数算
 */
-(void)setTitleRowNumber:(NSInteger)titleRowNumber
{
    _titleRowNumber = titleRowNumber;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitleScrollView];
    [self addTitleToTitleScrollView];
    [self setupContentView];
}

/**
 *  创建TitleScrollView
 */
-(void)setupTitleScrollView
{
    CGFloat btnwidth = 0;
    NSInteger btnCountDefault = [self btnCount];
    if (self.btnArray.count>(self.titleRowNumber ? self.titleRowNumber:btnCountDefault)) {
        btnwidth = self.view.width/(self.titleRowNumber ? self.titleRowNumber:btnCountDefault);
    }else{
        btnwidth = self.view.width/self.btnArray.count;
    }
    self.btnwidth = btnwidth;
    self.titleScrollView.contentSize = CGSizeMake(self.btnArray.count*btnwidth, 0);
    
}

/**
 *  给标题栏添加按钮，并设置标题栏文字
 */
-(void)addTitleToTitleScrollView
{
    for (int i = 0; i<self.btnArray.count; i++) {
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.btnwidth*i, 0, self.btnwidth, titleDefaltHeight)];
        
        titleBtn.tag = i;
        [titleBtn setTitle:[NSString stringWithFormat:@"%@",self.btnArray[i]] forState:UIControlStateNormal];
        
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [titleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        
        [titleBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside ];
        
        [self.titleScrollView addSubview:titleBtn];
        
        //设置默认点击第一个按钮
        if (titleBtn.tag == 0) {
            titleBtn.selected = YES;
            self.seclctedBtn = titleBtn;
            [titleBtn.titleLabel sizeToFit];
            
            //创建红色指示器，初始位置在第一个按钮下边
            UIView *indicator = [[UIView alloc]init];
            indicator.backgroundColor = [UIColor redColor];
            indicator.width = titleBtn.titleLabel.width;
            indicator.centerX = titleBtn.centerX;
            indicator.height = 2;
            indicator.y = self.titleScrollView.height - indicator.height ;
            [self.titleScrollView addSubview:indicator];
            self.indicator = indicator;
        }
    }
}

/**
 *  点击按钮实现控制器的切换
 */
-(void)click:(UIButton *)button
{
    //记录点击的按钮
    self.seclctedBtn.selected = NO;
    button.selected = YES;
    self.seclctedBtn = button;
    
    //红色指示器随着按钮点击发生滚动
    [UIView animateWithDuration:0.3 animations:^{
        self.indicator.width = button.titleLabel.width;
        self.indicator.centerX = button.centerX ;
    }];
    
    //切换按钮点击对应的控制器
    CGPoint offset = self.contentView.contentOffset;
    offset.x = self.contentView.width*button.tag;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 *  添加字控制器，由外部控制
 */
-(void)addChildVc:(UIViewController *)vc
{
    [self addChildViewController:vc];
}

/**
 *  创建控制器的ScrollView，以便字控制器的滚动
 */
-(void)setupContentView
{
    //禁止系统对scrollView内边距的调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建一个scrollView
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    
    contentView.delegate = self ;
    
    contentView.backgroundColor = [UIColor clearColor];
    CGFloat titleScrollViewY = CGRectGetMaxY(self.titleScrollView.frame);
    
    
    //设置scrollView的内容开始／截止  显示内容的范围（默认是上边64，下边49）
    contentView.contentInset = UIEdgeInsetsMake(titleScrollViewY, 0, tabbarHeight, 0);
    
    
    contentView.showsHorizontalScrollIndicator = NO;
    [self.view insertSubview:contentView atIndex:0];
    
    contentView.contentSize = CGSizeMake(self.childViewControllers.count*self.view.width, 0);
    contentView.pagingEnabled = YES;
    
    self.contentView = contentView;
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark ---<UIScrollViewDelegate>

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.width = scrollView.width;
    vc.view.height = self.view.height - CGRectGetMaxY(self.titleScrollView.frame) -tabbarHeight;
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    [scrollView addSubview:vc.view];
    
    //根据控制器滚动的位置，设置titleScrollView的偏移量
     NSInteger btnCountDefault = [self btnCount];
    if (self.btnArray.count - index <(self.titleRowNumber ? self.titleRowNumber:btnCountDefault)) {
        if (self.indexLast>index) {
            CGPoint offset = self.titleScrollView.contentOffset;
            offset.x = self.btnwidth*(self.btnArray.count - (self.titleRowNumber ? self.titleRowNumber:btnCountDefault));
            
            [self.titleScrollView setContentOffset:offset animated:YES];
        }
    }else{
        
        CGPoint offset = self.titleScrollView.contentOffset;
        offset.x = self.btnwidth*index;
        [self.titleScrollView setContentOffset:offset animated:YES];
    }
    //记录上一次点击按钮的索引
    self.indexLast = index;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    if (index == 0) {
        UIButton *btn=  self.titleScrollView.subviews[index];
        [self click:btn];
    }else{
        UIButton *btn=  self.titleScrollView.subviews[index+1];
        [self click:btn];
    }
}

/**
 *  判断按钮数组里面个数是否大于5
 */
-(NSInteger)btnCount
{
    if (self.btnArray.count>btnsDefaultNumber) {
        return btnsDefaultNumber;
    }else{
        return self.btnArray.count;
    }
}



@end
