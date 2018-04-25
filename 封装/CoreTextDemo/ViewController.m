//
//  ViewController.m
//  CoreTextDemo
//
//  Created by 朱献国 on 2018/4/23.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "CTDisplayView.h"
#import "CTFrameParser.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"
#import "ImageViewController.h"
#import "WebContentViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CTDisplayView *displayView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNotifications];
//    [self.displayView setLayerCornerRadius:16 andBorder:kRedColor width:1];
//    [self.displayView setLayerShadow:kBlueColor offset:CGSizeMake(16, 16) radius:6];
    
    /**
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor redColor];
    config.width = self.displayView.width;
    CoreTextData *data = [CTFrameParser parseContent:@"从明天起，做一个幸福的人 喂马，劈柴，周游世界 从明天起，关心粮食和蔬菜 我有一所房子，面朝大海，春暖花开 从明天起，和每一个亲人通信 告诉他们我的幸福 那幸福的闪电告诉我的 我将告诉每一个人 给每一条河每一座山取一个温暖的名字 陌生人，我也为你祝福 愿你有一个灿烂的前程 愿你有情人终成眷属 愿你在尘世获的幸福 我也愿面朝大海，春暖花开" config:config];
    self.displayView.data = data;
    self.displayView.height = data.height;
    self.displayView.backgroundColor = [UIColor yellowColor];
    */
    
    /**
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = self.displayView.width;
    config.textColor = kRedColor;
    NSString *content =
    @"从明天起，做一个幸福的人 喂马，劈柴，周游世界 从明天起，关心粮食和蔬菜 我有一所房子，面朝大海，春暖花开 从明天起，和每一个亲人通信 告诉他们我的幸福 那幸福的闪电告诉我的 我将告诉每一个人 给每一条河每一座山取一个温暖的名字 陌生人，我也为你祝福 愿你有一个灿烂的前程 愿你有情人终成眷属 愿你在尘世获的幸福 我也愿面朝大海，春暖花开";
    NSDictionary *attr = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:content
                                           attributes:attr];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:26] range:NSMakeRange(0, 15)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:kBlueColor range:NSMakeRange(0, 15)];
    CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString
                                                        config:config];
    self.displayView.data = data;
    self.displayView.height = data.height;
    self.displayView.backgroundColor = [UIColor yellowColor];
    */
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = self.displayView.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
    self.displayView.data = data;
    self.displayView.height = data.height;
    self.displayView.backgroundColor = [UIColor yellowColor];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePressed:)
                                                 name:CTDisplayViewImagePressedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkPressed:)
                                                 name:CTDisplayViewLinkPressedNotification object:nil];
}

- (void)imagePressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    CoreTextImageData *imageData = userInfo[@"imageData"];
    
    ImageViewController *vc = [[ImageViewController alloc] init];
    vc.image = [UIImage imageNamed:imageData.name];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)linkPressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    CoreTextLinkData *linkData = userInfo[@"linkData"];
    
    WebContentViewController *vc = [[WebContentViewController alloc] init];
    vc.urlTitle = linkData.title;
    vc.url = linkData.url;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
