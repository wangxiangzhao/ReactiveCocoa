//
//  WXZOtherDemo.m
//  ReactiveCocoa
//
//  Created by 王向召 on 2019/8/6.
//  Copyright © 2019 王向召. All rights reserved.
//

#import "WXZOtherDemo.h"
#import <ReactiveObjC/RACReturnSignal.h>

@implementation WXZOtherDemo

+ (void)otherDemo {
    
    RACSubject *subject1 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    //combineLatest 将信号打包成一个新的信号，必须打包的所有信号都成功的发送完信号后才能正常执行订阅后的代码块
//    [[RACSignal combineLatest:@[subject1, subject2]] subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    //reduce 聚合值 有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
//    [[RACSignal combineLatest:@[subject1, subject2] reduce:^id _Nullable(NSString *value1, NSString *value2){
//        return [NSString stringWithFormat:@"%@ ---- %@", value1, value2];
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    //merge将数组中的信号合并成一个信号，只要有任意一个信号发送完成，合并后的信号就能正常执行订阅后的代码块
//    [[RACSignal merge:@[subject1, subject2]] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    [subject1 sendNext:@"1"];
    [subject2 sendNext:@"2"];
    
   
    
    // 底层实现:
    // 1.定义压缩信号，内部就会自动订阅signalA，signalB
    // 2.每当signalA或者signalB发出信号，就会判断signalA，signalB有没有发出个信号，有就会把最近发出的信号都包装成元组发出。
    
   /*
    flattenMap：映射成一个新的信号
    Map：映射成新的值
    concat:按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号。
    then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号
    zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件
    filter:过滤信号，使用它可以获取满足条件的信号.
    ignore:忽略完某些值的信号.
    distinctUntilChanged:当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉。
    take:从开始一共取N次的信号
    takeLast:取最后N次的信号,前提条件，订阅者必须调用完成，因为只有完成，就知道总共有多少信号.
    takeUntil:(RACSignal *):获取信号直到某个信号执行完成
    skip:(NSUInteger):跳过几个信号,不接受。
    switchToLatest:用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号。
    doNext: 执行Next之前，会先执行这个Block
    doCompleted: 执行sendCompleted之前，会先执行这个Block
    
    deliverOn: 内容传递切换到指定线程中，副作用在原来线程中,把在创建信号时block中的代码称之为副作用。
    subscribeOn: 内容传递和副作用都会切换到指定线程中
    
    timeout：超时，可以让一个信号在一定的时间后，自动报错。
    interval 定时：每隔一段时间发出信号
    delay 延迟发送next
    retry重试 ：只要失败，就会重新执行创建信号中的block,直到成功.
    throttle节流:当某个信号发送比较频繁时，可以使用节流，在某一段时间不发送信号内容，过了一段时间获取信号的最新内容发出。
    
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@1];
    
    [subscriber sendCompleted];
    
    return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@2];
    
    return nil;
    }];
    
    // 把signalA拼接到signalB后，signalA发送完成，signalB才会被激活。
    RACSignal *concatSignal = [signalA concat:signalB];
    
    // 以后只需要面对拼接信号开发。
    // 订阅拼接的信号，不需要单独订阅signalA，signalB
    // 内部会自动订阅。
    // 注意：第一个信号必须发送完成，第二个信号才会被激活
    [concatSignal subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
    
    }];
    
    // then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号
    // 注意使用then，之前信号的值会被忽略掉.
    // 底层实现：1、先过滤掉之前的信号发出的值。2.使用concat连接then返回的信号
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@1];
    [subscriber sendCompleted];
    return nil;
    }] then:^RACSignal *{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [subscriber sendNext:@2];
    return nil;
    }];
    }] subscribeNext:^(id x) {
    
    // 只能接收到第二个信号的值，也就是then返回信号的值
    NSLog(@"%@",x);
    }];
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@1];
    
    
    return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@2];
    
    return nil;
    }];
    
    
    
    // 压缩信号A，信号B
    RACSignal *zipSignal = [signalA zipWith:signalB];
    
    [zipSignal subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
    }];
    
    // 1.代替代理
    // 需求：自定义redView,监听红色view中按钮点击
    // 之前都是需要通过代理监听，给红色View添加一个代理属性，点击按钮的时候，通知代理做事情
    // rac_signalForSelector:把调用某个对象的方法的信息转换成信号，就要调用这个方法，就会发送信号。
    // 这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
    [[redV rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
    NSLog(@"点击红色按钮");
    }];
    
    // 2.KVO
    // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
    // observer:可以传入nil
    [[redV rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
    
    }];
    
    // 3.监听事件
    // 把按钮点击事件转换为信号，点击按钮，就会发送信号
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    
    NSLog(@"按钮被点击了");
    }];
    
    // 4.代替通知
    // 把监听到的通知转换信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
    NSLog(@"键盘弹出");
    }];
    
    // 5.监听文本框的文字改变
    [_textField.rac_textSignal subscribeNext:^(id x) {
    
    NSLog(@"文字改变了%@",x);
    }];
    
    // 6.处理多个请求，都返回结果的时候，统一做处理.
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    // 发送请求1
    [subscriber sendNext:@"发送请求1"];
    return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    // 发送请求2
    [subscriber sendNext:@"发送请求2"];
    return nil;
    }];
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
    
    
    }
    // 更新UI
    - (void)updateUIWithR1:(id)data r2:(id)data1
    {
    NSLog(@"更新UI%@  %@",data,data1);
    }
    */
}

@end
