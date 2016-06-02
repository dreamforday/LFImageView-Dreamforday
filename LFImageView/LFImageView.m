//
//  LFImageView.m
//  LFImageViewDemo
//
//  Created by WangZhiWei on 16/5/24.
//  Copyright © 2016年 youku. All rights reserved.
//

#import "LFImageView.h"
#import "UIImageView+WebCache.h"
#import "UIView+WebCacheOperation.h"
#import "Reachability.h"

static NSString * const  LFImageViewDownloadErrorDesc = @"当前网络为移动网络,且不允许下载图片。";
static NSString * const  LFImageViewNetWorkErrorDesc = @"当前网络不可用。";

typedef NS_ENUM(NSInteger, LFImageViewErro)
{
    LFImageViewNoError = 0,
    LFImageViewDownloadError,
    LFImageViewNetWorkError,
};

@implementation LFImageView


/*!
 @method
 @abstract
 @discussion
 @param 	url 	图片资源url
 @result
 */
- (void)lf_setImageWithURL:(NSURL *)url
{
    [self lf_setImageWithURL:url placeholderImage:nil errorholderImage:nil];
}


/*!
 @method
 @abstract
 @discussion
 @param 	url 	图片资源url
 @param 	placeholder 	占位符图片
 @result
 */
- (void)lf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self lf_setImageWithURL:url placeholderImage:placeholder errorholderImage:nil];
}


/*!
 	@method
 	@abstract
 	@discussion
 	@param 	url 	图片资源url
 	@param 	placeholder 	占位符图片
 	@param 	errorholder 	默认异常图片
 	@param 	progressBlock 	下载进度回调
 	@param 	completedBlock 	下载完成回调
 	@result
 */
- (void)lf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder errorholderImage:(UIImage *)errorholder
{
    [self sd_cancelCurrentImageLoad];
    
    //是否支持placeholder
    if (!self.ignoreHolder) {
        dispatch_main_async_safe(^{
            self.image = placeholder;
        });
    }
    
    if (!url) return ;
    
    //判断缓存中是否有图片
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    SDImageCache *cache = [SDWebImageManager sharedManager].imageCache;
    UIImage *cacheImage = [cache imageFromMemoryCacheForKey:key];
    if (cacheImage) {
        dispatch_main_async_safe(^{
            
            self.image = cacheImage;
        
            if (self.compledBlock) {
                self.compledBlock(cacheImage,nil,YES);
            }
        });
        return;
    }
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.laifeng.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
    //如果当前网络环境为wifi或者 网络为移动网络且允许下载图片
    if (status == ReachableViaWiFi || (status != ReachableViaWiFi  && status != NotReachable && self.downloadWithMobileNetWork)) {
        __weak __typeof(self) weakSelf = self;
        
        id<SDWebImageOperation> operation = [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            
            if (!strongSelf) return ;
            
            dispatch_main_async_safe(^{
                
             if (strongSelf.progressBlock) strongSelf.progressBlock(receivedSize,expectedSize);
                
            });
           
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            
            if(!strongSelf) return ;
            
            dispatch_main_async_safe(^{
                
                if (image) {
                    
                    strongSelf.image = image;
                    [strongSelf setNeedsLayout];
                    if (strongSelf.compledBlock) strongSelf.compledBlock(image,error,finished);
                }else
                {
                    strongSelf.image = errorholder;
                    [strongSelf setNeedsLayout];
                    if (strongSelf.compledBlock) strongSelf.compledBlock(errorholder,error,finished);
                    
                }
            });
        }];
        
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
        
    }//如果当前网络环境为移动网络,且不允许下载
    else if (status != ReachableViaWiFi  && status != NotReachable && !self.downloadWithMobileNetWork)
    {
        //do nothing
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:LFImageViewDownloadErrorDesc code:LFImageViewDownloadError userInfo:nil];
            if(self.compledBlock)  self.compledBlock(nil,error,NO);
        });
    }//当前网络不可用
    else if(status == NotReachable)
    {
        dispatch_main_async_safe(^{
            
            self.image = errorholder;
            NSError * error = [NSError errorWithDomain:LFImageViewNetWorkErrorDesc code:LFImageViewNetWorkError userInfo:nil];
            if(self.compledBlock) self.compledBlock(nil,error,NO);
        });
        
    }
}


#pragma mark --setter,getter方法

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
