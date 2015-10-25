//
//  RefreshBaseView.h
//  上拉刷新的原理变化
//
//  Created by 栾有数 on 15/10/25.
//  Copyright © 2015年 栾有数. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+Extension.h"
#import "UIView+Extension.h"
#import "RefreshConst.h"

#pragma mark - 控件的刷新状态
typedef enum
{
    RefreshStatePulling = 1, // 松开就可以进行刷新的状态
    RefreshStateNormal = 2, // 普通状态
    RefreshStateRefreshing = 3, // 正在刷新中的状态
    RefreshStateRefreshingNoSound=5,//正在刷新中的状态没有声音
    RefreshStateWillRefreshing = 4
} RefreshState;

@interface RefreshBaseView : UIView


#pragma mark - 回调
/**
 *  开始进入刷新状态的监听器
 */
@property (weak, nonatomic) id beginRefreshingTaget;
/**
 *  开始进入刷新状态的监听方法
 */
@property (assign, nonatomic) SEL beginRefreshingAction;

#pragma mark - 父控件
@property (nonatomic, weak, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) UIEdgeInsets scrollViewOriginalInset;

#pragma mark - 内部的控件
@property (nonatomic, weak, readonly) UILabel *statusLabel;
@property (nonatomic,strong)UIColor *textColor;

#pragma mark - 交给子类去实现 和 调用
@property (assign, nonatomic) RefreshState state;

-(void)beginRefreshing;

-(void)endRefreshing;

@end
