//
//  ICView.m
//  ICViewDemo
//
//  Created by LccLcc on 15/11/25.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import "ICView.h"
#import "ICViewCell.h"

@interface ICView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>


@end


@implementation ICView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.time = .7;
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.itemSize = self.frame.size;
        self.flowLayout.minimumLineSpacing = 0;
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.flowLayout = self.flowLayout;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        self.collectionView .backgroundColor = [UIColor clearColor];
        self.collectionView .pagingEnabled = YES;
        self.collectionView .showsHorizontalScrollIndicator = NO;
        self.collectionView .showsVerticalScrollIndicator = NO;
        [self.collectionView  registerClass:[ICViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.collectionView .dataSource = self;
        self.collectionView .delegate = self;
        [self addSubview:self.collectionView ];
        self.collectionView = self.collectionView;
        

        self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width * .2, self.bounds.size.height * .85, self.bounds.size.width * .6, self.bounds.size.height * .1)];
        self.page.userInteractionEnabled = NO;
        [self addSubview:self.page];
        
    }
    
    return self;
    
}


- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images time:(CGFloat)time{
    
    if (self = [self initWithFrame:frame]) {
        self.images = images;
        self.time = time;
        self.page.numberOfPages = images.count;
    }

    return self;
    
}

- (void)setImages:(NSArray *)images{
    
    _images = images;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.images.count * 50 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

}



#pragma mark - collectionViewDataSourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.images.count * 100;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ICViewCell *cell = (ICViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    long itemIndex = indexPath.item% self.images.count;
    cell.imgView.image = self.images[itemIndex];
    NSLog(@"%ld--%@",itemIndex,cell.imgView);
    
    return cell;
    
}



#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self endAutoScroll];
    [self.delegate icView:self didSelectItemAtIndex:indexPath.row];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(beginAutoScroll) userInfo:nil repeats:NO];
    
}



#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

    CGFloat pageWidth = self.collectionView.frame.size.width;
    int itemIndex = (scrollView.contentOffset.x + 0.5 * pageWidth) / pageWidth;

    int indexOnPageControl = itemIndex % self.images.count;
    _page.currentPage = indexOnPageControl;

}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self endAutoScroll];

}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"滑动结束");
    [self beginAutoScroll];

}



#pragma mark - 自动滑动
- (void)beginAutoScroll {
    [self beginTimer];
}


- (void)endAutoScroll {
    [self deleteTimer];
}



#pragma mark - 定时器
- (void)beginTimer {
    
    if (self.images && !_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
    
}


- (void)deleteTimer {
    
    if (_timer ) {
        [_timer invalidate];
        _timer = nil;
    }
    
}


-(void)timerAction:(NSTimer *)timer{
    

    int currentIndex = self.collectionView.contentOffset.x / _flowLayout.itemSize.width;
    int targetIndex = currentIndex + 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}




@end
