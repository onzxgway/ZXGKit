//
//  CTFrameParser.h
//  CoreTextDemo
//
//  Created by 朱献国 on 2018/4/24.
//  Copyright © 2018年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
#import "CTFrameParserConfig.h"

@interface CTFrameParser : NSObject

+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig*)config;

+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)attributedContent config:(CTFrameParserConfig*)config;

+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;

@end
