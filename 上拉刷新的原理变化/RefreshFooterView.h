//
//  RefreshFooterView.h
//  上拉刷新的原理变化
//
//  Created by 栾有数 on 15/10/25.
//  Copyright © 2015年 栾有数. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RefreshBaseView.h"

@interface RefreshFooterView : RefreshBaseView<UIScrollViewDelegate>
+ (instancetype)footer;
/**
 *  开始进入刷新状态的监听器
 */
@property (weak, nonatomic) id beginRefreshingTaget;
/**
 *  开始进入刷新状态的监听方法
 */
@property (assign, nonatomic) SEL beginRefreshingAction;


@end
