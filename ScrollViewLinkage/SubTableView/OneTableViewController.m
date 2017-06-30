//
//  OneTableViewController.m
//  ScrollViewLinkage
//
//  Created by LeeQQ on 2017/6/30.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import "OneTableViewController.h"

@interface OneTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@end

@implementation OneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"one:%@",NSStringFromClass([self class]));
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews{
    self.tableView.frame = self.view.bounds;
//    [self.tableView reloadData];
}

#pragma mark 滑动协议
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([self.delegate respondsToSelector:@selector(subViewScrollViewDidScroll:)]) {
        [self.delegate subViewScrollViewDidScroll:scrollView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ([self.delegate respondsToSelector:@selector(subViewScrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate subViewScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(subViewScrollViewDidEndDecelerating:)]) {
        [self.delegate subViewScrollViewDidEndDecelerating:scrollView];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"reuseIdentifierTWO";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UIImageView *imageVi = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"girl.jpeg"]];
        cell.backgroundView = imageVi;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"one-selectIndex:%@",indexPath);
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
