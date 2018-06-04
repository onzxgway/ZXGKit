//
//  ViewController.m
//  LearnMasonry
//
//  Created by 朱献国 on 2018/6/4.
//  Copyright © 2018年 feizhu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// ----
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sTS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tTS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tTF;

// ----
@property (weak, nonatomic) IBOutlet UIButton *first;
@property (weak, nonatomic) IBOutlet UIButton *second;
@property (weak, nonatomic) IBOutlet UIButton *third;

// ----
@property (weak, nonatomic) IBOutlet UIButton *hiddenF;
@property (weak, nonatomic) IBOutlet UIButton *hiddenS;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.hiddenF addTarget:self action:@selector(fClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.hiddenS addTarget:self action:@selector(sClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)fClicked {
    self.first.hidden = !self.first.isHidden;
    if (self.first.hidden) {
        self.sTF.priority = 888;
        self.sTS.priority = 999;
    }
    else {
        self.sTF.priority = 999;
        self.sTS.priority = 888;
    }
}

- (void)sClicked {
    self.second.hidden = !self.second.isHidden;
    if (self.second.hidden) {
        self.tTS.priority = 888;
        self.tTF.priority = 999;
    }
    else {
        self.tTS.priority = 999;
        self.tTF.priority = 888;
    }
}

@end
