//
//  BaseTextField.m
//  DragonPassEn
//
//  Created by Dragonpass on 16/11/25.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "BaseTextField.h"

@interface BaseTextField ()

@property (nonatomic, strong) UIView * underLine;
@property (nonatomic, strong) UIView * errorView;
@property (nonatomic, strong) UILabel * errorLabel;

@end

@implementation BaseTextField

- (instancetype)init{
    
    self = [super init];
    
    if(self){
    
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat offSetLeading = 0;
    if(self.leftView){
        offSetLeading = self.leftView.frame.size.width;
    }
    CGFloat offSetTrailing = 0;
    if(self.rightView){
        offSetTrailing = self.rightView.frame.size.width;
    }
    
    [self.placeholderStringLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.placeholderStringLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self withOffset:offSetLeading];
    [self.placeholderStringLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self withOffset:offSetTrailing];
    
    if(self.text.length>0){
        
        self.placeholderStringLabel.hidden = YES;
    }
}



- (void)textEditingChange:(BaseTextField *)textField{
    
    if (self.text.length == 0) {
        self.placeholderStringLabel.hidden = NO;
    }else{
        self.placeholderStringLabel.hidden = YES;
    }
}


- (UILabel *)placeholderStringLabel{
    
    if(!_placeholderStringLabel){
        
        UIColor * placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
        UIFont  * placeholderFont  = [UIFont fontWithName:@"GothamSSm-Light" size:13];
        
        UILabel * label = [UILabel newAutoLayoutView];
    
        label.textColor = placeholderColor;
        
        label.font = self.font?self.font:placeholderFont;
        
        _placeholderStringLabel = label;
        
        [self addSubview:_placeholderStringLabel];
        [self sendSubviewToBack:_placeholderStringLabel];
        
        [self addTarget:self action:@selector(textEditingChange:) forControlEvents:UIControlEventEditingChanged];
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
        
        self.placeholderStringLabel.text = _placeholderString;
        
    }
}

@end
