//
//  XyyHBmobTools.h
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/28.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface XyyHBmobTools : NSObject

//添加一行数据
- (BmobObject *)bmobAddDataWithClassName:(NSString *)className object:(id)object forKey:(NSString *)key resultBlock:(void(^)(BOOL isSuccessful, NSError *error))resultBlock;
//添加一组数据
- (BmobObject *)bmobAddDataWithClassName:(NSString *)className parameters:(NSDictionary *)parameters resultBlock:(void(^)(BOOL isSuccessful, NSError *error))resultBlock;
//匹配指定keyName的value值来查询数据
- (void)bmobSearchDataWithClassName:(NSString *)className forKeyName:(NSString *)keyName searchKey:(id)key resultBlock:(void(^)(NSArray *array, NSError *error))resultBlock;
//获取所有数据
- (void)bmobSearchDataWithClassName:(NSString *)className resultBlock:(void(^)(NSArray *array, NSError *error))resultBlock;
//删除一行数据
- (void)bmobDeletDataWithClassName:(NSString *)className forKeyName:(NSString *)keyName searchKey:(id)key;

//修改数据
- (void)bmobChangeDataWithClassName:(NSString *)className forKeyName:(NSString *)keyName searchKey:(id)key changeKey:(NSString *)changeKey changeObject:(id)changeObject resultBlock:(void(^)(BOOL isSuccessful, NSError *error))resultBlock;

@end
