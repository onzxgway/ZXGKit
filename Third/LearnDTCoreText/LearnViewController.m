//
//  LearnViewController.m
//  Third
//
//  Created by 朱献国 on 2018/7/9.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "LearnViewController.h"

@interface LearnViewController () <DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>
@property (nonatomic, copy  ) NSString *html;
@property (nonatomic, strong) DTAttributedLabel *attributedLabel;
@end

@implementation LearnViewController {
    CGRect _viewMaxRect;
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _html = @"<span style=\"color:#333;font-size:15px;\"><strong>标题1</strong></span><br/><span align=\"left\" style=\"color:#333;font-size:15px;\">详细介绍详细介绍详细介绍详细介绍详细介绍详细介绍。</span><br/><img src=\"http://cn-qinqimaifang-uat.oss-cn-hangzhou.aliyuncs.com/img/specialist/upload/spcetiicwlz1v_54e2e00fa8a6faf66168571654dbfee2.jpg\" _src=\"http://cn-qinqimaifang-uat.oss-cn-hangzhou.aliyuncs.com/img/specialist/upload/spcetiicwlz1v_54e2e00fa8a6faf66168571654dbfee2.jpg\"><br/><br/><span style=\"color:#333;font-size:15px;\">百度:<a href=\"http://www.baidu.com.cn\">my testlink</a></span><br/><br/><span style=\"color:#333;font-size:15px;\">电话：<a href=\"tel:4008001234\">my phoneNum</a></span><br/><br/><span style=\"color:#333;font-size:15px;\">我邮箱:<a href=\"mailto:dreamcoffeezs@163.com\">my mail</a></span>";
    
    _html = @"<p>据统计，1平方米阔叶林在生长季节每天大约能吸收二氧化碳0.1千克，释放氧气0.073千克，那么1000平方米阔叶林在生长季节每天大约能吸收二氧化碳(&nbsp;&nbsp;&nbsp;&nbsp;)千克，释放氧气(&nbsp;&nbsp;&nbsp;&nbsp;)千克。</p>";
    
    [self createViews];
}

#pragma mark - CreateViews
- (void)createViews {
    //1.创建DTAttributedLabel
    _attributedLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectZero];
    _attributedLabel.delegate = self;
    [self.view addSubview:self.attributedLabel];
    [self.attributedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_lessThanOrEqualTo(460);
    }];
    
    //2.Html转化富文本
    NSData *data = [self.html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
    
    //3.计算Frame
    //预设一个最大的Frame,限宽不限高，方便以后计算布局
    _viewMaxRect = CGRectMake(0, 0, 320 - 15*2, CGFLOAT_HEIGHT_UNKNOWN);
    DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:attributedString];
    NSRange entireStringRange = NSMakeRange(0, [attributedString length]);
    DTCoreTextLayoutFrame *layoutFrame = [layouter layoutFrameWithRect:_viewMaxRect range:entireStringRange];
    CGSize textSize = [layoutFrame frame].size;
    self.attributedLabel.frame = CGRectMake(_viewMaxRect.origin.x, _viewMaxRect.origin.y, _viewMaxRect.size.width, textSize.height);
    
    //4.设置富文本
    self.attributedLabel.attributedString = attributedString;
}

#pragma mark - Private
#pragma mark - private Methods
//使用得到的新图片尺寸，更新HtmlString字符串
- (void)configNoSizeImageView:(NSString *)url size:(CGSize)size{
    //_viewMaxRect是预设的最大Frame
    CGFloat imgSizeScale = size.height/size.width;
    CGFloat widthPx = _viewMaxRect.size.width;
    CGFloat heightPx = widthPx * imgSizeScale;
    NSString *imageInfo = [NSString stringWithFormat:@"_src=\"%@\"",url];
    NSString *sizeString = [NSString stringWithFormat:@"style=\"width:%.fpx; height:%.fpx;\"",widthPx,heightPx];
    NSString *newImageInfo = [NSString stringWithFormat:@"_src=\"%@\"%@",url,sizeString];
    if ([self.html containsString:imageInfo]) {
        NSString *newHtml = [self.html stringByReplacingOccurrencesOfString:imageInfo withString:newImageInfo];
        self.html = newHtml;
    }
}

//使用HtmlString,和预设的Frame，计算富文本视图自适应后的高度
- (CGSize)getAttributedTextHeightHtml:(NSString *)htmlString with_viewMaxRect:(CGRect)_viewMaxRect{
    //获取富文本
    NSAttributedString *attributedString =  [self getAttributedStringWithHtml:htmlString];
    //获取布局器
    DTCoreTextLayouter *layouter = [[DTCoreTextLayouter alloc] initWithAttributedString:attributedString];
    NSRange entireString = NSMakeRange(0, [attributedString length]);
    //获取Frame
    DTCoreTextLayoutFrame *layoutFrame = [layouter layoutFrameWithRect:_viewMaxRect range:entireString];
    //得到大小
    CGSize sizeNeeded = [layoutFrame frame].size;
    return sizeNeeded;
}

//Html->富文本NSAttributedString
- (NSAttributedString *)getAttributedStringWithHtml:(NSString *)htmlString {
    //获取富文本
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
    return attributedString;
}

#pragma mark - DTAttributedTextContentViewDelegate
//DTCoretText在解析Html的时候，如果遇到网络图片会插入一个占位符
//对于图片类型(DTImageTextAttachmentd)的占位符，我们使用DTLazyImageView来显示
- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame {
    
    if([attachment isKindOfClass:[DTImageTextAttachment class]]) {
        NSString *imageURL = [NSString stringWithFormat:@"%@", attachment.contentURL];
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;//图片懒加载代理
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [(DTImageTextAttachment *)attachment image];
        imageView.url = attachment.contentURL;
        
        //处理gif图片
        if ([imageURL containsString:@"gif"]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *gifData = [NSData dataWithContentsOfURL:attachment.contentURL];
                dispatch_async(dispatch_get_main_queue(), ^{
//                    imageView.image = DTAnimatedGIFFromData(gifData);
                });
            });
        }
        return imageView;
    }
    return nil;
}

#pragma mark  Delegate：DTLazyImageViewDelegate
//懒加载图片代理
- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    NSURL *url = lazyImageView.url;
    CGSize imageSize = size;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    BOOL didUpdate = NO;
    
    //update all attachments that match this URL (possibly multiple images with same size)
    //更新所有匹配URL的占位符视图
    for (DTTextAttachment *oneAttachment in [self.attributedLabel.layoutFrame textAttachmentsWithPredicate:pred]){
        //update attachments that have no original size, that also sets the display size
        //更新没有自带尺寸的占位视图(如网络图片)
        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero)){
            //原始图片不带宽高，被识别后修改Html
            oneAttachment.originalSize = imageSize;
            //使用新拿到的图片尺寸更新HTML字符串
            [self configNoSizeImageView:url.absoluteString size:imageSize];
            didUpdate = YES;
        }
    }
    if (didUpdate){
        //重新显示富文本
        CGSize textSize = [self getAttributedTextHeightHtml:self.html with_viewMaxRect:_viewMaxRect];
        self.attributedLabel.frame = CGRectMake(_viewMaxRect.origin.x, _viewMaxRect.origin.y, _viewMaxRect.size.width, textSize.height);
        self.attributedLabel.attributedString = [self getAttributedStringWithHtml:self.html];
        self.attributedLabel.layouter = nil;
        [self.attributedLabel relayoutText];
    }
}

#pragma mark - LazyLoad

#pragma mark - Network

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
