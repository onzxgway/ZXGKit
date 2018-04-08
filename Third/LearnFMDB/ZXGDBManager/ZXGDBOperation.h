//
//  ZXGDBOperation.h
//  LearnFMDB
//
//  Created by 朱献国 on 2018/4/8.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXGDBCRUDCondition.h"

@interface ZXGDBOperation : NSObject

/** 数据库路径*/
@property (nonatomic, copy  , readonly) NSString *dbPath;

/** <#备注#>*/
@property (nonatomic, strong) ZXGDBCRUDCondition *actionCondition;

/** 操作失败回调*/
@property (nonatomic, copy  ) ZXGDBOperationFailBlock failCallback;

/** <#备注#>*/
@property (nonatomic, copy  ) ZXGDBOperationUpdateSuccessBlock updateSuccessCallback;

/** <#备注#>*/
@property (nonatomic, copy  ) ZXGDBOperationQuerySuccessBlock querySuccessCallback;

@end
