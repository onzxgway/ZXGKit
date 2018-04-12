//
//  ZXGMomentsController.m
//  ProjectDemo
//
//  Created by 朱献国 on 2018/4/12.
//Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGMomentsController.h"
#import "ZXGDynamicModel.h"
#import "ZXGMomentsView.h"
#import "ZXGMomentsLayout.h"

@interface ZXGMomentsController ()
@property (nonatomic, strong) ZXGMomentsView *momentsView;
@property (nonatomic, strong) NSMutableArray<ZXGMomentsLayout *> *momentsModels;
@end

@implementation ZXGMomentsController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化视图
    [self moments_InitView];
    
    [self getResourece];
}

#pragma mark - Init
//初始化视图
- (void)moments_InitView {
    //
    self.navigationItem.title = @"朋友圈";
    //
    [self.view addSubview:self.momentsView];
    [self.momentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
//    //
//    self.dynamicView.mj_header = [MJRefreshHelper MMHeaderWithTarget:self Action:@selector(headerRefresh)];
//    self.dynamicView.mj_footer = [MJRefreshHelper MMFooterWithTarget:self Action:@selector(footerRefresh)];
//    [self.dynamicView.mj_header beginRefreshing];
//
//    //
//    [self rightBarButtonItem:GET_IMAGE(@"icon_fabu") withClickCallback:^{
//
//        [self.view endEditing:YES];
//        if (STRING_EQUAL(@"Y", XVDataMgr.userSession.isAnchor)) {
//
//            IBActionSheet *actionSheet = [[IBActionSheet alloc] initWithTitle:@"发布动态" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"选择照片" otherButtonTitles:@"选择视频", nil];
//            [actionSheet showInView:APPDELEGATE.window];
//        }
//        else if (STRING_EQUAL(@"N", XVDataMgr.userSession.isAnchor)) {
//            [self showRemendWarningView:@"非主播不能发布动态" withBlock:nil];
//        }
//
//    }];
//    //
//    [self.view addSubview:self.inputToolbar];
}

#pragma mark - createViews
#pragma mark - private
- (void)getResourece {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"moment0" ofType:@"plist"];
        NSArray *sourceArr = [NSArray arrayWithContentsOfFile:plistPath];
        sourceArr = [NSArray modelArrayWithClass:ZXGDynamicModel.class json:sourceArr];
        
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:sourceArr.count];
        for (ZXGDynamicModel *model in sourceArr) {
            ZXGMomentsLayout *layout = [[ZXGMomentsLayout alloc] initWithMoments:model];
            [tempArr addObject:layout];
        }
        
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"%@", sourceArr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.momentsModels removeAllObjects];
            
            [self.momentsModels addObjectsFromArray:tempArr];
            
            [self.momentsView reloadData];
        });
    });
    
    
}

#pragma mark - public
#pragma mark - lazyLoad
- (ZXGMomentsView *)momentsView {
    if (!_momentsView) {
        _momentsView = [[ZXGMomentsView alloc] init];
        _momentsView.momentModels = self.momentsModels;
    }
    return _momentsView;
}

- (NSMutableArray<ZXGMomentsLayout *> *)momentsModels {
    if (!_momentsModels) {
        _momentsModels = [NSMutableArray array];
    }
    return _momentsModels;
}

@end
