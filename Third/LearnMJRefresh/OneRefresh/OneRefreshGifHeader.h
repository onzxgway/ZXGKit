//
//  OneRefreshGifHeader.h
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/9.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "OneRefreshHeaderState.h"

@interface OneRefreshGifHeader : OneRefreshHeaderState

@property (nonatomic, weak  , readonly) UIImageView *gifImage;

- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(OneRefreshStatus)state;
- (void)setImages:(NSArray *)images forState:(OneRefreshStatus)state;

@end
