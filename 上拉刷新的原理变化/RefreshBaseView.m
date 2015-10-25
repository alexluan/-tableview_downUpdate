//
//  RefreshBaseView.m
//  上拉刷新的原理变化
//
//  Created by 栾有数 on 15/10/25.
//  Copyright © 2015年 栾有数. All rights reserved.
//

#import "RefreshBaseView.h"

@implementation RefreshBaseView
@synthesize statusLabel = _statusLabel;

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    frame.size.height = RefreshViewHeight;
    if (self = [super initWithFrame:frame]) {
        // 1.自己的属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
        // 2.设置默认状态
        self.state = RefreshStateNormal;
#ifdef NeedAudio
        // 7.加载音频
        _pullId = [self loadId:@"pull.wav"];
        _normalId = [self loadId:@"normal.wav"];
        _refreshingId = [self loadId:@"refreshing.wav"];
        _endRefreshId = [self loadId:@"end_refreshing.mp3"];
#endif
    }
    return self;
}
#pragma mark - 显示到屏幕上
- (void)drawRect:(CGRect)rect
{
    if (self.state == RefreshStateWillRefreshing) {
        self.state = RefreshStateRefreshing;
    }
}

- (void)setState:(RefreshState)state
{
    // 0.存储当前的contentInset
    if (self.state != RefreshStateRefreshing) {
        _scrollViewOriginalInset = self.scrollView.contentInset;
    }
    
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.根据状态执行不同的操作
    switch (state) {
        case RefreshStateNormal: // 普通状态
        {
            // 显示箭头
//            self.arrowImage.hidden = NO;
            
            // 停止转圈圈
//            [self.activityView stopAnimating];
            break;
        }
            
        case RefreshStatePulling:
            self.statusLabel.text=@"asdfasdfasd";
            break;
            
        case RefreshStateRefreshing:
        {
            // 开始转圈圈
//            [self.activityView startAnimating];
            // 隐藏箭头
//            self.arrowImage.hidden = YES;
            
            // 回调
            if ([self.beginRefreshingTaget respondsToSelector:self.beginRefreshingAction]) {
               objc_msgSend(self.beginRefreshingTaget, self.beginRefreshingAction, self);
            }
//            if (self.beginRefreshingCallback) {
//                self.beginRefreshingCallback();
//            }
            break;
        }
        default:
            break;
    }
    
    // 3.存储状态
    _state = state;
    
    // 4.设置文字
//    [self settingLabelText];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:RefreshContentOffset context:nil];
    
    if (newSuperview) { // 新的父控件
        [newSuperview addObserver:self forKeyPath:RefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        
        // 设置宽度
        self.width = newSuperview.width;
        // 设置位置
        self.x = 0;
        
        // 记录UIScrollView
        _scrollView = (UIScrollView *)newSuperview;
        // 记录UIScrollView最开始的contentInset
        _scrollViewOriginalInset = _scrollView.contentInset;
    }
}

#pragma mark 开始刷新
- (void)beginRefreshing
{
    if (self.window) {
        self.state = RefreshStateRefreshing;
    } else {
//         不能调用set方法
        _state = RefreshStateWillRefreshing;
        [super setNeedsDisplay];
    }
}

#pragma mark 结束刷新
- (void)endRefreshing
{
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.state = RefreshStateNormal;
    });
}

#pragma mark - 控件初始化
/**
 *  状态标签
 */
- (UILabel *)statusLabel
{
    if (!_statusLabel)
    {
        UILabel *statusLabel = [[UILabel alloc] init];
        statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        statusLabel.font = [UIFont boldSystemFontOfSize:13];
        if(self.textColor == nil)
        {
            self.textColor = RefreshLabelTextColor;
        }
        statusLabel.textColor = self.textColor;
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel = statusLabel];
    }
    return _statusLabel;
}


@end
