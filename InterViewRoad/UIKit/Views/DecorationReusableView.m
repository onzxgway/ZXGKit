//
//  DecorationReusableView.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "DecorationReusableView.h"
#import "DecorationCollectionViewLayout.h"

@implementation DecorationReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = 6.0;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    if (layoutAttributes) {
        self.backgroundColor = ((DecorationCollectionViewLayoutAttributes *)layoutAttributes).backgroundColor;
    }
    
}

@end
