//
//  ScrollViewNestVC.m
//  JXBrief
//
//  Created by LeeQQ on 17/5/24.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import "ScrollViewNestVC.h"
#import "UpTitleDownLineBtn.h"

#define UI_Screen_Width   ([[UIScreen mainScreen] bounds].size.width)
#define UI_Screen_Height  ([[UIScreen mainScreen] bounds].size.height)
#define SegmentPieceHeight    10

#define ColorMian           [UIColor colorWithRed:(14)/255.0 green:(181)/255.0 blue:(197)/255.0 alpha:1.0]

#define tagBase  100
#define tag_subView  99

CGFloat tableW,tableH  ;
CGFloat titleViewY = 0;
static CGFloat titleViewH = 40;

@interface ScrollViewNestVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *mainScrollView;
/** 子VC title */
@property (nonatomic,copy)NSArray *titles;
@property (nonatomic,strong)UIView *titlesView;
@property (nonatomic,strong)UIScrollView *subScrollView;

@property (nonatomic,strong)NSMutableArray *subViews;
@end

@implementation ScrollViewNestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (instancetype)initWithViewFrame:(CGRect)viewFrame headerView:(UIView *)headerView headerViewHeight:(CGFloat)headerViewHeight titles:(NSArray *)titles{
    if (self = [super init]) {

        self.view.frame = viewFrame;
        [self.view addSubview:self.mainScrollView];
        headerView.frame = CGRectMake(0, 0, viewFrame.size.width, headerViewHeight);
        [self.mainScrollView addSubview:headerView];
        //
        titleViewY = CGRectGetMaxY(headerView.frame);
        tableW = viewFrame.size.width;
        tableH = titles.count>0 ? UI_Screen_Height-64 - titleViewH : UI_Screen_Height-64;
        //
        CGFloat contentH = titleViewY +titleViewH +tableH +64;
        self.mainScrollView.contentSize = CGSizeMake(tableW, contentH);
        
        self.titles = titles;
    }
    return self;
}


- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    if (titles.count>0) {
        
        [self.mainScrollView addSubview:self.titlesView];
        CGFloat subScroY = titleViewY+titleViewH ;
        self.subScrollView.frame = CGRectMake(0, subScroY, tableW, tableH);
        //
        self.subViews = [NSMutableArray array];
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.subViews addObject:@"-1"];
        }];
        //
        self.subScrollView.contentSize = CGSizeMake(tableW*titles.count, tableH);
    }else{
        CGFloat subScroY = titleViewY;
        self.subScrollView.frame = CGRectMake(0, subScroY, tableW, tableH+titleViewH);
        //
        self.subViews = [NSMutableArray arrayWithObject:@"-1"];
        //
        self.subScrollView.contentSize = CGSizeMake(tableW, tableH);
    }
    
//    [self setViewForIndex:0];
}
- (void)setDelegate:(id<ScrollViewNestVCDelegate>)delegate{
    _delegate = delegate;
    [self setViewForIndex:0];
}
- (void)setViewForIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(viewControllerForIndex:)]) {
        
        UIViewController *VC = [self.delegate viewControllerForIndex:index];
        if (VC == nil) {
            return;
        }
        CGRect tableFrame =  CGRectMake(tableW*index, 0, tableW, tableH);
        VC.view.frame = tableFrame;
        VC.view.tag = tag_subView;
        [self.subScrollView addSubview:VC.view];
        [self addChildViewController:VC];
        [self.subViews replaceObjectAtIndex:index withObject:VC];
    }
    
}

#pragma mark 响应方法
- (void)titlesViewBtnClick:(UpTitleDownLineBtn *)button{
    [self buttonSelectState:button];
    NSInteger index = button.tag - tagBase;
    if ([[self.subViews objectAtIndex:index] isKindOfClass:[NSString class]]) {
        [self setViewForIndex:index];
    }
    [self.subScrollView setContentOffset:CGPointMake(tableW*index, 0)];
    
}
- (void)buttonSelectState:(UpTitleDownLineBtn *)button{
    if (button.selected) {
        return;
    }
    for (id sub in self.titlesView.subviews) {
        if ([sub isKindOfClass:[UpTitleDownLineBtn class]]) {
            ((UpTitleDownLineBtn *)sub).selected = NO;
        }
    }
    button.selected = YES;
}

#pragma mark subView
- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _mainScrollView.autoresizesSubviews = NO;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}
- (UIView *)titlesView{
    if (_titlesView == nil) {
        _titlesView = [[UIView alloc]initWithFrame:CGRectMake(0, titleViewY, tableW, titleViewH)];
        _titlesView.backgroundColor = [UIColor whiteColor];
        [self addTitleViewSubs];
    }
    return _titlesView;
}

- (UIScrollView *)subScrollView{
    if (_subScrollView == nil) {
        _subScrollView = [[UIScrollView alloc]init ];
        _subScrollView.backgroundColor = [UIColor whiteColor];
        _subScrollView.autoresizesSubviews = NO;
        _subScrollView.bounces = NO;
        _subScrollView.pagingEnabled = YES;
        _subScrollView.delegate = self;
        [self.mainScrollView addSubview:_subScrollView];
    }
    return _subScrollView;
}

- (void)addTitleViewSubs{
    
    CGFloat buttonW = UI_Screen_Width / (self.titles.count);
    for (NSInteger i =0; i<self.titles.count; i++) {
        UpTitleDownLineBtn *button = [UpTitleDownLineBtn buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonW*i, 0, buttonW, CGRectGetHeight(self.titlesView.frame)-SegmentPieceHeight);
        [button setImage:[[self class] createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setImage:[[self class] createImageWithColor:ColorMian] forState:UIControlStateSelected];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:ColorMian forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.selected = i==0 ? YES : NO;
        button.tag = tagBase + i;
        [button addTarget:self action:@selector(titlesViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:button];
    }
}

+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark 滑动协议方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self handleScrollViewDidScroll:scrollView];
}
/** 滑动处理 */
- (void)handleScrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"------开始滑动:%@",scrollView);
    NSLog(@"--mainScrollView.y  : %@ -- %.2f",[scrollView class],self.mainScrollView.contentOffset.y);
    //判断是否是子视图滚动
    BOOL isSubTable = [self isSubTable:scrollView];
    if (isSubTable) {
        BOOL isScroll = self.mainScrollView.contentOffset.y < titleViewY;
        CGFloat offsetY = scrollView.contentOffset.y + self.mainScrollView.contentOffset.y;
        if (isScroll) {
            [self.mainScrollView setContentOffset:CGPointMake(0, offsetY)];
            [scrollView setContentOffset:CGPointZero];
        }else {
            if (scrollView.contentOffset.y <= 0) {
                [self.mainScrollView setContentOffset:CGPointMake(0, offsetY)];
            }
            
        }
        
    } else if (scrollView == self.mainScrollView) {
        if (self.mainScrollView.contentOffset.y >= titleViewY) {
            [self.mainScrollView setContentOffset:CGPointMake(0, titleViewY)];
        }
    } else if (scrollView == self.subScrollView) {
        
        NSInteger index = self.subScrollView.contentOffset.x / tableW;
        UpTitleDownLineBtn *btn = (UpTitleDownLineBtn *)[self.titlesView viewWithTag:tagBase+index];
        [self buttonSelectState:btn];
        if ([[self.subViews objectAtIndex:index] isKindOfClass:[NSString class]]) {
            [self setViewForIndex:index];
        }
    }
    BOOL greater = self.mainScrollView.contentOffset.y >= titleViewY ? YES : NO ;
//    NSLog(@"greater:%d",greater);
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScrollOverMaxBoundaryValue:)]) {
        [self.delegate scrollViewDidScrollOverMaxBoundaryValue:greater];
    }
    
}
// 停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //    NSLog(@"------停止拖拽:%@",scrollView);
    [self handleScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

//滑动停止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //    NSLog(@"------滑动停止:%@",scrollView);
    [self handleScrollViewDidEndDragging:scrollView willDecelerate:YES];
}
/** 处理因子视图向下拖拽而导致父视图无法回到原位置 */
- (void)handleScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    BOOL isSubTable = [self isSubTable:scrollView];
    if (isSubTable) {
        CGFloat offsetY = self.mainScrollView.contentOffset.y;
        if (offsetY < 0) {
            [self.mainScrollView setContentOffset:CGPointZero
                                         animated:YES];
        }
    }
}
- (BOOL)isSubTable:(UIScrollView *)scrollView{
    return [scrollView superview].tag == tag_subView ;
}
#pragma subViews滑动协议方法
/** 开始滑动 */
- (void)subViewScrollViewDidScroll:(UIScrollView *)scrollView{
    [self handleScrollViewDidScroll:scrollView];
}
/** 停止拖拽 */
- (void)subViewScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self handleScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}
/** 滑动停止 */
-(void)subViewScrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self handleScrollViewDidEndDragging:scrollView willDecelerate:YES];
}

@end
