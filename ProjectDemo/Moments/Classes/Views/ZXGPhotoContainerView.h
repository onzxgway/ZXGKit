//
//  XVPhotoContainerView.h
//  MaoMeng
//
//  Created by feizhu on 2017/12/26.
//  Copyright © 2017年 xiaov. All rights reserved.
//


#import <UIKit/UIKit.h>
@class ZXGDynamicModel;

@interface ZXGPhotoContainerView : UIView

@property (nonatomic, strong) ZXGDynamicModel *momentsModel;

@property (nonatomic, strong) NSArray *picPathStringsArray;

@property (nonatomic, copy  ) NSString *coverUrl;//视频第一帧的url

@property (nonatomic, copy  ) dispatch_block_t playCallback;//播放视频回调

@end
