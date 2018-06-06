//
//  OneRefreshHeaderState.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2018/6/5.
//  Copyright © 2018 feizhu. All rights reserved.
//

#import "OneRefreshHeaderState.h"

@interface OneRefreshHeaderState () {
    UILabel *_stateLabel;
    UILabel *_timeLabel;
}

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
    
    if (self.timeLabel.constraints.count == 0) {
        self.timeLabel.left = 0;
        self.timeLabel.height = self.height * 0.5;
        self.timeLabel.top = self.timeLabel.height;
        self.timeLabel.width = self.width;
    }
}

- (void)setStatus:(OneRefreshStatus)status {
    OneRefreshStatus oldState = self.status;
    if (status == oldState) return;
    [super setStatus:status];
    
    self.stateLabel.text = self.stateTitles[@(status)];
    
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
}

- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey {
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    NSDate *lastUpdatedDate = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    if (lastUpdatedDate) {
        NSCalendar *calendar = [self currentCalendar];
        NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unit fromDate:lastUpdatedDate];
        NSDateComponents *cmp2 = [calendar components:unit fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        BOOL isToday = NO;
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @" HH:mm";
            isToday = YES;
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:lastUpdatedDate];
        
        // 3.显示日期
        self.timeLabel.text = [NSString stringWithFormat:@"%@%@%@",
                                          [NSBundle localizedStringForKey:OneRefreshHeaderLastTimeText],
                                          isToday ? [NSBundle localizedStringForKey:OneRefreshHeaderDateTodayText] : @"",
                                          time];
    }
    else {
        self.timeLabel.text = [NSString stringWithFormat:@"%@%@",
                                          [NSBundle localizedStringForKey:OneRefreshHeaderLastTimeText],
                                          [NSBundle localizedStringForKey:OneRefreshHeaderNoneLastDateText]];
    }
}

- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
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
        _timeLabel.backgroundColor = kRandomColor;
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
