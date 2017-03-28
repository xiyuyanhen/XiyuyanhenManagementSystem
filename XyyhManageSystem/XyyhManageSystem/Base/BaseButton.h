//
//  BaseButton.h
//  DragonPassEn
//
//  Created by Dragonpass on 16/11/21.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_OPTIONS(NSUInteger, UIControlState) {
//    UIControlStateNormal       = 0,
//    UIControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
//    UIControlStateDisabled     = 1 << 1,
//    UIControlStateSelected     = 1 << 2,                  // flag usable by app (see below)
//    UIControlStateFocused NS_ENUM_AVAILABLE_IOS(9_0) = 1 << 3, // Applicable only when the screen supports focus
//    UIControlStateApplication  = 0x00FF0000,              // additional flags available for application use
//    UIControlStateReserved     = 0xFF000000               // flags reserved for internal framework use
//};



typedef NS_OPTIONS(NSUInteger, CustomControlState) {
    
    CustomControlStateNormal              = UIControlStateNormal,       //0x00000000
    CustomControlStateHighlighted         = UIControlStateHighlighted,  //0x00000001
    CustomControlStateDisabled            = UIControlStateDisabled,     //0x00000002
    CustomControlStateSelected            = UIControlStateSelected,     //0x00000004
    CustomControlStateFocused             = UIControlStateFocused,      //0x00000008
    CustomControlStateApplication         = UIControlStateApplication,  //0x00ff0000
    CustomControlStateReserved            = UIControlStateReserved,     //0xff000000
    
    /******************** CustomState *******************/
    CustomControlStateCancel              = 1 << 8,                     //0x00000100
    CustomControlStateCustom              = 1 << 9                      //0x00000200
};

typedef void(^HighlightedBlock)(CustomControlState state);

@interface BaseButton : UIButton

@property (nonatomic, assign) BOOL inversionEnable;  //能否反转

//当前button的state
@property (nonatomic, readonly) CustomControlState customState;

@property (nonatomic, strong) UIImageView * customImgView;
@property (nonatomic, strong) UILabel     * customTitleLabel;
@property (nonatomic, strong) UILabel     * customContentLabel;

+ (instancetype)createForHorizontalLayoutWithspace:(CGFloat)space;
+ (instancetype)createForTitleCenter;

- (void)setCustomTitle:(NSString *)title titileColor:(UIColor *)color image:(UIImage *)image forState:(CustomControlState)state;

- (void)setCustomImage:(UIImage *)image forState:(CustomControlState)state;
- (void)setCustomTitleColor:(UIColor *)color forState:(CustomControlState)state;
- (void)setCustomTitle:(NSString *)title forState:(CustomControlState)state;
- (void)setCustomContentColor:(UIColor *)color forState:(CustomControlState)state;
- (void)setCustomContentTitle:(NSString *)title forState:(CustomControlState)state;
- (void)setCustomBorderColor:(UIColor *)color forState:(CustomControlState)state;
- (void)setCustomBackgroundColor:(UIColor *)backgroundColor forState:(CustomControlState)state;

- (UIImage *)customImageForState:(CustomControlState)state;
- (NSString *)customTitleForState:(CustomControlState)state;
- (UIColor *)customTitleColorForState:(CustomControlState)state;
- (NSString *)customContentTitleForState:(CustomControlState)state;
- (UIColor *)customContentColorForState:(CustomControlState)state;
- (UIColor *)customBorderColorForState:(CustomControlState)state;
- (UIColor *)customBackgroundColorForState:(CustomControlState)state;

//根据state改变button显示的内容
- (void)setButtonWithState:(CustomControlState)state;
- (void)highlightedCompletedBlock:(HighlightedBlock)block;
//水平翻转
- (void)inversion;


@end
