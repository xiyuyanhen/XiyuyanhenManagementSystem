//
//  BluetoothManagement.h
//  DragonPassCn
//
//  Created by XGTDEV1 on 16/4/20.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BluetoothManagement : NSObject

+(instancetype) defaultUtil;
/**
 *   检查蓝牙是否开启
 */
-(void)startCheckBlueState;



@end
