//
//  UIScrollView+footerFresh.m
//  上拉刷新的原理变化
//
//  Created by 栾有数 on 15/10/25.
//  Copyright © 2015年 栾有数. All rights reserved.
//

#import "UIScrollView+footerFresh.h"
#import <objc/runtime.h>

static char RefreshFooterViewKey;


@implementation UIScrollView (footerFresh)
//http://blog.csdn.net/haishu_zheng/article/details/12873151
@dynamic footer;//@dynamic告诉编译器getter、setter方法由自己定义@property有两个对应的词，一个是@synthesize，一个是@dynamic。如果@synthesize和@dynamic都没写，那么默认的就是@syntheszie var = _var;
        //@synthesize的语义是如果你没有手动实现setter方法和getter方法，那么编译器会自动为你加上这两个方法。
        //
        //
        //
        //@dynamic告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成。（当然对于readonly的属性只需提供getter即可）。假如一个属性被声明为@dynamic var，然后你没有提供@setter方法和@getter方法，编译的时候没问题，但是当程序运行到instance.var =someVar，由于缺setter方法会导致程序崩溃；或者当运行到 someVar = var时，由于缺getter方法同样会导致崩溃。编译时没问题，运行时才执行相应的方法，这就是所谓的动态绑定。
        //-(void)setFooter:(RefreshFooterView *)footer{
        //    
        //}

-(void)setFooter:(id)target action:(SEL)action{
    if (!self.footer) {
        RefreshFooterView *footer = [RefreshFooterView footer];
        footer.backgroundColor = [UIColor redColor];
        [self addSubview:footer];
        self.footer = footer;
    }
    // 2.设置目标和回调方法
    self.footer.beginRefreshingTaget = target;
    self.footer.beginRefreshingAction = action;
}

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的footer
    if (!self.footer) {
        RefreshFooterView *footer = [RefreshFooterView footer];
        [self addSubview:footer];
        self.footer = footer;
    }
    
    // 2.设置目标和回调方法
    self.footer.beginRefreshingTaget = target;
    self.footer.beginRefreshingAction = action;
}

/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter
{
    [self.footer removeFromSuperview];
    self.footer = nil;
}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing
{
    [self.footer beginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing
{
    [self.footer endRefreshing];
}

//自己决定footer的getter、setter方法
- (void)setFooter:(RefreshFooterView *)footer {
    [self willChangeValueForKey:@"RefreshFooterViewKey"];
    objc_setAssociatedObject(self, &RefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"RefreshFooterViewKey"];
}

- (RefreshFooterView *)footer {
    return objc_getAssociatedObject(self, &RefreshFooterViewKey);
    
}

@end
