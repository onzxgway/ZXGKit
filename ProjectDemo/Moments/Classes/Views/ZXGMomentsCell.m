//
//  ZXGMomentsCell.m
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsCell.h"
#import "ZXGPhotoContainerView.h"

static NSString *const CellRereuseID = @"ZXGMomentsCell";
static CGFloat const kTimeFontSize = 11;//时间字体大小
static CGFloat const kContentFontSize = 16;//内容字体大小
CGFloat maxContentLabelHeight = 0; // 根据具体font而定
static CGFloat const kNameFontSize = 16.f;

@interface ZXGMomentsCell ()

#pragma mark - subViews
@property (nonatomic, strong) UIView *topLine;       //顶部分割线
@property (nonatomic, strong) UIImageView *iconImg;  //头像
@property (nonatomic, strong) UILabel *nameLab;      //名称
//@property (nonatomic, strong) UIImageView *genderImg;//性别
//@property (nonatomic, strong) XVLevel *levelView;   //等级
@property (nonatomic, strong) UILabel *contentLab;   //内容
//@property (nonatomic, strong) UIButton *likeButton;  //点赞按钮
//@property (nonatomic, strong) UIButton *moreButton;  //全部评论按钮
@property (nonatomic, strong) ZXGPhotoContainerView *picContainerView;//图片容器
@property (nonatomic, strong) UILabel *timeLab;         //时间
//@property (nonatomic, strong) UIButton *deleteButton;   //删除按钮
//@property (nonatomic, strong) UIButton *operationButton;//操作按钮
//@property (nonatomic, strong) SDTimeLineCellOperationMenu *operationMenu;//操作菜单

@end

@implementation ZXGMomentsCell

#pragma mark - APIs
+ (instancetype)momentsCell:(UITableView *)tableView {
    ZXGMomentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellRereuseID];
    if (!cell) {
        cell = [[ZXGMomentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellRereuseID];
    }
    return cell;
}

#pragma mark - Overwrite
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
        
        // 1. 栅格化，美工的术语：将 cell 中的所有内容，生成一张独立的图像
        // 在屏幕滚动时，只显示图像
        self.layer.shouldRasterize = YES;
        // 栅格化，必须指定分辨率，否则默认使用 * 1，生成图像！
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        // 2. 异步绘制！如果 cell 比较复杂，可以使用！
        self.layer.drawsAsynchronously = YES;
        
    }
    return self;
}

#pragma mark - Initial
- (void)setupUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = RGBA(255, 254, 255, 1.0);
    
    //布局子控件
    UIView *contentView = self.contentView;
    contentView.backgroundColor = kRandomColor;
    
//    //顶部分割线
//    [contentView addSubview:self.topLine];
//    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(contentView);
//        make.height.mas_equalTo(0.4);
//    }];
//    
//    //头像
//    [contentView addSubview:self.iconImg];
//    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(contentView.mas_left).offset(LeftMargin);
//        make.top.equalTo(contentView.mas_top).offset(TopMargin);
//        make.size.mas_equalTo(CGSizeMake(IconImageW, IconImageH));
//    }];
//    
//    //名称
//    [contentView addSubview:self.nameLab];
//    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.iconImg.mas_right).offset(HMargin);
//        make.centerY.equalTo(self.iconImg.mas_centerY);
//        make.height.mas_equalTo(kNameFontSize);
//        make.width.lessThanOrEqualTo(@200);
//    }];
//    
//    
//    //性别
//    [contentView addSubview:self.genderImg];
//    [self.genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameLab.mas_right).offset(HMargin);
//        make.centerY.equalTo(self.iconImg.mas_centerY);
//        make.height.equalTo(self.nameLab.mas_height);
//        make.width.equalTo(self.nameLab.mas_height);
//    }];
//    
//    //等级
//    [contentView addSubview:self.levelView];
//    [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.genderImg.mas_right).offset(HMargin);
//        make.top.equalTo(self.genderImg.mas_top).offset(-3);
//        make.bottom.equalTo(self.genderImg.mas_bottom).offset(0);
//        make.width.equalTo(self.levelView.mas_height).multipliedBy(2.8);
//    }];
//    
//    //点赞
//    [contentView addSubview:self.likeButton];
//    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(contentView.mas_right).offset(-RightMargin);
//        make.centerY.equalTo(self.iconImg.mas_centerY);
//        make.height.equalTo(self.nameLab.mas_height);
//        make.width.lessThanOrEqualTo(@80);
//    }];
//    
//    //内容
//    [contentView addSubview:self.contentLab];
//    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.nameLab.mas_bottom).offset(VMargin);
//        make.left.equalTo(self.nameLab.mas_left);
//        make.right.equalTo(contentView.mas_right).offset(-RightMargin);
//    }];
//    
//    //图片容器
//    [contentView addSubview:self.picContainerView];
//    [self.picContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        //已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
//        make.left.equalTo(self.nameLab.mas_left);
//    }];
//    
//    //时间
//    [contentView addSubview:self.timeLab];
//    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.picContainerView.mas_bottom).offset(VMargin);
//        make.left.equalTo(self.nameLab.mas_left);
//    }];
//    
//    //全部评论
//    [contentView addSubview:self.moreButton];
//    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameLab.mas_left);
//    }];
//    
//    //操作按钮
//    [contentView addSubview:self.operationButton];
//    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(contentView.mas_right).offset(-RightMargin);
//        make.centerY.equalTo(self.timeLab.mas_centerY);
//        make.height.equalTo(self.likeButton.mas_height);
//        make.width.equalTo(self.operationButton.mas_height).multipliedBy(2);
//    }];
//    
//    //删除按钮
//    [contentView addSubview:self.deleteButton];
//    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.timeLab.mas_right).offset(HMargin);
//        make.centerY.equalTo(self.timeLab.mas_centerY);
//    }];
//    
//    //评论
//    [contentView addSubview:self.commentView];
//    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameLab.mas_left);
//        make.right.equalTo(self.likeButton.mas_right);
//    }]; // 已经在内部实现高度自适应所以不需要再设置高度
//    
//    //底部分割线
//    [contentView addSubview:self.bottomLine];
//    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(contentView);
//        make.height.mas_equalTo(0.4 );
//    }];
    
}

#pragma mark - Lazy Load
//顶部分割线
- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = RGBA(226, 226, 226, 1.0);
        _topLine.hidden = NO;
    }
    return _topLine;
}

//头像
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.backgroundColor = kRandomColor;
        _iconImg.userInteractionEnabled = YES;
        [_iconImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImgClick)]];
    }
    return _iconImg;
}

//名称
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont boldSystemFontOfSize:kNameFontSize];
        _nameLab.textColor = kBlueColor;
        _nameLab.backgroundColor = kRandomColor;
    }
    return _nameLab;
}

//时间
- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = [UIFont systemFontOfSize:kTimeFontSize];
        _timeLab.textColor = [UIColor grayColor];
        _timeLab.backgroundColor = kRandomColor;
    }
    return _timeLab;
}

//内容
- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.font = [UIFont systemFontOfSize:kContentFontSize];
        _contentLab.numberOfLines = 0;
        _contentLab.backgroundColor = kRandomColor;
    }
    return _contentLab;
}


//头像点击
- (void)iconImgClick {
    
}

@end
