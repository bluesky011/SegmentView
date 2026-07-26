//
//  SegmentView.m
//  SegmentView
//
//  Created by linyansen on 2025/7/29.
//

#import "SegmentView.h"

@interface SegmentView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIButton *selectBtn;
@property (assign, nonatomic) NSInteger itemNum;
@property (strong, nonatomic) UIView *lineView;
@end

@implementation SegmentView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
    }
    
    return self;
}


- (void)reloadData
{
    self.itemNum = [self.delegate numberOfItemsInSegmentView:self];
    

    self.btnWidth = self.width/self.itemNum;

    
    [self removeAllSubviews];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(self.btnWidth/2-20, 15, 40, 5)];
    self.lineView.backgroundColor = [UIColor grayColor];
    self.lineView.layer.cornerRadius = 2.5;
    [self addSubview:self.lineView];
    
    
    
    for (int i = 0; i < self.itemNum; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0 + i*self.btnWidth, 0, self.btnWidth, self.height)];
        view.tag = i+1000;
        [self addSubview:view];
        
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, self.btnWidth, self.height);
        [button setTitle:[self.delegate segmentView:self titleAtIndex:i] forState:UIControlStateNormal];
        
        UIColor *normalTitleColor;
        if (self.normalTitleColor) {
            normalTitleColor = self.normalTitleColor;
        } else {
            normalTitleColor = [UIColor grayColor];
        }
        [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
        button.tag = i+10;
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        UIFont *font;
        if (self.textFont) {
            font = self.textFont;
        } else {
            font = [UIFont systemFontOfSize:18.0f];
        }
        button.titleLabel.font = font;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.btnWidth);
            make.height.mas_equalTo(self.height);
            make.top.mas_equalTo(view);
            make.left.mas_equalTo(view);
        }];
        
        
        

        if (i==self.itemNum-1) {
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(view.mas_right);
            }];
        }

        if (i==0) {
            [self changeBtnState:button];
        }
        

    }
    
    
}


- (void)reloadDataAtIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[self viewWithTag:10+index];
    [self changeBtnState:btn];
}


- (void)buttonClick:(UIButton *)button
{
    [self changeBtnState:button];
    
    NSInteger index = button.tag - 10;
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectItemAtIndex:)]) {
        [self.delegate segmentView:self didSelectItemAtIndex:index];
    }
}


- (void)changeBtnState:(UIButton *)btn
{

    UIColor *normalTitleColor;
    if (self.normalTitleColor) {
        normalTitleColor = self.normalTitleColor;
    } else {
        normalTitleColor = [UIColor grayColor];
    }
    [self.selectBtn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    
    
    UIColor *selectedTitleColor;
    if (self.selectedTitleColor) {
        selectedTitleColor = self.selectedTitleColor;
    } else {
        selectedTitleColor = [UIColor whiteColor];
    }
    [btn setTitleColor:selectedTitleColor forState:UIControlStateNormal];
    self.selectBtn = btn;
    self.selectedIndex = btn.tag - 10;
    
    NSLog(@"%f",self.selectBtn.origin.x);
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.center = CGPointMake(self.btnWidth/2+(btn.tag-10)*self.btnWidth, self.lineView.centerY);
    }];
}


- (void)setLineViewFrame:(CGRect)frame {
    NSLog(@"%f",frame.size.width);
    self.lineView.frame = frame;
}

- (void)setLineViewColor:(UIColor *)color {
    self.lineView.backgroundColor = color;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
