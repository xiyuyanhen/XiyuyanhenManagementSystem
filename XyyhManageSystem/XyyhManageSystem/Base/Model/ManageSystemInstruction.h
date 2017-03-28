//
//  ManageSystemInstruction.h
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/28.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageSystemInstruction : NSObject

@property (nonatomic, strong) NSString * instructionId;
@property (nonatomic, strong) NSString * instructionPurpose;
@property (nonatomic, strong) NSDate   * instructionCreateDate;
@property (nonatomic, strong) NSDate   * instructionBeginDate;
@property (nonatomic, strong) NSDate   * instructionOverDate;
@property (nonatomic, strong) NSString * instructionStatus;

@end
