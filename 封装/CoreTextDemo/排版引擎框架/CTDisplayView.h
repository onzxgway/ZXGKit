//
//  CTDisplayView.h
//  CoreTextDemo
//
//  Created by 朱献国 on 2018/4/23.
//  Copyright © 2018 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"

extern NSString *const CTDisplayViewImagePressedNotification;
extern NSString *const CTDisplayViewLinkPressedNotification;

@interface CTDisplayView : UIView

@property (strong, nonatomic) CoreTextData * data;

@end
