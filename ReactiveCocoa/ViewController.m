//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by 王向召 on 2019/8/6.
//  Copyright © 2019 王向召. All rights reserved.
//

#import "ViewController.h"
#import "WXZSubjectUsedScene.h"
#import "WXZSequenceDemo.h"
#import "WXZSignalDemo.h"
#import "WXZCommandDemo.h"
#import "WXZOtherDemo.h"

@interface ViewController ()

@property (nonatomic, strong) RACSignal *signal;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[WXZSignalDemo createSignal] subscribeNext:^(id  _Nullable x) {
//
//    }];
    
//    [WXZSignalDemo subjectDemo];
//    [WXZSignalDemo replaySubjectDemo];
//    [WXZSequenceDemo SequenceDemo];
//    [WXZCommandDemo commandDemo];
    [WXZOtherDemo otherDemo];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    WXZSubjectUsedScene *viewController = [[WXZSubjectUsedScene alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

@end
