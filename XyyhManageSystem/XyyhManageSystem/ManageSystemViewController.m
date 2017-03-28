//
//  ManageSystemViewController.m
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/28.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import "ManageSystemViewController.h"
#import "ManageSystemInstruction.h"
#import "XyyHBmobTools.h"

@interface ManageSystemViewController ()

@property (nonatomic, strong) UILabel       * nowDateLab;
@property (nonatomic, strong) BaseTextField * purposeTextField;
@property (nonatomic, strong) BaseButton    * beginDate;
@property (nonatomic, strong) BaseButton    * overDate;
@property (nonatomic, strong) BaseTextView  * remarksTextView;
@property (nonatomic, strong) BaseButton    * submitBtn;


@end

@implementation ManageSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)nowDateLab{
    
    if(!_nowDateLab){
        
        UILabel * label = [UILabel newAutoLayoutView];
        label.text = @"";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _nowDateLab = label;
    }
    return _nowDateLab;
}

- (BaseTextField *)purposeTextField{
    
    if(!_purposeTextField){
        
        BaseTextField * textField = [BaseTextField newAutoLayoutView];
        
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius  = 5.0f;
        textField.layer.borderColor   = [UIColorFromRGB_16(0x2d354c) CGColor];
        
        textField.text = @"";
        textField.textColor = UIColorFromRGB_16(0x2d354c);
        textField.font = FONT(13);
        textField.textAlignment = NSTextAlignmentLeft;
        textField.backgroundColor = [UIColor whiteColor];
        
        textField.placeholder = @"";
        
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 5)];
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        //[textField addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventEditingChanged];
        
        _purposeTextField = textField;
    }
    return _purposeTextField;
}

- (BaseButton *)beginDate{
    
    if(!_beginDate){
        
        BaseButton * button = [BaseButton newAutoLayoutView];
        button.contentMode = UIViewContentModeScaleToFill;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0f;
        
//        [button setTitle:L(@"Limousine_SearchFlightNO_Search", @"Search") forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB_16(0xffffff) forState:UIControlStateNormal];
        //[button setTitleColor:UIColorFromRGB_16(0xdddddd) forState:UIControlStateDisabled];
//        [button setBackgroundColor:UIColorFromRGB_16(0xe73737) forState:UIControlStateNormal];
//        [button setBackgroundColor:UIColorFromRGB_16(0xcccccc) forState:UIControlStateDisabled];
        
        //        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        //
        //            NSLog(@"button:%@",sender);
        //        }];
        [button addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _beginDate = button;
    }
    return _beginDate;
}

- (BaseButton *)overDate{
    
    if(!_overDate){
        
        BaseButton * button = [BaseButton newAutoLayoutView];
        button.contentMode = UIViewContentModeScaleToFill;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0f;
        
//        [button setTitle:L(@"Limousine_SearchFlightNO_Search", @"Search") forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB_16(0xffffff) forState:UIControlStateNormal];
        //[button setTitleColor:UIColorFromRGB_16(0xdddddd) forState:UIControlStateDisabled];
//        [button setBackgroundColor:UIColorFromRGB_16(0xe73737) forState:UIControlStateNormal];
//        [button setBackgroundColor:UIColorFromRGB_16(0xcccccc) forState:UIControlStateDisabled];
        
        //        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        //
        //            NSLog(@"button:%@",sender);
        //        }];
        [button addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _overDate = button;
    }
    return _overDate;
}

- (BaseTextView *)remarksTextView{
    
    if(!_remarksTextView){
        
        
    }
    return _remarksTextView;
}

- (BaseButton *)submitBtn{
    
    if(!_submitBtn){
        
        BaseButton * button = [BaseButton newAutoLayoutView];
        button.contentMode = UIViewContentModeScaleToFill;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0f;
        
//        [button setTitle:L(@"Limousine_SearchFlightNO_Search", @"Search") forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB_16(0xffffff) forState:UIControlStateNormal];
        //[button setTitleColor:UIColorFromRGB_16(0xdddddd) forState:UIControlStateDisabled];
//        [button setBackgroundColor:UIColorFromRGB_16(0xe73737) forState:UIControlStateNormal];
//        [button setBackgroundColor:UIColorFromRGB_16(0xcccccc) forState:UIControlStateDisabled];
        
        //        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        //
        //            NSLog(@"button:%@",sender);
        //        }];
        [button addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _submitBtn = button;
    }
    
    return _submitBtn;
}

@end
