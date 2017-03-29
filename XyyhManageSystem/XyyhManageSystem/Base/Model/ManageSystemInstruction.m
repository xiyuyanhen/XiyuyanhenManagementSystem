//
//  ManageSystemInstruction.m
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/28.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import "ManageSystemInstruction.h"
#import "XyyHBmobTools.h"

@interface ManageSystemInstruction ()

@property (nonatomic, strong) NSString * className;
@end

@implementation ManageSystemInstruction

- (instancetype)init{
    
    self = [super init];
    
    if(self){
        
        self.className = @"SystemInstructions";
    }
    return self;
}

- (NSDictionary *)parametersFromObject{
    
    NSMutableDictionary * parameters = [NSMutableDictionary new];
    
    if(self.orderId && self.orderId.length>0){
        
        parameters[@"orderId"] = self.orderId;
    }
    
    if(self.user && self.user.length>0){
        
        parameters[@"user"] = self.user;
    }
    
    if(self.purpose && self.purpose.length>0){
        
        parameters[@"purpose"] = self.purpose;
    }
    
    if(self.createDate){
        
        parameters[@"createDate"] = self.createDate;
    }
    
    if(self.beginDate){
        
        parameters[@"beginDate"] = self.beginDate;
    }
    
    if(self.overDate){
        
        parameters[@"overDate"] = self.overDate;
    }
    
    if(self.status && self.status.length>0){
        
        parameters[@"status"] = self.status;
    }
    
    return parameters;
}

- (void)addInstructionToBmob:(void(^)(BOOL isSuccessful, NSError *error))resultBlock{
    
    XyyHBmobTools * tool = [[XyyHBmobTools alloc] init];
    
    [tool bmobAddDataWithClassName:self.className parameters:[self parametersFromObject] resultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if(resultBlock){
            
            resultBlock(isSuccessful,error);
        }
    }];
}

- (void)getInstructionFromBmob{
    
    XyyHBmobTools * tool = [[XyyHBmobTools alloc] init];
    
    
}


@end
