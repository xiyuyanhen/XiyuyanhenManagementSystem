//
//  BluetoothManagement.m
//  DragonPassCn
//
//  Created by XGTDEV1 on 16/4/20.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "BluetoothManagement.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBCentralManager.h>
#import "BRTBeaconSDK.h"
#import "BluetoothNetWork.h"

@interface BluetoothManagement()<CBCentralManagerDelegate>


@property (nonatomic,strong) CBCentralManager     *cbCentralManager;
@property (nonatomic,strong) BRTBeacon            *brtBeacon;
//是否开启了扫描
@property (nonatomic,assign) BOOL               ranging;

@end


@implementation BluetoothManagement
+(instancetype) defaultUtil
{
    static BluetoothManagement * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[BluetoothManagement alloc] init];
    });
    
    return sharedInstance;
}

-(void)startCheckBlueState
{
    self.cbCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];

}
#pragma mark -- 蓝牙状态回调

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    //第一次打开或者每次蓝牙状态改变都会调用这个函数
    if(central.state==CBCentralManagerStatePoweredOn)
    {
        NSLog(@"蓝牙设备开着");
        [self bluetoothStartRanging];
        
    }else if(central.state==CBCentralManagerStatePoweredOff)
    {
        NSLog(@"蓝牙设备关着");
        if(self.ranging){
            [BRTBeaconSDK stopRangingBrightBeacons];

        }
        self.ranging = NO;
    }
}
#pragma mark -- 蓝牙开始扫描附近ibeancon
-(void)bluetoothStartRanging
{
    self.ranging = YES;
    WEAKSELF
    [BRTBeaconSDK registerApp:@"c233b1d1078247dfaf64fcde058d9a7a" onCompletion:^(BOOL complete, NSError* error){
        if(complete){
            
            
            
            //            BRTBeaconRegion *region = [[BRTBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"FDA50693A4E24FB1AFCFC6EB07647825"] identifier:@""];
            //            region.notifyOnEntry = YES;//监听进入区域
            //            region.notifyOnExit = YES;//监听离开区域
            //            region.notifyEntryStateOnDisplay = YES;//锁屏唤醒时监听
            //            [BRTBeaconSDK startMonitoringForRegions:@[region]];
        }
    }];
    
    
    
    [BRTBeaconSDK startRangingWithUuids:@[[[NSUUID alloc] initWithUUIDString:DEFAULT_UUID]]
                           onCompletion:^(NSArray* beacons, BRTBeaconRegion* region, NSError* error){
                                if (!error) {
                                    NSLog(@"%@",beacons);
                                    
                                    
                                    if([beacons count] == 0) return ;
                                    
                                   NSArray *scorteBeaconList =  [beacons sortedArrayUsingComparator:^NSComparisonResult(BRTBeacon* obj1, BRTBeacon* obj2){
                                       return obj1.distance.floatValue>obj2.distance.floatValue?NSOrderedDescending:NSOrderedAscending;
                                   }];
                                   
                                   weakSelf_SC.brtBeacon =[scorteBeaconList objectAtIndex:0];

                                   NSDate *nowDate = [NSDate date];
                                   NSDate *sendDeviceTime = (NSDate*)[[XGTUtil AppCache] objectForKey:@"sendDeviceTime"];
                                   NSString *sendMajor = (NSString*)[[XGTUtil AppCache] objectForKey:@"major"];
                                   NSString *sendMinjor = (NSString*)[[XGTUtil AppCache] objectForKey:@"minor"];
                                    //60*60*2
                                    if( [sendMajor intValue] != [weakSelf_SC.brtBeacon.major intValue] && [sendMinjor intValue] != [weakSelf_SC.brtBeacon.minor intValue]){
                                        NSLog(@"与上次发送的设备不相同 ========= ");
                                        
                                        [self sendDeviceInfo];
                                        
                                    }else{
                                        //与上次发送的设备相同
                                        NSLog(@"与上次发送的设备相同");
                                        if(sendDeviceTime != nil && [nowDate timeIntervalSinceDate:sendDeviceTime] > 30){
                                            
                                            //距离上次设备发送没超过两小时
                                            NSLog(@"距离上次设备发送超过两小时  ======= ");
                                            [self sendDeviceInfo];
                                            
                                        }else{
                                            
                                            NSLog(@"距离上次设备发送没超过两小时");
                                            
                                        }
                                    }
 
                                    nowDate = nil;
                                    sendDeviceTime = nil;
                                    
                                }
                               
//                               weakSelf_SC.brtBeacon = nil;
                            
                           }];
    


}
#pragma mark -- 发送设备信息
-(void)sendDeviceInfo
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *nowDate = [NSDate date];
 
    NSLog(@"%@",@{
                      @"userId":[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_info"] objectForKey:@"userId"]],
                      @"sessionId":[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_info"] objectForKey:@"userId"]],
                      @"major":[NSString stringWithFormat:@"%@",self.brtBeacon.major],
                      @"minor":[NSString stringWithFormat:@"%@",self.brtBeacon.minor],
                      @"time":[formatter stringFromDate:nowDate]
                      });
    
//    [[BluetoothNetWork defaultUtil] bluetoothSendInfo:@{
//                                                        @"userId":[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_info"] objectForKey:@"userId"]],
//                                                        @"sessionId":[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"user_info"] objectForKey:@"userId"]],
//                                                        @"major":[NSString stringWithFormat:@"%@",self.brtBeacon.major],
//                                                        @"minor":[NSString stringWithFormat:@"%@",self.brtBeacon.minor],
//                                                        @"time":[formatter stringFromDate:nowDate]
//                                                        }
//                                              success:^(id responseObject){
//                                                  NSLog(@"结果 ===== %@",responseObject);
//                                                  
//                                                  if(responseObject != nil && [@"11" isEqualToString:[responseObject objectForKeyWithoutNull:@"state"]]){
//                                                      [[XGTUtil AppCache] setObject:nowDate forKey:@"sendDeviceTime"];
//                                                      [[XGTUtil AppCache]  setObject:[NSString stringWithFormat:@"%d",[self.brtBeacon.major intValue]] forKey:@"major"];
//                                                      [[XGTUtil AppCache] setObject:[NSString stringWithFormat:@"%d",[self.brtBeacon.minor intValue]] forKey:@"minor"];
//                                                  }
//                                                  
//                                               
//                                                  
//                                                  
//                                              }
//                                              failure:^(NSError *eroor){
//                                                  
//                                              }];
//    
    
    

}

@end
