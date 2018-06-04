//
//  NewTableViewCell.m
//  LearnMasonry
//
//  Created by 朱献国 on 2018/6/4.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "NewTableViewCell.h"

@interface NewTableViewCell ()

@property (nonatomic, strong) MASConstraint *cF; //constraint first row
@property (nonatomic, strong) MASConstraint *cB; //constraint blue
@property (nonatomic, strong) MASConstraint *cY; //constraint yellow
@property (nonatomic, strong) MASConstraint *cR; //constraint red
@property (nonatomic, strong) MASConstraint *cG; //constraint green

@property (nonatomic, strong) UIView *gF; //group first row
@property (nonatomic, strong) UIView *gB; //group blue
@property (nonatomic, strong) UIView *gY; //group yellow
@property (nonatomic, strong) UIView *gR; //group red
@property (nonatomic, strong) UIView *gG; //group green

@property (nonatomic, strong) UIView *vB; //view blue    height:30
@property (nonatomic, strong) UIView *vY; //view yellow  height:30
@property (nonatomic, strong) UIView *vR; //view red     height:30
@property (nonatomic, strong) UIView *vG; //view green   height:100

@end

@implementation NewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //-----------------//
        CGFloat spacing = 20.0f;
        self.gF = [UIView new];
        [self.contentView addSubview:self.gF];
        [self.gF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            
            self.cF = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
            [self.cF deactivate];
        }];
        self.gF.clipsToBounds = YES;
        
        self.gB = [UIView new];
        [self.gF addSubview:self.gB];
        [self.gB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self.gF);
            
            self.cB = make.width.equalTo(@0).priority(UILayoutPriorityRequired);
            [self.cB deactivate];
        }];
        self.gB.clipsToBounds = YES;
        
        self.gY = [UIView new];
        [self.gF addSubview:self.gY];
        [self.gY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(self.gF);
            make.left.mas_equalTo(self.gB.mas_right);
            
            self.cY = make.width.equalTo(@0).priority(UILayoutPriorityRequired);
            [self.cY deactivate];
        }];
        self.gY.clipsToBounds = YES;
        
        self.gR = [UIView new];
        [self.contentView addSubview:self.gR];
        [self.gR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);  // 约束的优先级属性
            make.top.equalTo(self.gF.mas_bottom);       // 默认优先级都是最高的1000
            //            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
            self.cR = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
            [self.cR deactivate];
        }];
        self.gR.clipsToBounds = YES;
        
        self.gG = [UIView new];
        [self.contentView addSubview:self.gG];
        [self.gG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.gR.mas_bottom);
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-spacing);
            self.cG = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
            [self.cG deactivate];
        }];
        self.gG.clipsToBounds = YES;
        
        //-----------------//
        self.vB = [UIView new];
        [self.gB addSubview:self.vB];
        [self.vB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.gB).insets(UIEdgeInsetsMake(spacing, spacing, 0, 0)).priorityLow();
            make.height.equalTo(@30);
            make.width.equalTo(@60);
        }];
        self.vB.backgroundColor = [UIColor blueColor];
        
        self.vY = [UIView new];
        [self.gY addSubview:self.vY];
        [self.vY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.gY).insets(UIEdgeInsetsMake(spacing, spacing, 0, spacing)).priorityLow();
            make.height.equalTo(@30);
        }];
        self.vY.backgroundColor = [UIColor yellowColor];
        
        self.vR = [UIView new];
        [self.gR addSubview:self.vR];
        [self.vR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.gR).insets(UIEdgeInsetsMake(spacing, spacing, 0, spacing)).priorityLow();
            make.height.equalTo(@30);
        }];
        self.vR.backgroundColor = [UIColor redColor];
        
        self.vG = [UIView new];
        [self.gG addSubview:self.vG];
        [self.vG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.gG).insets(UIEdgeInsetsMake(spacing, spacing, 0, spacing)).priorityLow();
            make.height.equalTo(@100);
        }];
        self.vG.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}

- (void)setType:(CellType)type {
    
    [self.cF deactivate];
    [self.cB deactivate];
    [self.cY deactivate];
    [self.cR deactivate];
    [self.cG deactivate];
    
    switch (type) {
        case CellType1111: {
            
        }
            break;
        case CellType1110: {
            [self.cG activate];
        }
            break;
        case CellType0111: {
            [self.cB activate];
        }
            break;
        case CellType0011: {
            [self.cF activate];
        }
            break;
        case CellType0010: {
            [self.cF activate];
            [self.cG activate];
        }
            break;
        case CellType1101: {
            [self.cR activate];
        }
            break;
            
        default:
            break;
    }
}


@end
