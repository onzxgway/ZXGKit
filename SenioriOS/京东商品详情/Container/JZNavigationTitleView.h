//
//  JZNavigationTitleView.h
//  onzxgway
//
//  Created by zxg on 2018/11/29.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^JZNTVItemClickedBlock) (NSInteger);

@interface JZNavigationTitleView : UIScrollView

@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, copy  ) JZNTVItemClickedBlock itemClickedCallback;

//- (void)scrollToPercent:(CGFloat)percent;

- (void)selectedItem:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
