//
//  SampleHandler.m
//  Recoder
//
//  Created by boli on 2021/5/30.
//


#import "SampleHandler.h"
#import "CBTool.h"
#import "GetSimilarity.h"

static NSTimeInterval pictureTime = 2;
static double maxSimilarity = 0.8;

@interface SampleHandler ()
//@property (nonatomic, strong) ZFUploadTool *tool;
@property (nonatomic, assign) BOOL save;
@property (nonatomic, strong) UIImage *preImage;
@end


@implementation SampleHandler

- (void)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo {
    // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
    [self timerAction];
    _save = true;
}

- (void)timerAction {
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSTimer scheduledTimerWithTimeInterval:pictureTime repeats:YES block:^(NSTimer * _Nonnull timer) {
            self.save = true;
        }];
        
    });
}

- (void)save:(CMSampleBufferRef)sampleBuffer {
    if (_save) {
        _save = NO;
    } else {
        return;
    }
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage* ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    
    CIContext* context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
    
    CGRect rect = CGRectMake(0, 0, CVPixelBufferGetWidth(pixelBuffer), CVPixelBufferGetHeight(pixelBuffer));
    CGImageRef videoImage = [context createCGImage:ciImage fromRect:rect];
    
    UIImage* image = [UIImage imageWithCGImage:videoImage];
    CGImageRelease(videoImage);
    
    if (_preImage == nil) {
        _preImage = image;
        [CBTool saveImage:image];
    } else {
        double similarity = [GetSimilarity getSimilarityValueWithImgA:_preImage ImgB:image];
        if (similarity < maxSimilarity) {
            _preImage = image;
            [CBTool saveImage:image];
        } else {
            NSLog(@"");
        }
    }
    
    
}

- (void)broadcastPaused {
    // User has requested to pause the broadcast. Samples will stop being delivered.
}

- (void)broadcastResumed {
    // User has requested to resume the broadcast. Samples delivery will resume.
}

- (void)broadcastFinished {
    // User has requested to finish the broadcast.
}

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType {
    
    switch (sampleBufferType) {
        case RPSampleBufferTypeVideo:
            // Handle video sample buffer
            [self save:sampleBuffer];
            break;
        case RPSampleBufferTypeAudioApp:
            // Handle audio sample buffer for app audio
            break;
        case RPSampleBufferTypeAudioMic:
            // Handle audio sample buffer for mic audio
            break;
            
        default:
            break;
    }
}

@end
