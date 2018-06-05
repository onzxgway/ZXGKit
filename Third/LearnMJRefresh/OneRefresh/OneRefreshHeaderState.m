//
//  OneRefreshHeaderState.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/5.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "OneRefreshHeaderState.h"

@interface OneRefreshHeaderState ()
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *timeLabel;

/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation OneRefreshHeaderState

- (void)prepare {
    [super prepare];
    
    // 初始化文字
    [self setState:OneRefreshStatusNormal value:[NSBundle localizedStringForKey:OneRefreshHeaderNormalText]];
    [self setState:OneRefreshStatusPulling value:[NSBundle localizedStringForKey:OneRefreshHeaderPullingText]];
    [self setState:OneRefreshStatusRefreshing value:[NSBundle localizedStringForKey:OneRefreshHeaderRefreshingText]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.stateLabel.constraints.count == 0) {
        self.stateLabel.left = 0;
        self.stateLabel.top = 0;
        self.stateLabel.width = self.width;
        self.stateLabel.height = self.height * 0.5;
    }
}

- (void)setStatus:(OneRefreshStatus)status {
    OneRefreshStatus oldState = self.status;
    if (status == oldState) return;
    [super setStatus:status];
    
    self.stateLabel.text = self.stateTitles[@(status)];
}

- (void)setState:(OneRefreshStatus)state value:(NSString *)title {
    if (!title) return;
    
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.status)];
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel oneRefreshLabel]];
        _stateLabel.backgroundColor = kRandomColor;
    }
    return _stateLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        [self addSubview:_timeLabel = [UILabel oneRefreshLabel]];
    }
    return _timeLabel;
}

- (NSMutableDictionary *)stateTitles {
    if (!_stateTitles) {
        _stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

@end
