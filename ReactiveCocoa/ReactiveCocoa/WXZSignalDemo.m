//
//  WXZSignalDemo.m
//  ReactiveCocoa
//
//  Created by 王向召 on 2019/8/6.
//  Copyright © 2019 王向召. All rights reserved.
//

#import "WXZSignalDemo.h"

@implementation WXZSignalDemo

+ (RACSignal *)createSignal {
    //创建信号
    /*
     创建后是冷信号，只有订阅后才激活，变成热信号
     */
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //信号发送
        [subscriber sendNext:@"发送信号了"];
        //信号发送完成
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁了！！！");
            /*
             信号发送完成或者发送错误会自动调用
             */
        }];
    }];
}

//RACSubject 使用
+ (void)subjectDemo {
    /*
     RACSubject:信号提供者，自己可以充当信号，又能发送信号
     场景：通常用来替代代理
     特点：只能先订阅信号
     */
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    
    // RACSubject:底层实现和RACSignal不一样。
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。

    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
         NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第二个订阅者%@",x);
    }];
    // 3.发送信号
    [subject sendNext:@"subject demo"];
}

//RACReplaySubject 使用
+ (void)replaySubjectDemo {
    /*
     重复提供信号类，RACSubject的子类
     场景：信号每订阅一次，就需要把之前的值发送一遍；
          可以设置capacity数量来限制缓存的value的数量,即只缓充最新的几个值。
     特点：既可以先订阅，也可以先发送信号
     */
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。
    
    // 创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    //可以设置缓存值得个数，以最新为优先级；只对先发送后订阅有效
    //RACReplaySubject *replaySubject = [RACReplaySubject replaySubjectWithCapacity:1];
    
    // 先订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 发送信号
    [replaySubject sendNext:@"replaySubject  demo1"];
    [replaySubject sendNext:@"replaySubject  demo2"];
    
    // 后订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}

@end
