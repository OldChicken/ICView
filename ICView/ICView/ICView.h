//
//  ICView.h
//  ICViewDemo
//
//  Created by LccLcc on 15/11/25.
//  Copyright © 2015年 LccLcc. All rights reserved.
//



#import <UIKit/UIKit.h>

@class ICView;
@protocol ICViewDelegate <NSObject>

- (void)icView:(ICView *)pView didSelectItemAtIndex:(NSInteger)index;

@end


@interface ICView : UIView

// 滑动视图
@property (nonatomic,strong) UICollectionView *collectionView;
//滑动视图布局
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
// 分页器
@property (nonatomic,strong) UIPageControl *page;
// 定时器
@property (nonatomic,strong) NSTimer *timer;
// 传入图片数组
@property (nonatomic,strong) NSArray *images;
// 滑动时间 默认 .7
@property (nonatomic,assign) CGFloat time;
// 是否显示pageControl 默认显示
@property (nonatomic,assign) BOOL hidePageControl;
// 代理
@property (nonatomic,weak) id<ICViewDelegate> delegate;

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray*)images time:(CGFloat)time;
// 开始自动滑动
- (void)beginAutoScroll;
// 停止自动滑动
- (void)endAutoScroll;

@end
