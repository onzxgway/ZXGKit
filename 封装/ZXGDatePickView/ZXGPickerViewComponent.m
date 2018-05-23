//
//  ZXGDatePickerView.m
//  eStudy(comprehensive)
//
//  Created by 朱献国 on 2018/5/14.
//  Copyright © 2018年 苏州橘子网络科技股份有限公司. All rights reserved.
//

#import "ZXGPickerViewComponent.h"

static NSTimeInterval const kDuration = 0.15f;
static CGFloat const kBtnW = 48;
static CGFloat const kBtnH = 42;

@interface ZXGPickerViewComponent () {
    NSMutableArray *_MArray;
    
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
    
    NSString *_dateStr;
    NSInteger _dayRange;
    
    CGFloat _W;
    CGFloat _H;
}

@property (strong, nonatomic) UIView *bottomContainerView;
@property (weak,   nonatomic) UIDatePicker *pickerView;
@end

@implementation ZXGPickerViewComponent

#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self prepare];
    }
    return self;
}

#pragma mark - init
- (void)prepare {
    
    _MArray = [NSMutableArray array];
    // 默认的属性设置
    _duration = kDuration;                  // 动画时间
    _coverAlpha = 0.2;                      // 遮罩的透明度
    _coverColor = [UIColor blackColor];     // 遮罩的颜色
    _pickerViewBackgroundColor = [UIColor whiteColor];  // pickView默认背景颜色
    if ([UIScreen mainScreen].bounds.size.height >= 667) {
        _screenHeightPercent = 0.4;
    }
    else {
        _screenHeightPercent = 0.5;
    }
    
    self.backgroundColor = [UIColor clearColor];
    // 添加子控件->遮罩
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    coverBtn.alpha = self.coverAlpha;
    coverBtn.backgroundColor = self.coverColor;
    [coverBtn addTarget:self action:@selector(coverBtn) forControlEvents:UIControlEventTouchDown];
    coverBtn.frame = self.bounds;
    [self addSubview:coverBtn];
    
    // 添加子控件->底部弹出的容器视图
    UIView *bottomContainerView = [[UIView alloc] init];
    self.bottomContainerView = bottomContainerView;
    bottomContainerView.backgroundColor = [UIColor whiteColor];
    bottomContainerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * _screenHeightPercent);
    [self bottomContainerViewAddSubviews:bottomContainerView];
    [self addSubview:bottomContainerView];
    self.alpha = 0.f;
}

//容器视图添加子控件
- (void)bottomContainerViewAddSubviews:(UIView *)superView {
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0, 0, kBtnW, kBtnH);
    [superView addSubview:cancelBtn];
    
    //中间标签
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"截止时间";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.width = 100;
    titleLabel.top = 0;
    titleLabel.height = cancelBtn.height;
    titleLabel.left = SCREEN_WIDTH * 0.5 - titleLabel.width * 0.5;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:titleLabel];
    
    //确定按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(SCREEN_WIDTH - cancelBtn.bounds.size.width, cancelBtn.frame.origin.y, cancelBtn.bounds.size.width, cancelBtn.bounds.size.height);
    [superView addSubview:sureBtn];
    
    //分割线
    CALayer *line = [[CALayer alloc] init];
    line.backgroundColor = kRandomColor.CGColor;
    line.frame = CGRectMake(0, CGRectGetMaxY(cancelBtn.frame), self.frame.size.width, 1);
    [superView.layer addSublayer:line];

    
    UIDatePicker *pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cancelBtn.frame) + 1, self.frame.size.width, superView.bounds.size.height - cancelBtn.bounds.size.height - 1)];
    pickerView.date = [NSDate date];
    //设置本地化支持的语言（在此是中文)
    pickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    self.pickerView = pickerView;
    pickerView.backgroundColor = self.pickerViewBackgroundColor;
    
    pickerView.maximumDate = [NSDate dateWithTimeInterval:30*24*60*60 sinceDate:[NSDate date]];
    pickerView.minimumDate = [NSDate date];//今天
    
    [superView addSubview:pickerView];
}

#pragma mark - private
#pragma mark - public
#pragma mark - lazyLoad
#pragma mark - public
//开始
- (void)show {
    [UIView animateWithDuration:_duration animations:^{
        self.bottomContainerView.transform = CGAffineTransformMakeTranslation(0, - SCREEN_HEIGHT * _screenHeightPercent);
        self.alpha = 1.f;
    } completion:nil];
    
    //设置self属性
//    UIWindow *displayWindow = [[UIApplication sharedApplication].delegate window];
//    self.frame = [UIScreen mainScreen].bounds;
//    [displayWindow addSubview:self];
}

//结束
- (void)hide {
    [UIView animateWithDuration:_duration animations:^{
        self.bottomContainerView.transform = CGAffineTransformIdentity;
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - event
- (void)buttonClick:(UIButton *)btn{
    
    if (btn.tag == 101) {
        //
        
    }
    else if (btn.tag == 102){
        //

    }
    
}

// 半透明的背景按钮点击响应方法
- (void)coverBtn {
    [self hide];
}

//取消按钮
- (void)cancelBtnClick {
    [self hide];
}

//确定按钮
- (void)confirmBtnClick {
    
    NSDate *date = self.pickerView.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *string = [dateFormatter stringFromDate:date];
    
    if (self.pickViewSelectedDateCallback) {
        self.pickViewSelectedDateCallback(string);
    }
    
    NSLog(@"selectedDate %@", string);
}

@end
