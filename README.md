# LXPageMenu
一个菜单按钮视图，可以滑动，并可以点击视图上的按钮切换对应的控制器。注意：只需将lxMenupageController和UIview的Extension四个文件拖到项目即可，也可以按照自己喜欢或者需求修改 Menu上按钮的个数，按钮之间的间距，以及属性等等。

![image](https://github.com/shayebudong/LXPageMenu/blob/master/LXPageMenu/LXPageMenu/example.png)

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
    以上就可以实现基本效果，如果不符合要求，客官可以自行改之。有什么问题可以直接邮箱（605345534@q q.com）联系我，期待您的提问。
