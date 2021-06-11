//
//  GetSimilarity.h
//  Recoder
//
//  Created by boli on 2021/5/30.
//  Copyright © 2021 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef double Similarity;

NS_ASSUME_NONNULL_BEGIN

@interface GetSimilarity : NSObject

- (void)setImgWithImgA:(UIImage*)imgA ImgB:(UIImage*)imgB;//设置需要对比的图片
- (void)setImgAWidthImg:(UIImage*)img;
- (void)setImgBWidthImg:(UIImage*)img;
- (Similarity)getSimilarityValue; //获取相似度
+ (Similarity)getSimilarityValueWithImgA:(UIImage*)imga ImgB:(UIImage*)imgb;//类方法

@end

NS_ASSUME_NONNULL_END
