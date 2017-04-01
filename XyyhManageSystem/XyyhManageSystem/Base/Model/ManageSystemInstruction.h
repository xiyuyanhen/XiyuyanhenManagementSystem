//
//  ManageSystemInstruction.h
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/28.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageSystemInstruction : NSObject

@property (nonatomic, strong, readonly) NSString * className;
@property (nonatomic, strong) NSString * orderId;
@property (nonatomic, strong) NSString * user;
@property (nonatomic, strong) NSString * purpose;
@property (nonatomic, strong) NSDate   * createDate;
@property (nonatomic, strong) NSDate   * beginDate;
@property (nonatomic, strong) NSDate   * overDate;
@property (nonatomic, strong) NSString * status;

- (NSString *)stringFromDate:(NSDate *)date;

- (NSDate *)dateFromString:(NSString *)string;

- (void)addInstructionToBmob:(void(^)(BOOL isSuccessful, NSError *error))resultBlock;

//获取指定user的所有Instruction
- (void)getUserInstructionFromBmob:(NSString *)user result:(void(^)(NSArray <ManageSystemInstruction *>*array, NSError *error))resultBlock;
//获取所有Instruction
- (void)getAllInstructionFromBmob:(void(^)(NSArray <ManageSystemInstruction *>*array, NSError *error))resultBlock;

@end
