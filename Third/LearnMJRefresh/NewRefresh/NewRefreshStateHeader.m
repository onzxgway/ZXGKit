//
//  NewRefreshStateHeader.m
//  LearnMJRefresh
//
//  Created by 朱献国 on 2019/3/21.
//  Copyright © 2019年 feizhu. All rights reserved.
//

#import "NewRefreshStateHeader.h"

@interface NewRefreshStateHeader ()

@end

@implementation NewRefreshStateHeader


- (void)addSubViews {
    [super addSubViews];
    
    [self addSubview:self.stateLab];
    [self addSubview:self.timeLab];
}

- (void)placeSubViews {
    [super placeSubViews];
    
    self.stateLab.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.5);
    self.timeLab.frame = CGRectMake(0, self.bounds.size.height * 0.5, self.bounds.size.width, self.bounds.size.height * 0.5);
}

- (void)setState:(NRRefreshState)state {
    [super setState:state];
    
    if (state == NRRefreshStateIdle) {
        self.stateLab.text = @"下拉刷新";
    }
    else if (state == NRRefreshStateRefreshing) {
        self.stateLab.text = @"正在刷新...";
        
    }
    else if (state == NRRefreshStatePulling) {
        self.stateLab.text = @"松开即可刷新";
    }
    
    self.timeLab.text = [self lastUpdateTime];
    
}

- (NSString *)lastUpdateTime {
    
    NSString *strDate = nil;
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"time"];
    if (!date) {
        strDate = @"暂无时间";
    }
    else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        strDate = [dateFormatter stringFromDate:date];
    }
    
    return strDate;
}

- (UILabel *)stateLab {
    if (!_stateLab) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:13.f];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.numberOfLines = 1;
        
        _stateLab = lab;
    }
    return _stateLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:13.f];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.numberOfLines = 1;
        
        _timeLab = lab;
    }
    return _timeLab;
}

@end
