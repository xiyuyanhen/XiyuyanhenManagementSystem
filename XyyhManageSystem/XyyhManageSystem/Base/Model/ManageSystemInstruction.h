//
//  ManageSystemInstruction.h
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/28.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageSystemInstruction : NSObject

@property (nonatomic, strong) NSString * orderId;
@property (nonatomic, strong) NSString * user;
@property (nonatomic, strong) NSString * purpose;
@property (nonatomic, strong) NSDate   * createDate;
@property (nonatomic, strong) NSDate   * beginDate;
@property (nonatomic, strong) NSDate   * overDate;
@property (nonatomic, strong) NSString * status;

- (void)addInstructionToBmob:(void(^)(BOOL isSuccessful, NSError *error))resultBlock;

@end
