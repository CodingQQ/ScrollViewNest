//
//  TwoTableViewController.m
//  ScrollViewLinkage
//
//  Created by LeeQQ on 2017/6/30.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import "TwoTableViewController.h"

@interface TwoTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation TwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"two:%@",NSStringFromClass([self class]));
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"reuseIdentifierOne";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UIImageView *imageVi = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Pikachu.jpeg"]];
        cell.backgroundView = imageVi;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"two-selectIndex:%@",indexPath);
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
