//
//  WXZSubjectUsedScene.m
//  ReactiveCocoa
//
//  Created by 王向召 on 2019/8/6.
//  Copyright © 2019 王向召. All rights reserved.
//

#import "WXZSubjectUsedScene.h"

@implementation WXZSubjectUsedScene

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WXZSubjectUsedScene1 *viewController = [[WXZSubjectUsedScene1 alloc] init];
    viewController.subject = [RACSubject subject];
    [viewController.subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    [self presentViewController:viewController animated:YES completion:nil];
}

@end

@implementation WXZSubjectUsedScene1

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.subject) {
        [self.subject sendNext:@"我要消失了😭"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
