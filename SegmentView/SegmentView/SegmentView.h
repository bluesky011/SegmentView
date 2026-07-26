//
//  SegmentView.h
//  SegmentView
//
//  Created by linyansen on 2025/7/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SegmentViewDelegate;
@interface SegmentView : UIView

@property (assign, nonatomic) id<SegmentViewDelegate> delegate;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) UIFont *textFont;
@property (strong, nonatomic) UIColor *normalTitleColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;
@property (assign, nonatomic) CGFloat btnWidth;

- (id)initWithFrame:(CGRect)frame;
- (void)reloadDataAtIndex:(NSInteger)index;
- (void)reloadData;
- (void)setLineViewFrame:(CGRect)frame;
- (void)setLineViewColor:(UIColor *)color;
@end

@protocol SegmentViewDelegate<NSObject>
@required

- (NSInteger)numberOfItemsInSegmentView:(SegmentView *)segmentView;
- (NSString *)segmentView:(SegmentView *)segmentView titleAtIndex:(NSInteger)index;

@optional
- (void)segmentView:(SegmentView *)segmentView didSelectItemAtIndex:(NSInteger)index;
- (CGFloat)segmentView:(SegmentView *)segmentView widthForItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
