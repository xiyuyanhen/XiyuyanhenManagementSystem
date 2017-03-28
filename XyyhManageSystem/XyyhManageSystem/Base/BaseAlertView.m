//
//  BaseAlertView.m
//  DragonPassEn
//
//  Created by xing on 16/3/24.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "BaseAlertView.h"

@implementation BaseAlertView

#pragma mark 弹窗
-(void)setupView:(UIView *)superView withAttributedString:(NSMutableAttributedString *)text{
    UIView *mainView = superView;
    
    self.alertBtn = [UIButton newAutoLayoutView];
    [self.alertBtn addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];
    self.alertBtn.backgroundColor = [UIColor blackColor];
    self.alertBtn.alpha = 0.7;
    [mainView addSubview:self.alertBtn];
    
    [self.alertBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:mainView];
    [self.alertBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:mainView];
    [self.alertBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:mainView];
    [self.alertBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:mainView];
    
    UIView *alertView = [UIView newAutoLayoutView];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 4.0f;
    alertView.layer.masksToBounds = YES;
    self.alertView = alertView;
    [mainView addSubview:alertView];
    
    [alertView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:mainView];
    [alertView autoAlignAxis:ALAxisVertical toSameAxisOfView:mainView];
    CGFloat alertViewWidth = 290;
    [alertView autoSetDimension:ALDimensionWidth toSize:alertViewWidth];
    
    
    YYLabel *headLabel = [YYLabel new];
    headLabel.numberOfLines = 0;
    headLabel.textColor = [UIColor whiteColor];
    [alertView addSubview:headLabel];

    headLabel.userInteractionEnabled = YES ;
    headLabel.numberOfLines = 0;
    headLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    headLabel.attributedText = text;
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.frame = CGRectMake(10, 15, alertViewWidth-20, 80);
    
    CGFloat BtnWidth = (alertViewWidth - 30 - 15)*0.5;
    UIButton *OKBtn = [UIButton new];
    OKBtn.layer.cornerRadius = 3.0f;
    OKBtn.layer.masksToBounds = YES;
    [OKBtn setTitle:L(@"Restaurant_UseCard_alert_part2",@"Yes") forState:UIControlStateNormal];
    [OKBtn setBackgroundColor:REDCOLOR];
    OKBtn.titleLabel.font = CFONT;
    [OKBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [OKBtn addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:OKBtn];
    OKBtn.frame = CGRectMake(15, CGRectGetMaxY(headLabel.frame), BtnWidth, 32);
    
    
    UIButton *CencelBtn = [UIButton new];
    CencelBtn.layer.cornerRadius = 3.0f;
    CencelBtn.layer.masksToBounds = YES;
    [CencelBtn setTitle:L(@"Restaurant_UseCard_alert_Cancel",@"Cancel") forState:UIControlStateNormal];
    [CencelBtn setBackgroundColor:UIColorFromRGB_16(0x5c5c5c)];
    CencelBtn.titleLabel.font = CFONT;
    [CencelBtn addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];
    [CencelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [alertView addSubview:CencelBtn];
    
    CencelBtn.frame = CGRectMake(alertViewWidth-15-(BtnWidth), CGRectGetMaxY(headLabel.frame),BtnWidth , 32);
    
    [alertView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:CencelBtn withOffset:20];
    
}

- (void)closeAlert{
    
    [self.alertBtn removeFromSuperview];
    [self.alertView removeFromSuperview];
    self.alertBtn = nil;
    self.alertView = nil;
}

- (void)okClick{
    !self.btnClick?:self.btnClick();
}
@end
