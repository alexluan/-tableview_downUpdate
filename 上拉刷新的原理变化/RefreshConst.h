//
//  RefreshConst.h
//  XinTiaoApp
//
//  Created by 安军锋 on 14-8-29.
//  Copyright (c) 2014年 ChangWei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 文字颜色
#define RefreshLabelTextColor RefreshColor(150, 150, 150)

extern const CGFloat RefreshViewHeight;
extern const CGFloat RefreshFastAnimationDuration;
extern const CGFloat RefreshSlowAnimationDuration;

extern NSString *const RefreshFooterPullToRefresh;
extern NSString *const RefreshFooterReleaseToRefresh;
extern NSString *const RefreshFooterRefreshing;

extern NSString *const RefreshHeaderPullToRefresh;
extern NSString *const RefreshHeaderReleaseToRefresh;
extern NSString *const RefreshHeaderRefreshing;
extern NSString *const RefreshHeaderTimeKey;

extern NSString *const RefreshContentOffset;
extern NSString *const RefreshContentSize;
