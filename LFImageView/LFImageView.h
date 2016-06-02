//
//  LFImageView.h
//  LFImageViewDemo
//
//  Created by WangZhiWei on 16/5/24.
//  Copyright © 2016年 youku. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^LFImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

typedef void (^LFImageDownloaderCompledBlock)(UIImage *image, NSError *error,BOOL finished);


@interface LFImageView : UIImageView

/*!
 	@property
 	@abstract	progressBlock	下载进度回调
 */
@property(nonatomic, copy)LFImageDownloaderProgressBlock progressBlock;


/*!
 	@property
 	@abstract	compledBlock	下载完成回调
 */
@property (nonatomic, copy)LFImageDownloaderCompledBlock compledBlock;

/*!
 	@property
 	@abstract	ignoreHolder	是否忽略holderImage
 */
@property (nonatomic, readonly, assign)BOOL ignoreHolder;


/*!
 	@property
 	@abstract	downloadWithWWAN	是否在移动网络下仍然下载图片
 */
@property (nonatomic, readonly, assign)BOOL downloadWithMobileNetWork;

/*!
 @method
 @abstract
 @discussion
 @param 	url 	图片资源url
 @result
 */
- (void)lf_setImageWithURL:(NSURL *)url;


/*!
 @method
 @abstract
 @discussion
 @param 	url 	图片资源url
 @param 	placeholder 	占位符图片
 @result
 */
- (void)lf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;


/*!
 @method
 @abstract
 @discussion
 @param 	url 	图片资源url
 @param 	placeholder 	占位符图片
 @param 	errorholder 	默认异常图片
 @result
 */
- (void)lf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder errorholderImage:(UIImage *)errorholder;


@end

@interface LFImageView (LFSubclassAdditions)

/**
 返回YES,则忽略占位图
 返回NO,则表示不忽略占位图，加载占位图
 */
- (BOOL)ignoreHolder;

/**
 返回YES,则表示在移动网络下，仍然加载图片资源
 返回NO,则表示在移动网络情况下，不加载图片资源
 */
- (BOOL)downloadWithMobileNetWork;

@end


