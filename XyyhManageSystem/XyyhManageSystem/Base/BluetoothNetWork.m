//
//  BluetoothNetWork.m
//  DragonPassCn
//
//  Created by XGTDEV1 on 16/4/20.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "BluetoothNetWork.h"

@implementation BluetoothNetWork

+(instancetype) defaultUtil
{
    static BluetoothNetWork * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[BluetoothNetWork alloc] init];
    });
    
    return sharedInstance;
}

-(void)bluetoothSendInfo:(id)parameters
                 success:(void(^)(id responseObject))success
                 failure:(void(^)(NSError *error))failure
{
    
    
//    [self POST:[NSString stringWithFormat:@"%@%@",ROOT_URLV5,BLUETOOTHSENDINFO]
//    parameters:parameters
//       success:success
//       failure:failure];
//    
    

    
    
    
}
@end
