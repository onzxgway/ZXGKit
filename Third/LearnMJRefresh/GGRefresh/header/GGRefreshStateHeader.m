//
//  GGRefreshStateHeader.m
//  LearnMJRefresh
//
//  Created by onzxgway on 2019/3/26.
//  Copyright © 2019年 zhuxianguo. All rights reserved.
//

#import "GGRefreshStateHeader.h"

@interface GGRefreshStateHeader ()

@end

@implementation GGRefreshStateHeader

- (void)prepare {
    [super prepare];
    
    [self addSubview:self.stateLab];
    [self addSubview:self.timeLab];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    self.stateLab.frame = self.bounds;
    self.stateLab.gg_height = self.gg_height * 0.5;
    
    self.timeLab.frame = self.bounds;
    self.timeLab.gg_height = self.gg_height * 0.5;
    self.timeLab.gg_top = self.stateLab.gg_bottom;
}

- (void)setState:(GGRefreshState)state {
    GGRefreshState oldState = self.state;
    if (oldState == state) return;
    [super setState:state];
    
    if (state == GGRefreshStateIdle) {

        self.stateLab.text = @"下拉刷新";
        
    }
    else if (state == GGRefreshStateRefreshing) {
        
        self.stateLab.text = @"刷新中...";
        
    }
    else if (state == GGRefreshStatePulling) {
        
        self.stateLab.text = @"松开即可刷新";
        
    }
    
    self.timeLab.text = [self lastUpdateTime];
    
}

- (NSString *)lastUpdateTime {
    
    NSString *strDate = nil;
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastUpdatedTimeKey"];
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
