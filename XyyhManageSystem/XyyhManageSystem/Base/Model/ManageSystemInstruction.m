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


@end

@implementation ManageSystemInstruction

static NSString * className = @"SystemInstructions";

- (instancetype)init{
    
    self = [super init];
    
    if(self){
        
        self.user = @"xiyuyanhen";
    }
    return self;
}

+ (instancetype)createByBmobObject:(BmobObject *)object{
    
    ManageSystemInstruction * instruction = [[ManageSystemInstruction alloc] init];
    
    instruction.orderId    = [object objectForKey:@"orderId"];
    instruction.user       = [object objectForKey:@"user"];
    instruction.purpose    = [object objectForKey:@"purpose"];
    instruction.createDate = [object objectForKey:@"createDate"];
    instruction.beginDate  = [object objectForKey:@"beginDate"];
    instruction.overDate   = [object objectForKey:@"overDate"];
    instruction.status     = [object objectForKey:@"status"];
    
    return instruction;
}

- (NSString *)className{
    
    return className;
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

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    
    return [formatter stringFromDate:date];
}

- (NSDate *)dateFromString:(NSString *)string{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    
    return [formatter dateFromString:string];
}

- (void)setupInstructionFromBmobObject:(BmobObject *)object{
    
    self.orderId    = [object objectForKey:@"orderId"];
    self.user       = [object objectForKey:@"user"];
    self.purpose    = [object objectForKey:@"purpose"];
    self.createDate = [object objectForKey:@"createDate"];
    self.beginDate  = [object objectForKey:@"beginDate"];
    self.overDate   = [object objectForKey:@"overDate"];
    self.status     = [object objectForKey:@"status"];
    
}

- (void)addInstructionToBmob:(void(^)(BOOL isSuccessful, NSError *error))resultBlock{
    
    XyyHBmobTools * tool = [[XyyHBmobTools alloc] init];
    
    [tool bmobAddDataWithClassName:className parameters:[self parametersFromObject] resultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if(resultBlock){
            
            resultBlock(isSuccessful,error);
        }
    }];
}

//获取指定user的所有Instruction
- (void)getUserInstructionFromBmob:(NSString *)user result:(void(^)(NSArray <ManageSystemInstruction *>*array, NSError *error))resultBlock{
    
    XyyHBmobTools * tool = [[XyyHBmobTools alloc] init];
    [tool bmobSearchDataWithClassName:className forKey:@"user" searchValue:self.user resultBlock:^(NSArray *array, NSError *error) {
        
        NSMutableArray * newArray = [NSMutableArray new];
        if(array && array.count>0){
            
            for(BmobObject * object in array){
                
                if([object.className isEqualToString:className]){
                    
                    ManageSystemInstruction * instruction = [ManageSystemInstruction createByBmobObject:object];
                    if(instruction){
                        
                        [newArray addObject:instruction];
                    }
                }
            }
        }
        
        NSArray * resultArray = [NSArray arrayWithArray:newArray.count>0?newArray:array];
        
        if(resultBlock){
            
            resultBlock(resultArray,error);
        }
    }];
}

//获取所有Instruction
- (void)getAllInstructionFromBmob:(void(^)(NSArray <ManageSystemInstruction *>*array, NSError *error))resultBlock{
    
    XyyHBmobTools * tool = [[XyyHBmobTools alloc] init];
    [tool bmobSearchDataWithClassName:className resultBlock:^(NSArray *array, NSError *error) {
        
        NSMutableArray * newArray = [NSMutableArray new];
        if(array && array.count>0){
            
            for(BmobObject * object in array){
                
                if([object.className isEqualToString:className]){
                    
                    ManageSystemInstruction * instruction = [ManageSystemInstruction createByBmobObject:object];
                    if(instruction){
                        
                        [newArray addObject:instruction];
                    }
                }
            }
        }
        
        NSArray * resultArray = [NSArray arrayWithArray:newArray.count>0?newArray:array];
        
        if(resultBlock){
            
            resultBlock(resultArray,error);
        }
    }];
}


@end
