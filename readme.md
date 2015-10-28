### UIScrollView常用属性和方法

#### 属性

```
@property(nonatomic)         CGPoint                      contentOffset; 
	内容偏移量，当前显示的内容的顶点相对此控件顶点的x、y距离，默认为CGPointZero
	
@property(nonatomic)         CGSize                       contentSize; 
	控件内容大小，不一定在显示区域，如果这个属性不设置，此控件无法滚动，默认为CGSizeZero
	
@property(nonatomic)         UIEdgeInsets                 contentInset; 
	控件四周边距，类似于css中的margin,注意边距不作为其内容的一部分,默认为UIEdgeInsetsZero
	
@property(nonatomic,assign) id<UIScrollViewDelegate>      delegate; 
	控件代理，一般用于事件监听，在iOS中多数控件都是通过代理进行事件监听的
	
@property(nonatomic)         BOOL                         bounces; 
	是否启用弹簧效果，启用弹簧效果后拖动到边缘可以看到内容后面的背景，默认为YES
	
@property(nonatomic,getter=isPagingEnabled) BOOL          pagingEnabled; 
	是否分页，如果分页的话每次左右拖动则移动宽度是屏幕宽度整数倍,默认为NO
	
@property(nonatomic,getter=isScrollEnabled) BOOL          scrollEnabled;   
	是否启用滚动，默认为YES
	
@property(nonatomic) BOOL  showsHorizontalScrollIndicator; 
	是否显示横向滚动条，默认为YES

@property(nonatomic) BOOL  showsVerticalScrollIndicator; 
	是否显示纵向滚动条，默认为YES
	
@property(nonatomic) CGFloat minimumZoomScale; 
	最小缩放倍数，默认为1.0
	
@property(nonatomic) CGFloat maximumZoomScale; 
	最大缩放倍数（注意只有maximumZoomScale大于minimumZoomScale才有可能缩放），默认为1.0
	
@property(nonatomic,readonly,getter=isTracking)     BOOL tracking; 
	（状态）是否正在被追踪，手指按下去并且还没有拖动时是YES，其他情况均为NO
	
@property(nonatomic,readonly,getter=isDragging)     BOOL dragging; 
	是否正在被拖拽
	
@property(nonatomic,readonly,getter=isDecelerating) BOOL decelerating; 
	是否正在减速
	
@property(nonatomic,readonly,getter=isZooming)       BOOL zooming; 
	是否正在缩放
```
#### 方法
```
- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated; 
	设置滚动位置，第二个参数表示是否启用动画效果
	
- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated; 
	滚动并显示指定区域的内容，第二个参数表示是否启用动画效果
```

####代理方法
```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; 
	滚动事件方法，滚动过程中会一直循环执行（滚动中…）
	
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView; 
	开始拖拽事件方法
	
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate; 	
	拖拽操作完成事件方法
	
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView; 
	即将停止滚动事件方法（拖拽松开后开始减速时执行）
	
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; 
	滚动停止事件方法（滚动过程中减速停止后执行）
	
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view NS_AVAILABLE_IOS(3_2); 	
	开始缩放事件方法
	
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2); 
	缩放操作完成事件方法
	
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView; 
	返回缩放视图，注意只有实现这个代理方法才能进行缩放，此方法返回需要缩放的视图
``` 

### 此项目的演示效果

![Unlimited gallery](http://7xj4cp.com1.z0.glb.clouddn.com/UnlimitedGallery.gif)