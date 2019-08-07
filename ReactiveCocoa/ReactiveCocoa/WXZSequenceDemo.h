//
//  WXZSequenceDemo.h
//  ReactiveCocoa
//
//  Created by 王向召 on 2019/8/6.
//  Copyright © 2019 王向召. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXZSequenceDemo : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *name;

+ (void)SequenceDemo;

+ (id)modelFromJson:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
