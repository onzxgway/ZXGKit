//
//  ZXGJSAndOCInterObject.h
//  OCAndJS
//
//  Created by 朱献国 on 2018/4/19.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZXGServiceDelegate <NSObject>

@optional

- (void)calculateWithNumber:(NSNumber *)number;

- (void)pushViewController:(NSString *)view title:(NSString *)title;

@end

@protocol ZXGJSExport <JSExport>

/**下列方法和前端共同协定*/

- (NSString *)getData;

- (void)pushViewController:(NSString *)view title:(NSString *)title;

/** calculateWithNumber 作为js方法的别名 */
JSExportAs(calculateForJS, - (void)calculateWithNumber:(NSNumber *)number);

@end

@interface ZXGJSAndOCCallObject : NSObject <ZXGJSExport>

@property (nonatomic, weak) id<ZXGServiceDelegate> delegate;

@end
