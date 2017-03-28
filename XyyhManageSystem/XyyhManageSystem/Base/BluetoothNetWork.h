//
//  BluetoothNetWork.h
//  DragonPassCn
//
//  Created by XGTDEV1 on 16/4/20.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetWork.h"
@interface BluetoothNetWork : BaseNetWork


+(instancetype) defaultUtil;

-(void)bluetoothSendInfo:(id)parameters
               success:(void(^)(id responseObject))success
               failure:(void(^)(NSError *error))failure;



@end
