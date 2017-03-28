//
//  BaseTextField.h
//  DragonPassEn
//
//  Created by Dragonpass on 16/11/25.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextField : UITextField

@property (nonatomic, strong) NSString * placeholderString;
@property (nonatomic, strong) UILabel  * placeholderStringLabel;

@end
