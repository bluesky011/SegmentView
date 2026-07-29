# SegmentView
仿微博客户端
# 要求
* iOS 14.0+
* Objective-C
# 安装
下载代码，把SegmentView文件夹拖入项目中，导入头文件#import "SegmentView.h"就可以使用了。
# 使用
SegmentView的使用

1.初始化SegmentView并配置属性
```
    self.segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(self.view.width/2-100, 63, 200, 20)];
    self.segmentView.delegate = self;
    self.segmentView.normalTitleColor = [UIColor grayColor];
    self.segmentView.selectedTitleColor = [UIColor blackColor];
    self.segmentView.textFont = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:self.segmentView];
    [self.segmentView reloadData];
```
2.实现SegmentViewDelegate代理
```
#pragma mark - SegmentViewDelegate
-(NSInteger)numberOfItemsInSegmentView:(SegmentView *)segmentView {
    return self.dataArray.count;
}

-(NSString *)segmentView:(SegmentView *)segmentView titleAtIndex:(NSInteger)index {
    NSString *title = self.dataArray[index];
    return title;
}

- (void)segmentView:(SegmentView *)segmentView didSelectItemAtIndex:(NSInteger)index {
    [self.scrollView scrollRectToVisible:CGRectMake(index*self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) animated:NO];
}

```
3.页面滑动切换时下划线的宽度和颜色变化
```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width;
    CGRect frame;
    CGFloat btnWidth = 200/self.dataArray.count;
    if (scrollView.contentOffset.x<=scrollView.width/2) {
        width = scrollView.contentOffset.x/(scrollView.width/2)*100;
        frame = CGRectMake(btnWidth/2-20, 15, 40+width, 5);
        [self.segmentView setLineViewColor:[UIColor grayColor]];
    } else {
        width = 100 - (scrollView.contentOffset.x-scrollView.width/2)/(scrollView.width/2)*100;
        frame = CGRectMake(btnWidth/2-20+(scrollView.contentOffset.x-scrollView.width/2)/(scrollView.width/2)*100, 15, 40+width, 5);
        [self.segmentView setLineViewColor:[UIColor orangeColor]];
    }
    
    NSLog(@"%f",width);
    [self.segmentView setLineViewFrame:frame];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    NSLog(@"%ld",(long)index);
    [self.segmentView reloadDataAtIndex:index];
}
```
# License
SegmentView遵循MIT许可协议发布。详情请参见LICENSE文件。
