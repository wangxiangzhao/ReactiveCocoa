//
//  WXZSubjectUsedScene.h
//  ReactiveCocoa
//
//  Created by 王向召 on 2019/8/6.
//  Copyright © 2019 王向召. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXZSubjectUsedScene : UIViewController


@end

@interface WXZSubjectUsedScene1 : UIViewController

@property (nonatomic, strong) RACSubject *subject;

@end

NS_ASSUME_NONNULL_END
