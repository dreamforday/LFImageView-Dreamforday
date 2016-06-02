//
//  LFImageExampleView.m
//  LFImageViewDemo
//
//  Created by WangZhiWei on 16/5/26.
//  Copyright © 2016年 youku. All rights reserved.
//

#import "LFImageExampleView.h"

@implementation LFImageExampleView


#pragma  mark --继承父类的方法

/**
 返回YES,则忽略占位图
 返回NO,则表示不忽略占位图，加载占位图
 */
- (BOOL)ignoreHolder
{
    return NO;
}

/**
 返回YES,则表示在移动网络下，仍然加载图片资源
 返回NO,则表示在移动网络情况下，不加载图片资源
 */
- (BOOL)downloadWithMobileNetWork
{
    return YES;
}

@end
