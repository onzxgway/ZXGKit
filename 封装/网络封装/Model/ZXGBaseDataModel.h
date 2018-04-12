//
//  ZXGBaseDataModel.h
//  网络封装
//
//  Created by 朱献国 on 2018/4/11.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import "ZXGBaseModel.h"

@interface ZXGBaseDataModel : ZXGBaseModel

//状态
@property (nonatomic, assign) NSInteger status;
//信息
@property (nonatomic, copy  ) NSString *errorMsg;
//服务器时间戳
@property (nonatomic, assign) long long timeStamp;

@end
