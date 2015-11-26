//
//  ICViewCell.m
//  DemoForICView
//
//  Created by LccLcc on 15/11/25.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import "ICViewCell.h"

@implementation ICViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:self.imgView];
    }
    
    return self;
    
}

@end
