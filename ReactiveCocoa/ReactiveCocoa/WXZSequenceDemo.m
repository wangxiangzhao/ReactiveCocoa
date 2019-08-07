//
//  WXZSequenceDemo.m
//  ReactiveCocoa
//
//  Created by 王向召 on 2019/8/6.
//  Copyright © 2019 王向召. All rights reserved.
//

#import "WXZSequenceDemo.h"

@implementation WXZSequenceDemo

+ (void)SequenceDemo {
    //RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典。
    //RACTuple:元组类,类似NSArray,用来包装值.
    NSArray *numberArr = @[@"1", @"2", @"3", @"4", @"5"];
    [numberArr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"数组：%@", x);
    }];
    
    NSDictionary *dict = @{
                           @"key1" : @"value1",
                           @"key2" : @"value2",
                           @"key3" : @"value3",
                           };
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        //这里的 x 是一个RACTuble元组数据
//        NSLog(@"字典：%@", x);
    }];
    
    //应用场景  dict 和 model互换  利用map映射
    NSArray *modelDictArr = @[@{
                              @"name" : @"小李",
                              @"uid" : @"13",
                              },
                          @{
                              @"name" : @"小张",
                              @"uid" : @"220",
                              }
                          ];
    NSArray *modelArr = [[modelDictArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [WXZSequenceDemo modelFromJson:value];
    }] array];
    [modelArr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

+ (id)modelFromJson:(NSDictionary *)dict {
    WXZSequenceDemo *demo = [[WXZSequenceDemo alloc] init];
    demo.uid = [dict[@"uid"] integerValue];
    demo.name = dict[@"name"];
    return demo;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"id:%ld - name:%@", self.uid, self.name];
}

@end
