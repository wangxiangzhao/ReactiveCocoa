//
//  WXZSignalDemo.h
//  ReactiveCocoa
//
//  Created by 王向召 on 2019/8/6.
//  Copyright © 2019 王向召. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXZSignalDemo : NSObject

//创建信号
+ (RACSignal *)createSignal;

//RACSubject 使用
+ (void)subjectDemo;

//RACReplaySubject 使用
+ (void)replaySubjectDemo;


@end

NS_ASSUME_NONNULL_END
