//
//  BaseButton.m
//  DragonPassEn
//
//  Created by Dragonpass on 16/11/21.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "BaseButton.h"

@interface BaseButton ()

@property (nonatomic,assign) BOOL isRotated;

//当前自定义状态
@property (nonatomic, assign) CustomControlState cState;
@property (nonatomic, copy  ) HighlightedBlock hightlightedBlock;

//保存动态发生前button的state
@property (nonatomic, assign) CustomControlState tempState;

@property (nonatomic, strong) UIImageView * backgroundImgView;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *,UIColor *> *
    customBackgroundColorDictionary;  //backgroundColor
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,UIImage *> * customImageDictionary;            //images
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,UIColor *> * customBorderColorDictionary;      //borderColors
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,UIColor *> * customTitleColorDictionary;       //title字体颜色
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,NSString *> * customTitleDictionary;            //title.text
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,UIColor *> * customContentColorDictionary;     //content字体颜色
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,NSString *> * customContentTitleDictionary;     //content.text

@end

@implementation BaseButton

+ (instancetype)createForHorizontalLayoutWithspace:(CGFloat)space{
    
    BaseButton * button = [BaseButton newAutoLayoutView];
    
    [button layoutWithHorizontalWithspace:space];
    
    return button;
}

+ (instancetype)createForTitleCenter{
    
    BaseButton * button = [BaseButton newAutoLayoutView];
    
    [button.customTitleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:button];
    [button.customTitleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:button];
    
    return button;
}

- (instancetype)init{
    
    self = [super init];
    if(self){
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //    if(_inversionEnable && !_isRotated){
    //
    //        //反转
    //        [self inversion];
    //        _isRotated = YES;
    //    }
    
}

- (CustomControlState)customState{
    
    return _cState;
}

- (void)layoutWithHorizontalWithspace:(CGFloat)space{
    
    [self.customImgView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.customImgView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self withOffset:0];
    
    [self.customTitleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.customTitleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.customImgView withOffset:space];
    [self.customTitleLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self withOffset:0];
    [self.customTitleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-10];
}

//水平翻转
- (void)inversion{
    
    self.transform = CGAffineTransformScale(self.transform , -1.0, 1.0);
    
}

- (void)setCustomTitle:(NSString *)title titileColor:(UIColor *)color image:(UIImage *)image forState:(CustomControlState)state{
    
    [self setCustomTitle:title forState:state];
    [self setCustomTitleColor:color forState:state];
    [self setCustomImage:image forState:state];
}


#pragma mark - customBackgroundColor
#pragma mark -

- (void)setCustomBackgroundColor:(UIColor *)backgroundColor forState:(CustomControlState)state{
    
    if(!backgroundColor){
        
        return;
    }
    
    if(!self.customBackgroundColorDictionary){
        
        self.customBackgroundColorDictionary = [NSMutableDictionary new];
    }
    
    if(state == CustomControlStateNormal){
        
        self.backgroundColor = backgroundColor;
    }
    
    for(NSNumber *num in self.customBackgroundColorDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            self.customBackgroundColorDictionary[num] = backgroundColor;
            
            //若state已经存在于字典中，直接return;
            return ;
        }
    }
    
    NSNumber *number = @(state);
    self.customBackgroundColorDictionary[number] = backgroundColor;
}

//获取指定state下的background的color
- (UIColor *)customBackgroundColorForState:(CustomControlState)state{
    
    if(!self.customBackgroundColorDictionary || self.customBackgroundColorDictionary.count==0){
        
        self.customBackgroundColorDictionary = [NSMutableDictionary new];
        //若customBorderColorDictionary为空，return nil;
        return nil;
    }
    
    for(NSNumber *num in self.customBackgroundColorDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            //找到对应state , return color
            return self.customBackgroundColorDictionary[num];
        }
    }
    
    //没有对应state，return nil;
    return nil;
}

//根据state改变background显示的内容
- (void)setCustomBackgroundColorWithState:(CustomControlState)state{
    
    //change image
    for(NSNumber *num in self.customBackgroundColorDictionary){
        
        CustomControlState s = [num integerValue];
        UIColor * color = self.customBackgroundColorDictionary[num];
        
        if(s == state && color){
            
            self.backgroundColor = color;
            break;
        }
    }
}



//- (UIImage *)imageWithColor:(UIColor *)color {
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}

#pragma mark - customImgView相关
#pragma mark -
//按state设置imageView
- (void)setCustomImage:(UIImage *)image forState:(CustomControlState)state{
    
    if(!image){
        
        return;
    }
    
    if(!self.customImageDictionary){
        
        self.customImageDictionary = [NSMutableDictionary new];
    }
    
    if(state == CustomControlStateNormal){
        
        self.customImgView.image = image;
    }
    
    for(NSNumber *num in self.customImageDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            self.customImageDictionary[num] = image;
            
            //若state已经存在于字典中，直接return;
            return ;
        }
    }
    
    NSNumber *number = @(state);
    self.customImageDictionary[number] = image;
}

//获取指定state下的imageView的image
- (UIImage *)customImageForState:(CustomControlState)state{
    
    if(!self.customImageDictionary || self.customImageDictionary.count<1){
        
        self.customImageDictionary = [NSMutableDictionary new];
        //若ImageDictionary为空，return nil;
        return nil;
    }

    for(NSNumber *num in self.customImageDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            //找到对应state , return Image
            return self.customImageDictionary[num];
        }
    }
    
    //没有对应state，return nil;
    return nil;
}

//根据state改变customImgView显示的内容
- (void)setCustomImageWithState:(CustomControlState)state{
    
    //change image
    for(NSNumber *num in self.customImageDictionary){
        
        CustomControlState s = [num integerValue];
        UIImage *image = self.customImageDictionary[num];
        
        if(s == state && image){
            
            self.customImgView.image = image;
            break;
        }
    }
}

#pragma mark - borderColor相关
#pragma mark -

//按state设置borderColor
- (void)setCustomBorderColor:(UIColor *)color forState:(CustomControlState)state{
    
    if(!color){
        
        return;
    }
    
    if(!self.customBorderColorDictionary){
        
        self.customBorderColorDictionary = [NSMutableDictionary new];
    }
    
    if(state == CustomControlStateNormal){
        
        self.layer.borderColor = [color CGColor];
    }
    
    for(NSNumber *num in self.customBorderColorDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            self.customBorderColorDictionary[num] = color;
            
            //若state已经存在于字典中，直接return;
            return ;
        }
    }
    
    NSNumber *number = @(state);
    self.customBorderColorDictionary[number] = color;
}

//获取指定state下的border的color
- (UIColor *)customBorderColorForState:(CustomControlState)state{
    
    if(!self.customBorderColorDictionary || self.customBorderColorDictionary.count==0){
        
        self.customBorderColorDictionary = [NSMutableDictionary new];
        //若customBorderColorDictionary为空，return nil;
        return nil;
    }
    
    for(NSNumber *num in self.customBorderColorDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            //找到对应state , return Image
            return self.customBorderColorDictionary[num];
        }
    }
    
    //没有对应state，return nil;
    return nil;
}

//根据state改变customImgView显示的内容
- (void)setCustomBorderColorWithState:(CustomControlState)state{
    
    //change image
    for(NSNumber *num in self.customBorderColorDictionary){
        
        CustomControlState s = [num integerValue];
        UIColor * color = self.customBorderColorDictionary[num];
        
        if(s == state && color){
            
            self.layer.borderColor = [color CGColor];
            break;
        }
    }
}

#pragma mark - customTitleLabel相关
#pragma mark -

//按state保存customTitleLabel 的 text
- (void)setCustomTitle:(NSString *)title forState:(CustomControlState)state{
    
    if(!title){
        
        return;
    }
    
    if(!self.customTitleDictionary){
        
        self.customTitleDictionary = [NSMutableDictionary new];
    }
    
    if(state == CustomControlStateNormal){
        
        self.customTitleLabel.text = title;
    }
    
    for(NSNumber *num in self.customTitleDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            self.customTitleDictionary[num] = title;
            
            return ;
        }
    }
    
    NSNumber *number = @(state);
    self.customTitleDictionary[number] = title;
}

//按state获取customTitleLabel 的 text
- (NSString *)customTitleForState:(CustomControlState)state{
    
    if(!self.customTitleDictionary || self.customTitleDictionary.count<1){
        
        self.customTitleDictionary = [NSMutableDictionary new];
        //若iconTitleForState为空，return nil;
        return nil;
    }
    
    for(NSNumber *num in self.customTitleDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            //找到对应state , return title
            return self.customTitleDictionary[num];
        }
    }
    
    //没有对应state，return nil;
    return nil;
}

//根据state改变customTitleLabel显示的内容
- (void)setCustomTitleWithState:(CustomControlState)state{
    //change title
    for(NSNumber *num in self.customTitleDictionary){
        
        CustomControlState s = [num integerValue];
        NSString * title = self.customTitleDictionary[num];
        
        if(s == state && title){
            
            self.customTitleLabel.text = title;
            break;
        }
    }
}

//按state保存customTitleLabel 的 Color
- (void)setCustomTitleColor:(UIColor *)color forState:(CustomControlState)state{
    
    if(!color){
        
        return;
    }
    
    if(!self.customTitleColorDictionary){
        
        self.customTitleColorDictionary = [NSMutableDictionary new];
    }
    
    if(state == CustomControlStateNormal){
        
        self.customTitleLabel.textColor = color;
    }
    
    //根据state
    for(NSNumber *num in self.customTitleColorDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            self.customTitleColorDictionary[num] = color;
            
            return ;
        }
    }
    
    NSNumber *number = @(state);
    self.customTitleColorDictionary[number] = color;
}

//按state获取customTitleLabel 的 Color
- (UIColor *)customTitleColorForState:(CustomControlState)state{
    
    if(!self.customTitleColorDictionary || self.customTitleColorDictionary.count<1){
        
        self.customTitleColorDictionary = [NSMutableDictionary new];
        //若customTitleColorDictionary为空，return nil;
        return nil;
    }
    
    for(NSNumber *num in self.customTitleColorDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            //找到对应state , return titleColor
            return self.customTitleColorDictionary[num];
        }
    }
    
    //没有对应state，return nil;
    return nil;
}

//根据state改变customTitleLabel 的 Color
- (void)setCustomTitleColorWithState:(CustomControlState)state{
    
    //change titleColor
    for(NSNumber *num in self.customTitleColorDictionary){
        
        CustomControlState s = [num integerValue];
        UIColor * color = self.customTitleColorDictionary[num];
        
        if(s == state && color){
            
            self.customTitleLabel.textColor = color;
            break;
        }
    }
}

#pragma mark - customContentLabel相关
#pragma mark -

//按state保存customContentLabel 的 text
- (void)setCustomContentTitle:(NSString *)title forState:(CustomControlState)state{
    
    if(!title){
        
        return;
    }
    
    if(!self.customContentTitleDictionary){
        
        self.customContentTitleDictionary = [NSMutableDictionary new];
    }
    
    if(state == CustomControlStateNormal){
        
        self.customContentLabel.text = title;
    }
    
    for(NSNumber *num in self.customContentTitleDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            self.customContentTitleDictionary[num] = title;
            
            return ;
        }
    }
    
    NSNumber *number = @(state);
    self.customContentTitleDictionary[number] = title;
}

//按state获取customContentLabel 的 text
- (NSString *)customContentTitleForState:(CustomControlState)state{
    
    if(!self.customContentTitleDictionary || self.customContentTitleDictionary.count<1){
        
        self.customContentTitleDictionary = [NSMutableDictionary new];
        //若iconTitleForState为空，return nil;
        return nil;
    }
    
    for(NSNumber *num in self.customContentTitleDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            //找到对应state , return title
            return self.customContentTitleDictionary[num];
        }
    }
    
    //没有对应state，return nil;
    return nil;
}

//根据state改变customContentColorDictionary显示的内容
- (void)setCustomContentTitleWithState:(CustomControlState)state{
    //change title
    for(NSNumber *num in self.customContentTitleDictionary){
        
        CustomControlState s = [num integerValue];
        NSString * title = self.customContentTitleDictionary[num];
        
        if(s == state && title){
            
            self.customContentLabel.text = title;
            break;
        }
    }
}

//按state保存customContentColorDictionary 的 Color
- (void)setCustomContentColor:(UIColor *)color forState:(CustomControlState)state{
    
    if(!color){
        
        return;
    }
    
    if(!self.customContentColorDictionary){
        
        self.customContentColorDictionary = [NSMutableDictionary new];
    }
    
    if(state == CustomControlStateNormal){
        
        self.customContentLabel.textColor = color;
    }
    
    //根据state
    for(NSNumber *num in self.customContentColorDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            self.customContentColorDictionary[num] = color;
            
            return ;
        }
    }
    
    NSNumber *number = @(state);
    self.customContentColorDictionary[number] = color;
}

//按state获取customContentColorDictionary 的 Color
- (UIColor *)customContentColorForState:(CustomControlState)state{
    
    if(!self.customContentColorDictionary || self.customContentColorDictionary.count<1){
        
        self.customContentColorDictionary = [NSMutableDictionary new];
        //若customContentColorDictionary为空，return nil;
        return nil;
    }
    
    for(NSNumber *num in self.customContentColorDictionary){
        
        CustomControlState s = [num integerValue];
        
        if(s == state){
            
            //找到对应state , return titleColor
            return self.customContentColorDictionary[num];
        }
    }
    
    //没有对应state，return nil;
    return nil;
}

//根据state改变iconContentColorLabel 的 Color
- (void)setCustomContentColorWithState:(CustomControlState)state{
    
    //change titleColor
    for(NSNumber *num in self.customContentColorDictionary){
        
        CustomControlState s = [num integerValue];
        UIColor * color = self.customContentColorDictionary[num];
        
        if(s == state && color){
            
            self.customContentLabel.textColor = color;
            break;
        }
    }
}


#pragma mark - button状态改变
#pragma mark -

//button触发时先执行 setHighlighted:YES --> 触发button代理的处理代码 --> setHighlighted:NO
//button状态改变   highlight-->normal
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
//    NSLog(@"state:%ld",self.state);
    
    if(self.state == UIControlStateHighlighted && highlighted){
        
        self.tempState = self.cState;
        [self setButtonWithState:(CustomControlState)self.state];
    }else{
        
        [self setButtonWithState:self.tempState];
        
        if(self.hightlightedBlock){
            
            self.hightlightedBlock((CustomControlState)self.cState);
        }
    }
    
}

- (void)highlightedCompletedBlock:(void (^)(CustomControlState))block{
    
    if(block){
        
        _hightlightedBlock = block;
    }
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    NSLog(@"state:%ld",self.state);
//    [self setButtonWithState:(CustomControlState)self.state];
    
    if(self.state == UIControlStateSelected && selected){
        
        self.tempState = self.cState;
        [self setButtonWithState:(CustomControlState)self.state];
    }else{
        
        [self setButtonWithState:self.tempState];
    }
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    [self setButtonWithState:(CustomControlState)self.state];
}

- (void)setButtonWithDynamicState:(CustomControlState)state{
    
    
}

//根据state改变button显示的内容
- (void)setButtonWithState:(CustomControlState)state{
    
    //保存显示state
    _cState = state;
    
    //change backgroundColor
    [self setCustomBackgroundColorWithState:state];
    
    //change image
    [self setCustomImageWithState:state];
    
    //change borderColor
    [self setCustomBorderColorWithState:state];
    
    //change titleColor
    [self setCustomTitleColorWithState:state];
    //change title
    [self setCustomTitleWithState:state];
    
    //change contentColor
    [self setCustomContentColorWithState:state];
    //change contentTitle
    [self setCustomContentTitleWithState:state];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[self imageWithColor:backgroundColor] forState:state];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 懒加载
#pragma mark -

//- (UIImageView *)backgroundImgView{
//    
//    if(!_backgroundImgView){
//        
//        UIImageView * imgView = [UIImageView newAutoLayoutView];
//        imgView.contentMode = UIViewContentModeScaleAspectFit;
//        imgView.image = [UIImage imageNamed:@""];
//        
//        _backgroundImgView = imgView;
//    }
//    return _backgroundImgView;
//}



//get ImageView
- (UIImageView *)customImgView{
    
    if(!_customImgView){
        
        _customImgView = [UIImageView newAutoLayoutView];
        _customImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_customImgView];
    }
    return _customImgView;
}

//get titleLabel
- (UILabel *)customTitleLabel{
    
    if(!_customTitleLabel){
        
        UILabel * label = [UILabel newAutoLayoutView];
        label.text = @"";
//        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor blackColor];
        
        _customTitleLabel = label;
        [self addSubview:_customTitleLabel];
    }
    return _customTitleLabel;
}

//get customContentLabel
- (UILabel *)customContentLabel{
    
    if(!_customContentLabel){
        
        UILabel * label = [UILabel newAutoLayoutView];
        label.text = @"";
//        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor blackColor];
        
        _customContentLabel = label;
        [self addSubview:_customContentLabel];
    }
    return _customContentLabel;
}

- (NSMutableDictionary<NSNumber *,UIColor *> *)customBackgroundColorDictionary{
    
    if(!_customBackgroundColorDictionary){
        
        _customBackgroundColorDictionary = [NSMutableDictionary new];
    }
    return _customBackgroundColorDictionary;
}

- (NSMutableDictionary<NSNumber *,UIImage *> *)customImageDictionary{
    
    if(!_customImageDictionary){
        
        _customImageDictionary = [NSMutableDictionary new];
    }
    return _customImageDictionary;
}

- (NSMutableDictionary<NSNumber *,UIColor *> *)customBorderColorDictionary{
    
    if(!_customBorderColorDictionary){
        
        _customBorderColorDictionary = [NSMutableDictionary new];
    }
    return _customBorderColorDictionary;
}

- (NSMutableDictionary<NSNumber *,NSString *> *)customTitleDictionary{
    
    if(!_customTitleDictionary){
        
        _customTitleDictionary = [NSMutableDictionary new];
    }
    return _customTitleDictionary;
}

- (NSMutableDictionary<NSNumber *,UIColor *> *)customTitleColorDictionary{
    
    if(!_customTitleColorDictionary){
        
        _customTitleColorDictionary = [NSMutableDictionary new];
    }
    return _customTitleColorDictionary;
}

- (NSMutableDictionary<NSNumber *,NSString *> *)customContentTitleDictionary{
    
    if(!_customContentTitleDictionary){
        
        _customContentTitleDictionary = [NSMutableDictionary new];
    }
    return _customContentTitleDictionary;
}

- (NSMutableDictionary<NSNumber *,UIColor *> *)customContentColorDictionary{
    
    if(!_customContentColorDictionary){
        
        _customContentColorDictionary = [NSMutableDictionary new];
    }
    return _customContentColorDictionary;
}

@end
