//
//  UIScrollView+footerFresh.h
//  上拉刷新的原理变化
//
//  Created by 栾有数 on 15/10/25.
//  Copyright © 2015年 栾有数. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshFooterView.h"
@interface UIScrollView (footerFresh)


-(void)setFooter:(id)target action:(SEL)action;

@property (weak, nonatomic) RefreshFooterView *footer;

/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter;

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing;

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing;

/**
 *  下拉刷新头部控件的可见性
 */
@end
