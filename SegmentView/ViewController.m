//
//  ViewController.m
//  SegmentView
//
//  Created by linyansen on 2025/7/29.
//

#import "ViewController.h"
#import "SegmentView.h"

@interface ViewController ()<SegmentViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) SegmentView *segmentView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"推荐",@"精选"];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width*self.dataArray.count, self.scrollView.height);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0,*)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    for (int i = 0; i < self.dataArray.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.width*i, 0, self.scrollView.width, self.scrollView.height)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [UILabel new];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(view);
        }];
        
        NSString *text = [NSString stringWithFormat:@"Page %d",i+1];
        titleLabel.text = text;
        titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.scrollView addSubview:view];
    }
    
    self.segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(self.view.width/2-100, 63, 200, 20)];
    self.segmentView.delegate = self;
    self.segmentView.normalTitleColor = [UIColor grayColor];
    self.segmentView.selectedTitleColor = [UIColor blackColor];
    self.segmentView.textFont = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:self.segmentView];
    [self.segmentView reloadData];
}


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

@end
