//
//  MJRefreshNormalHeader.m
//  Third
//
//  Created by 朱献国 on 2018/5/23.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "MJRefreshStateHeader.h"

@interface MJRefreshStateHeader () {
    UILabel *_stateLabel;
    UILabel *_lastUpdatedTimeLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation MJRefreshStateHeader

- (void)prepare {
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = MJRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshHeaderIdleText] forState:MJJRefreshStateIdle];
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshHeaderPullingText] forState:MJJRefreshStatePulling];
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshHeaderRefreshingText] forState:MJJRefreshStateRefreshing];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    if (self.stateLabel.hidden) {
        return;
    }
    
    // 判断时间控件是否隐藏
    if (self.lastUpdatedTimeLabel.hidden) {
        if (self.stateLabel.constraints.count == 0) {
            self.stateLabel.frame = self.bounds;
        }
    }
    else {
        
        if (_stateLabel.constraints.count == 0) {
            _stateLabel.mj_x = 0;
            _stateLabel.mj_y = 0;
            _stateLabel.mj_w = self.mj_w;
            _stateLabel.mj_h = self.mj_h * 0.5;
        }
        
        if (_lastUpdatedTimeLabel.constraints.count == 0) {
            _lastUpdatedTimeLabel.mj_x = 0;
            _lastUpdatedTimeLabel.mj_y = self.mj_h * 0.5;
            _lastUpdatedTimeLabel.mj_w = self.mj_w;
            _lastUpdatedTimeLabel.mj_h = self.mj_h * 0.5;
        }
    }
}

- (void)setState:(MJJRefreshState)state {
    MJJRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    
    self.stateLabel.text = self.stateTitles[@(state)];
    
    // 重新设置key（重新显示时间）
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJJRefreshState)state {
    if (title == nil) return;
    
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (NSMutableDictionary *)stateTitles {
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

#pragma mark - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}


- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey {
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    //1.判断时间标签是否显示
    if (self.lastUpdatedTimeLabel.hidden) return;
    
    NSDate *lastUpdatedTime = self.lastUpdatedTime;
    
    //2.判断是否有外部block处理时间
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
        return;
    }
    
    //3.默认处理
    if (lastUpdatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [self currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
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
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        
        // 3.显示日期
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@%@",
                                          [NSBundle mj_localizedStringForKey:MJRefreshHeaderLastTimeText],
                                          isToday ? [NSBundle mj_localizedStringForKey:MJRefreshHeaderDateTodayText] : @"",
                                          time];
    }
    else {
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@",
                                          [NSBundle mj_localizedStringForKey:MJRefreshHeaderLastTimeText],
                                          [NSBundle mj_localizedStringForKey:MJRefreshHeaderNoneLastDateText]];
    }
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel mj_label]];
    }
    return _stateLabel;
}

- (UILabel *)lastUpdatedTimeLabel {
    if (!_lastUpdatedTimeLabel) {
        [self addSubview:_lastUpdatedTimeLabel = [UILabel mj_label]];
    }
    return _lastUpdatedTimeLabel;
}

@end
