//
//  ZXGDynamicModel.h
//  Moments
//
//  Created by 朱献国 on 2018/4/12.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXGDynamicLocationModel : NSObject

/** 位置名称*/
@property (nonatomic, copy  ) NSString *name;

/** 位置详情*/
@property (nonatomic, copy  ) NSString *url;

@end

@interface ZXGDynamicModel : NSObject

@property (nonatomic, copy  ) NSString *userId;   //用户ID
//@property(nonatomic,strong)NSString * title;//动态页面标题
@property (nonatomic, copy  ) NSString *avatalUrl;//用户头像
@property (nonatomic, copy  ) NSString *nickName; //用户昵称
@property (nonatomic, copy  ) NSString *content;  //动态内容
@property (nonatomic, strong) NSNumber *createTime;  //动态时间

//@property(nonatomic,strong)NSString * thumb;//封面图
//@property(nonatomic,assign)int auditstatus;//是否打开微信分享(0:隐藏,1:开启)

//@property(nonatomic,strong)NSString * url;//动态页面链接
//@property(nonatomic,strong)NSString * compid;//公司ID
//@property(nonatomic,strong)NSString * background;//用户背景
//@property(nonatomic,strong)NSString * remark;//用户个性签名
//@property(nonatomic,strong)NSString * favorite;//该字段存在,则表示当前登录微赚宝用户已收藏过这个店铺

@property (nonatomic, strong) NSArray *images;  //配图集合
//@property (nonatomic, strong)NSArray *optthumb;//点赞数组
@property (nonatomic, strong) NSArray *comments;//评论集合
@property (nonatomic, strong) NSDictionary *locaionMsg; //位置信息
//@property(nonatomic,strong)NSDictionary * spreadparams;//推广内容
//@property(nonatomic,strong)NSMutableArray<DynamicsLikeItemModel *> * likeArr;//存放Model点赞数组
//@property(nonatomic,strong)NSMutableArray<DynamicsCommentItemModel *> * commentArr;//存放Model评论数组
//@property(nonatomic,strong)NSData * photocollectionsData;//照片数组(存入数据库)
//@property(nonatomic,assign)int pagetype;//动态类型(0:普通动态,1:头条动态)
//
//
//@property (nonatomic, assign) BOOL isOpening;//已展开文字
//@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;//应该显示"全文"
//@property(nonatomic,assign)BOOL isThumb;//已点赞

@end
