//
//  TwoTableViewController.h
//  ScrollViewLinkage
//
//  Created by LeeQQ on 2017/6/30.
//  Copyright © 2017年 LeeQQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubViewScrollProtocol.h"

@interface TwoTableViewController : UIViewController
@property (nonatomic,weak)id<SubViewScrollProtocol> delegate;
@end
