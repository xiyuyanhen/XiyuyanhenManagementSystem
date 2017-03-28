//
//  BaseAlertView.h
//  DragonPassEn
//
//  Created by xing on 16/3/24.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseAlertView : UIView

@property (nonatomic,strong) UIButton               *alertBtn;
@property (nonatomic,strong) UIView                 *alertView;
@property (nonatomic,strong) UIImageView                 *lineView;
@property (nonatomic,strong) UILabel                *titleNameLabel;

/**
 *  弹窗模块
 *
 *  @param superView 上级 self.view
 *  @param font      yykit图文混排字体
 */
-(void)setupView:(UIView *)superView withAttributedString:(NSMutableAttributedString *)text;

/**
 *  关闭
 */
- (void)closeAlert;
/**
 *  确定按钮触发回调用
 */
- (void)okClick;

/**
 *  点击确认回调
 */
@property (nonatomic,copy)  void (^btnClick)();



#pragma mark - 图文混排模板
//- (void)setupAlertViewFont{
//    WEAKSELF
//    [self.view addSubview:self.alertView];
//    self.alertView.btnClick = ^{
//        NSLog(@"%@",@"跳转");
//        NSLog(@"%@", weakSelf_SC.loungeBuyInfoView.dateSelected);
//        PayInfoViewController *pay = [[PayInfoViewController alloc]init];
//        [weakSelf_SC.navigationController pushViewController:pay animated:YES];
//    };
//    
//    NSMutableAttributedString *text = [NSMutableAttributedString new];
//    UIFont *font = CFONT;
//    {
//        NSString *title = [NSString stringWithFormat:@"%@ ",L(@"Restaurant_UseCard_alert_part1",@"Select")];
//        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
//        UIButton *OKBtn = [UIButton new];
//        OKBtn.layer.cornerRadius = 3.0f;
//        OKBtn.layer.masksToBounds = YES;
//        
//        NSString *title2 = [NSString stringWithFormat:@"   %@   ",L(@"Restaurant_UseCard_alert_part2",@"Yes")];
//        [OKBtn setTitle:title2 forState:UIControlStateNormal];
//        [OKBtn setBackgroundColor:BLUECOLOR];
//        OKBtn.titleLabel.font = CFONT;
//        [OKBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [OKBtn addTarget:self.alertView action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
//        [OKBtn sizeToFit];
//        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:OKBtn contentMode:UIViewContentModeCenter attachmentSize:OKBtn.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
//        [text appendAttributedString:attachText];
//        
//        NSString *title3 = [NSString stringWithFormat:@" %@",L(@"Restaurant_UseCard_alert_part3",@"to redeem the discount.Payment must be made with your Visa Infinite Card.")];
//        NSString *afterString = title3;
//        [text appendAttributedString:[[NSAttributedString alloc] initWithString:afterString attributes:nil]];
//    }
//    text.yy_font = font;
//    
//    [self.alertView setupView:self.view withAttributedString:text];
//    
//}


#pragma mark - layer
//- (BaseAlertView *)alertView{
//    if (!_alertView) {
//        _alertView = [BaseAlertView new];
//    }
//    return _alertView;
//}


@end
