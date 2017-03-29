//
//  XyyHBmobTools.m
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/28.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import "XyyHBmobTools.h"

@implementation XyyHBmobTools


//添加一行数据
- (BmobObject *)bmobAddDataWithClassName:(NSString *)className object:(id)object forKey:(NSString *)key resultBlock:(void(^)(BOOL isSuccessful, NSError *error))resultBlock{
    
    if(key==nil || key.length<=0 || object== nil){
        //若无需要保存的数据，跳过此次操作
        return nil;
    }
    
    NSDictionary * parameters = @{key:object};
    return [self bmobAddDataWithClassName:className parameters:parameters resultBlock:resultBlock];
}

//添加一组数据
- (BmobObject *)bmobAddDataWithClassName:(NSString *)className parameters:(NSDictionary *)parameters resultBlock:(void(^)(BOOL isSuccessful, NSError *error))resultBlock{
    
    if(!(className && className.length>0 && parameters && parameters.count>0)){
        //若无需要保存的数据，跳过此次操作
        return nil;
    }
    
    BmobObject * bmobObject = [BmobObject objectWithClassName:className];
    
    for(NSString * key in parameters){
    
        id object = parameters[key];
        
        if(object){
            
            [bmobObject setObject:object forKey:key];
        }
    }
    
    [bmobObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        //进行操作
        if(resultBlock){
            
            resultBlock(isSuccessful,error);
        }
    }];
    
    return bmobObject;
}

//匹配指定keyName的value值来查询数据
- (void)bmobSearchDataWithClassName:(NSString *)className forKeyName:(NSString *)keyName searchKey:(id)key resultBlock:(void(^)(NSArray *array, NSError *error))resultBlock{
    
    //查找表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:className];
    
    [bquery whereKey:keyName equalTo:key];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(resultBlock){
            
            resultBlock(array,error);
        }
    }];
}

//获取所有数据
- (void)bmobSearchDataWithClassName:(NSString *)className resultBlock:(void(^)(NSArray *array, NSError *error))resultBlock{
    
    //查找表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:className];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(resultBlock){
            
            resultBlock(array,error);
        }
    }];
}

//删除一行数据
- (void)bmobDeletDataWithClassName:(NSString *)className forKeyName:(NSString *)keyName searchKey:(id)key{
    
    //查找表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:className];
    
    [bquery whereKey:keyName equalTo:key];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(error==nil && array && array.count>0){
            
            for(BmobObject * object in array){
                
                [object deleteInBackground];
            }
        }
    }];
}



//修改数据
- (void)bmobChangeDataWithClassName:(NSString *)className forKeyName:(NSString *)keyName searchKey:(id)key changeKey:(NSString *)changeKey changeObject:(id)changeObject resultBlock:(void(^)(BOOL isSuccessful, NSError *error))resultBlock{
    
    //查找表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:className];
    
    [bquery whereKey:keyName equalTo:key];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(error==nil && array && array.count>0){
            
            for(BmobObject * object in array){
                
                
                BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:object.className objectId:object.objectId];
                //设置cheatMode为YES
                [obj1 setObject:changeObject forKey:changeKey];
                //异步更新数据
                [obj1 updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    
                    if(resultBlock){
                        
                        resultBlock(isSuccessful,error);
                    }
                    
                }];
            }
        }
    }];
}



@end
