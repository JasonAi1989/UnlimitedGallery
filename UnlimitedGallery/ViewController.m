//
//  ViewController.m
//  UnlimitedGallery
//
//  Created by jason on 15/10/24.
//  Copyright (c) 2015年 JasonAi. All rights reserved.
//

#import "ViewController.h"

//for iPhone 6
#define SCREEN_WIDTH    375
#define SCREEN_HEIGHT   667
#define IMAGEVIEW_COUNT 3

@interface ViewController ()<UIScrollViewDelegate>{
    
    UIScrollView *_scrollView;
    UIImageView *_leftImageView;
    UIImageView *_middleImageView;
    UIImageView *_righttImageView;
    UIPageControl *_pageControl;  //在页面中显示为点
    UILabel *_label;
    
    NSMutableDictionary *_imageData;
    int _imageCount;
    int _currentImageIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //加载plist中的图片数据到字典变量中
    [self loadImageData];
    
    //添加控件到主View中
    [self addScrollView];
    
    [self addImageView];
    
    [self addPageControl];
    
    [self addLabel];
    
    //设置默认图片
    [self setDefaultImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadImageData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"imageInfo" ofType:@"plist"];
    
    _imageData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    _imageCount = (int)_imageData.count;
}

- (void)addScrollView {
    //这里的bounds就是iPhone 6屏幕像素点的尺寸{{0, 0}, {375, 667}}，但是，分辨率为750.0 x 1334.0
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:_scrollView];
    
    //设置代理
    _scrollView.delegate = self;
    
    //设置三个屏幕宽度大小的尺寸
    _scrollView.contentSize = CGSizeMake(IMAGEVIEW_COUNT*SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //设置当前显示界面的位置
    //_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    
    //设置分页控制
    _scrollView.pagingEnabled = YES;
    
    //设置滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)addImageView {
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _righttImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _leftImageView.contentMode = UIViewContentModeScaleToFill;
    _middleImageView.contentMode = UIViewContentModeScaleToFill;
    _righttImageView.contentMode = UIViewContentModeScaleToFill;
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_middleImageView];
    [_scrollView addSubview:_righttImageView];
}

- (void)addPageControl {
    _pageControl = [[UIPageControl alloc] init];
    
    //size: 71.0, 37.0
    CGSize size = [_pageControl sizeForNumberOfPages:_imageCount];
    
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-50);
    
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    
    _pageControl.numberOfPages = _imageCount;
    
    [self.view addSubview:_pageControl];
}

- (void)addLabel {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];

    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    
    [self.view addSubview:_label];
}

- (NSString *)getRealImageName:(int) index{
    NSString *key = [NSString stringWithFormat:@"%i.png", index];
    return _imageData[key];
}

- (void)setDefaultImage {
    _leftImageView.image = [UIImage imageNamed:[self getRealImageName:_imageCount - 1]];
    
    _middleImageView.image = [UIImage imageNamed:[self getRealImageName:0]];

    _righttImageView.image = [UIImage imageNamed:[self getRealImageName:1]];

    _currentImageIndex = 0;
    
    _pageControl.currentPage = _currentImageIndex;
    
    NSString *imageName = [self getRealImageName:_currentImageIndex];
    _label.text = imageName;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImage];
    
    //重置滑动视图的显示位置
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    
    _pageControl.currentPage = _currentImageIndex;
    
    NSString *imageName = [self getRealImageName:_currentImageIndex];
    _label.text = imageName;
    
}

- (void) reloadImage{
    int leftImageIndex, rightImageIndex;
    
    //在三个位置间切换，x值分别为0, SCREEN_WIDTH 和 2*SCREEN_WIDTH
    CGPoint offset = [_scrollView contentOffset];
    NSLog(@"offset x: %f, y:%f", offset.x, offset.y);
    
    if (offset.x > SCREEN_WIDTH) {
        _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
    } else if (offset.x < SCREEN_WIDTH){
        _currentImageIndex = (_currentImageIndex + _imageCount -1 ) % _imageCount;
    }
    
    _middleImageView.image = [UIImage imageNamed:[self getRealImageName:_currentImageIndex]];
    
    leftImageIndex = (_currentImageIndex + _imageCount -1) % _imageCount;
    rightImageIndex = (_currentImageIndex + 1) % _imageCount;
    
    _leftImageView.image = [UIImage imageNamed:[self getRealImageName:leftImageIndex]];
    _righttImageView.image = [UIImage imageNamed:[self getRealImageName:rightImageIndex]];
}

@end
