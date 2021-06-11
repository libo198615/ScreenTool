//
//  CBTool.m
//  LFLiveKitDemo
//
//  Created by boli on 2021/5/29.
//  Copyright © 2021 admin. All rights reserved.
//

#import "CBTool.h"
#import <VideoToolbox/VideoToolbox.h>
#import <Photos/Photos.h>

@implementation CBTool


+ (UIImage*)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
//    CFRetain(sampleBuffer);

    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage* ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    
    CIContext* context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
    
    CGRect rect = CGRectMake(0, 0, CVPixelBufferGetWidth(pixelBuffer), CVPixelBufferGetHeight(pixelBuffer));
    CGImageRef videoImage = [context createCGImage:ciImage fromRect:rect];
    
    UIImage* image = [UIImage imageWithCGImage:videoImage];
    CGImageRelease(videoImage);
    
//    CFRelease(sampleBuffer);
    
    return image;
}

+ (void)saveImage:(UIImage *)image {
    [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",@"保存失败");
        } else {
            NSLog(@"%@",@"保存成功");
        }
    }];
}




@end
