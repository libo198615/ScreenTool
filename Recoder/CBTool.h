//
//  CBTool.h
//  LFLiveKitDemo
//
//  Created by boli on 2021/5/29.
//  Copyright © 2021 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <VideoToolbox/VideoToolbox.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBTool : NSObject

+ (UIImage*)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;

+ (void)saveImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
