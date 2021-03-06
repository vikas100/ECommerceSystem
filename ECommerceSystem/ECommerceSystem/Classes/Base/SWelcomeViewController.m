//
//  SWelcomeViewController.m
//  ECommerceSystem
//
//  Created by yin tian on 2018/11/27.
//  Copyright © 2018 yin tian. All rights reserved.
//

#import "SWelcomeViewController.h"
#import "SLoginViewController.h"


@interface SWelcomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIWindow *window;

@end

@implementation SWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    NSArray *imageNames = @[@"welcome1", @"welcome2",@"welcome3",@"welcome4",];
    for (int i = 0; i < imageNames.count; i ++) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNames[i]]];
        iv.frame = CGRectMake(i * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:iv];
    }
    //设置内容的大小
    //因为不需要竖向滚动，所以高度只要小于scrollview的高度就可以
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * imageNames.count, 0);
    //以翻页形式进行滚动
    scrollView.pagingEnabled = YES;
    
    //  添加页数控制视图 new = alloc + init
    UIPageControl *pageControl = [UIPageControl new
                                  ];
    //不要加到滚动视图中， 会随着滚动消失掉
    [self.view addSubview:pageControl];
    //    设置常用属性,距离屏幕下方60像素。
    pageControl.frame = CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 30);
    //    设置圆点的个数
    pageControl.numberOfPages = imageNames.count;
    //    设置没有被选中时圆点的颜色
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    //    设置选中时圆点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //    关闭分页控件的用户交互功能
    pageControl.userInteractionEnabled = NO;
    
    // 为了检测滚动视图的偏移量，引入代理
    scrollView.delegate = self;
    
    pageControl.tag = 1000;
    //为最后一页添加按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"点击进入" forState:UIControlStateNormal];
    //因为是滚动视图最后一页，所以要添加到滚动视图中
    [scrollView addSubview:btn];
    btn.frame = CGRectMake(0, 0, 100, 40);
    //把按钮添加到第四页的中心
    btn.center = CGPointMake((imageNames.count - 0.5) * scrollView.frame.size.width, scrollView.frame.size.height - 100);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)click{
    NSLog(@"进入应用");
    
    SLoginViewController *vc = [[SLoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}


//当滚动视图发生位移，就会进入下方代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:1000];
    //取得偏移量
    CGPoint point = scrollView.contentOffset;
    //根据滚动的位置来决定当前是第几页
    //可以用 round()  C语言方法进行 四舍五入操作
    NSInteger index = round(point.x/scrollView.frame.size.width);
    //设置分页控制器的当前页面
    pageControl.currentPage = index;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
