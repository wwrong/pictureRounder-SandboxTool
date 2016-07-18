//
//  ViewController.m
//  轮播器和沙盒工具
//
//  Created by Guan Nan Wang on 16/6/28.
//  Copyright © 2016年 Guan Nan Wang. All rights reserved.
//

#import "ViewController.h"
#import "SandboxManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) NSArray *images;
@property (weak, nonatomic) IBOutlet UIScrollView *rounder;
@property(assign,nonatomic) unsigned long currentImgNum;
@property(strong,nonatomic) NSTimer *timer;
@property(assign,nonatomic) CGFloat imageWidth;
@property(assign,nonatomic) CGFloat imageHeight;
#define imageCount 6

@end

@implementation ViewController


-(void)setImages{
    if (_images == nil) {
        for (int i = 1; i <= imageCount; i ++) {
            NSString * imageName = [NSString stringWithFormat:@"%02d.jpg",i];
            UIImage *image = [UIImage imageNamed:imageName];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((i-1) * self.imageWidth, 0, self.imageWidth, self.imageHeight)];
            NSString *frameStr = NSStringFromCGRect(imgView.frame);
            NSLog(@"imgFrame is %@",frameStr);
            imgView.image = image;
            [self.rounder addSubview:imgView];
            
        }

    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewframe is %@",NSStringFromCGRect(self.view.frame));
    NSLog(@"backViewFrame is %@",NSStringFromCGRect(self.backView.frame));
    NSLog(@"rounderFrame is %@",NSStringFromCGRect(self.rounder.frame));
    CGFloat theW = self.view.frame.size.width;
    CGFloat theH = theW *5.0f /8.0f;
    NSLog(@"thew is %f and theh is %f",theW,theH);
    self.backView.frame = CGRectMake(0, 20, theW, theH);
    self.rounder.frame = CGRectMake(0, 0, theW, theH);
    self.currentImgNum = 0;
    self.rounder.delegate = self;
    self.rounder.scrollEnabled=YES;
    self.rounder.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.rounder.contentSize = CGSizeMake(self.rounder.bounds.size.width * imageCount, 0);
    self.rounder.contentOffset = CGPointMake(0, 0);
    self.rounder.pagingEnabled = YES;
    self.rounder.contentInset = UIEdgeInsetsZero;
    self.imageWidth = self.rounder.bounds.size.width;
    self.imageHeight = self.rounder.bounds.size.height;
    [self setImages];
    self.pageControl.numberOfPages = imageCount;
    self.pageControl.currentPage = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(next) userInfo:nil repeats:YES];
    NSLog(@"%@",NSStringFromCGRect(self.rounder.frame));
    [SandboxManager checkSandboxfiles];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    NSLog(@"timer invalidated.");
    self.timer = nil;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (self.rounder.contentOffset.x / 414);
    self.currentImgNum = self.pageControl.currentPage;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(next) userInfo:nil repeats:YES];
    [SandboxManager deleteFilesInCaches];
    [SandboxManager checkSandboxfiles];
}


-(void)next{
    
    if (self.currentImgNum == imageCount-1) {
        self.currentImgNum = 0;
        CGFloat offsetX = self.currentImgNum * self.view.bounds.size.width;
        [self.rounder setContentOffset:CGPointMake(offsetX, 0) animated:NO];
        self.pageControl.currentPage = 0;
        return;
    }

    self.currentImgNum ++;
    CGFloat offsetX = self.currentImgNum * self.view.bounds.size.width;
    [self.rounder setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    self.pageControl.currentPage ++;
    
    }


@end
