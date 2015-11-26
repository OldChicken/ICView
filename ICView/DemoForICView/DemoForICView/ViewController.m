//
//  ViewController.m
//  DemoForICView
//
//  Created by LccLcc on 15/11/25.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import "ViewController.h"
#import "ICView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                        [UIImage imageNamed:@"h2.jpg"],
                        [UIImage imageNamed:@"h3.jpg"],
                        [UIImage imageNamed:@"h4.jpg"]
                        ];

    ICView *icView = [[ICView alloc]initWithFrame:CGRectMake(10, 200, 300, 200)images:images time:2];
//    ICView *icv = [[ICView alloc]init];
//    icv.time = 2;
//    icv.images = images;
    [icView beginAutoScroll];
    [self.view addSubview:icView];
}


@end
