//
//  DetailViewController.m
//  ScrollViewLinkage
//
//  Created by LeeQQ on 2017/6/30.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import "DetailViewController.h"
#import "ScrollViewNestVC.h"
#import "OneTableViewController.h"
#import "TwoTableViewController.h"


#define UI_Screen_Width   ([[UIScreen mainScreen] bounds].size.width)
#define UI_Screen_Height  ([[UIScreen mainScreen] bounds].size.height)

static CGFloat titleViewY = 160;

@interface DetailViewController ()<ScrollViewNestVCDelegate>
@property (nonatomic,strong)ScrollViewNestVC *scrollViewNest;
@property (nonatomic,strong)OneTableViewController *oneTable;
@property (nonatomic,strong)TwoTableViewController *twoTable;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ScrollView嵌套";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addSubViews];
}
- (void)addSubViews{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UI_Screen_Width, titleViewY)];
    imageView.image = [UIImage imageNamed:@"20151024110129907.jpg"];
    self.scrollViewNest = [[ScrollViewNestVC alloc] initWithViewFrame:self.view.bounds headerView:imageView headerViewHeight:titleViewY  titles:@[@"第一个tab",@"第二个tab"]];
    self.scrollViewNest.delegate = self;
    [self.view addSubview:self.scrollViewNest.view];
    [self addChildViewController:self.scrollViewNest];
    
}

-(UIViewController *)viewControllerForIndex:(NSInteger)index{
    if (index == 0) {
        self.oneTable.delegate = self.scrollViewNest;
        return self.oneTable;
    }else if (index == 1){
        self.twoTable.delegate = self.scrollViewNest;
        return self.twoTable;
    }
    return nil;
}
- (void)scrollViewDidScrollOverMaxBoundaryValue:(BOOL)over{
    NSLog(@"over:%d",over);
}

- (OneTableViewController *)oneTable{
    if (_oneTable == nil) {
        _oneTable = [[OneTableViewController alloc]init];
        _oneTable.view.frame = CGRectMake(0, 0, UI_Screen_Width, (UI_Screen_Height-64 - 40));
    }
    return _oneTable;
}
- (TwoTableViewController *)twoTable{
    if (_twoTable == nil) {
        _twoTable = [[TwoTableViewController alloc]init];
        _twoTable.view.frame = CGRectMake(UI_Screen_Width, 0, UI_Screen_Width, (UI_Screen_Height-64 - 40));
    }
    return _twoTable;
}
@end
