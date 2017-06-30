//
//  SubViewScrollProtocol.h
//  JXBrief
//
//  Created by LeeQQ on 17/5/25.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SubViewScrollProtocol <NSObject>

/** 开始滑动 */
- (void)subViewScrollViewDidScroll:(UIScrollView *)scrollView;
/** 停止拖拽 */
- (void)subViewScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
/** 滑动停止 */
-(void)subViewScrollViewDidEndDecelerating:(UIScrollView *)scrollView;



@end
