//
//  ScrollViewNestVC.h
//  JXBrief
//
//  Created by LeeQQ on 17/5/24.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubViewScrollProtocol.h"

@protocol ScrollViewNestVCDelegate <NSObject>
/** 添加下方滑动的子VC */
- (UIViewController *)viewControllerForIndex:(NSInteger)index ;
/** 滑动超过最大边界值 */
- (void)scrollViewDidScrollOverMaxBoundaryValue:(BOOL)over;
@end

/** 
 注意：切记把此类的实例对象添加到相应的控制器（addChildViewController）
 */
@interface ScrollViewNestVC : UIViewController<SubViewScrollProtocol>
/** 初始化
 headerView：顶部视图
 headerViewHeight：顶部视图高度
 */
- (instancetype)initWithViewFrame:(CGRect)viewFrame headerView:(UIView *)headerView headerViewHeight:(CGFloat)headerViewHeight titles:(NSArray *)titles;
///** 子VC title */
//@property (nonatomic,assign)NSArray *titles;

@property (nonatomic,weak) id<ScrollViewNestVCDelegate> delegate;

@end
