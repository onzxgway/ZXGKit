
//
//  ArmbandDecorationReusableView.m
//  UIKit
//
//  Created by 朱献国 on 2019/3/19.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ArmbandDecorationReusableView.h"
#import "DecorationCollectionViewLayout.h"

@interface ArmbandDecorationReusableView ()

@property (nonatomic, strong) UIImageView *armbandImageView;

@end

@implementation ArmbandDecorationReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, 80, 53);
    self = [super initWithFrame:newFrame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    self.backgroundColor = [UIColor clearColor];
    
    _armbandImageView = [[UIImageView alloc] init];
    _armbandImageView.frame = CGRectMake(0, 0, 80, 53);
    _armbandImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_armbandImageView];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    if (layoutAttributes) {
        
        NSString *named = ((ArmbandDecorationCollectionViewLayoutAttributes *)layoutAttributes).imageName;
        self.armbandImageView.image = [UIImage imageNamed:named];
        
    }
    
}

@end
