//
//  BaseTextView.m
//  DragonPassEn
//
//  Created by Dragonpass on 17/1/18.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "BaseTextView.h"

@interface BaseTextView ()


@property (nonatomic, strong) UILabel  * placeholderStringLabel;

@end

@implementation BaseTextView

- (instancetype)init{
    
    self = [super init];
    
    if(self){
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeHandle) name:UITextViewTextDidChangeNotification object:self];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    if(width != 0){
        
        if(self.placeholderStringLabel.superview){
            [self.placeholderStringLabel removeFromSuperview];
        }
        
        [self addSubview:self.placeholderStringLabel];
        [self sendSubviewToBack:_placeholderStringLabel];
        
        UIEdgeInsets inset = self.textContainerInset;
        
        [self.placeholderStringLabel autoSetDimension:ALDimensionWidth toSize:W(width-(inset.left+inset.right))];
        [self.placeholderStringLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:H(inset.top)];
        [self.placeholderStringLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self withOffset:W(inset.left+3)];
//                [_placeholderStringLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self withOffset:W(-16)];
        
    }
}


- (UILabel *)placeholderStringLabel{
    
    if(!_placeholderStringLabel){
        
        UIColor * placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
        UIFont  * placeholderFont  = [UIFont fontWithName:@"GothamSSm-Light" size:13];
        
        _placeholderStringLabel = [UILabel newAutoLayoutView];
        
        _placeholderStringLabel.textColor = placeholderColor;
        
        _placeholderStringLabel.font = self.font?self.font:placeholderFont;
        
//        [self addSubview:_placeholderStringLabel];
//        [self sendSubviewToBack:_placeholderStringLabel];
        
        _placeholderStringLabel.numberOfLines = 0;
        
//        [_placeholderStringLabel autoSetDimension:ALDimensionWidth toSize:W(Screen_width-70)];
//        [_placeholderStringLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:H(15)];
//        [_placeholderStringLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self withOffset:W(16)];
//        [_placeholderStringLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self withOffset:W(-16)];
        
        if(self.text.length>0){
            
            self.placeholderStringLabel.hidden = YES;
        }
    
    }
    
    return _placeholderStringLabel;
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placeholderStringLabel.font = font;
}

- (void)setPlaceholderString:(NSString *)placeholderString{
    
    if(![_placeholderString isEqualToString:placeholderString]){
        
        _placeholderString = placeholderString;
        
        self.placeholderStringLabel.text = placeholderString;
    }
}

- (void)textDidChangeHandle{
    
    if (self.text.length == 0) {
        self.placeholderStringLabel.hidden = NO;
    }else{
        self.placeholderStringLabel.hidden = YES;
    }
}


@end
