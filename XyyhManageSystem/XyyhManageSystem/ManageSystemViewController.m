//
//  ManageSystemViewController.m
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/28.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import "ManageSystemViewController.h"
#import "ManageSystemInstruction.h"
#import "ManageSystemLogViewController.h"
#import "XyyHBmobTools.h"

@interface ManageSystemViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIScrollView  * scrollView;
@property (nonatomic, strong) UILabel       * nowDateLab;
@property (nonatomic, strong) UILabel       * purposeLable;
@property (nonatomic, strong) BaseTextField * purposeTextField;
@property (nonatomic, strong) BaseView      * dateView;
@property (nonatomic, strong) UILabel       * beginLabel;
@property (nonatomic, strong) BaseButton    * beginDateBtn;
@property (nonatomic, strong) UILabel       * overLabel;
@property (nonatomic, strong) BaseButton    * overDateBtn;
@property (nonatomic, strong) UILabel       * remarksLabel;
@property (nonatomic, strong) BaseTextView  * remarksTextView;
@property (nonatomic, strong) BaseButton    * submitBtn;
@property (nonatomic, strong) UIDatePicker  * datePicker;

@property (nonatomic, strong) NSTimer       * timer;
@property (nonatomic, strong) NSDate        * beginDate;
@property (nonatomic, strong) NSDate        * overDate;
@property (nonatomic, assign) BOOL            isEditBeginDate;

@property (nonatomic, assign) BOOL         didSetupConstrains;

@end

@implementation ManageSystemViewController



- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.datePicker];
    
    [self.scrollView addSubview:self.nowDateLab];
    [self.scrollView addSubview:self.purposeLable];
    [self.scrollView addSubview:self.purposeTextField];
    [self.scrollView addSubview:self.dateView];
    [self.scrollView addSubview:self.remarksLabel];
    [self.scrollView addSubview:self.remarksTextView];
    [self.scrollView addSubview:self.submitBtn];
    
    [self.dateView addSubview:self.beginLabel];
    [self.dateView addSubview:self.beginDateBtn];
    [self.dateView addSubview:self.overLabel];
    [self.dateView addSubview:self.overDateBtn];
    
    //约束
    [self.view setNeedsUpdateConstraints];
    
}

#pragma mark - 布局
#pragma mark -
- (void)updateViewConstraints {
    
    if (!self.didSetupConstrains) {
        
        [self.scrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:0];
        [self.scrollView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:0];
        [self.scrollView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view withOffset:0];
        [self.scrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view withOffset:0];
        
        [self.nowDateLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.scrollView withOffset:H(20)];
        [self.nowDateLab autoAlignAxis:ALAxisVertical toSameAxisOfView:self.scrollView];
        
        [self.purposeLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nowDateLab withOffset:H(20)];
        [self.purposeLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:H(25)];
        
        [self.purposeTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.purposeLable withOffset:H(5)];
        [self.purposeTextField autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:W(25)];
        [self.purposeTextField autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view withOffset:W(-25)];
        [self.purposeTextField autoSetDimension:ALDimensionHeight toSize:35];
        
        [self.dateView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.purposeTextField withOffset:0];
        [self.dateView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:W(25)];
        [self.dateView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view withOffset:W(-25)];
        
        [self.remarksLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.dateView withOffset:H(20)];
        [self.remarksLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:H(25)];
        
        [self.remarksTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.remarksLabel withOffset:H(5)];
        [self.remarksTextView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:W(25)];
        [self.remarksTextView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view withOffset:W(-25)];
        [self.remarksTextView autoSetDimension:ALDimensionHeight toSize:H(120)];
        
        [self.submitBtn autoSetDimension:ALDimensionHeight toSize:H(50)];
        [self.submitBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.remarksTextView withOffset:H(20)];
        [self.submitBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:W(25)];
        [self.submitBtn autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view withOffset:W(-25)];
        [self.submitBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.scrollView withOffset:0];
        
        [self.datePicker autoSetDimension:ALDimensionHeight toSize:H(215)];
        [self.datePicker autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:0];
        [self.datePicker autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view withOffset:0];
        [self.datePicker autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view withOffset:0];
        
        
        self.didSetupConstrains   = YES;
    }
    
    [super updateViewConstraints];
    
}

- (void)setupDateViewshowoverDateBtn:(BOOL)showoverDateBtn{
    
    for(BaseView * view in self.dateView.subviews){
        
        [view removeFromSuperview];
    }
    
    [self.dateView addSubview:self.beginLabel];
    [self.dateView addSubview:self.beginDateBtn];
    
    [self.beginLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.dateView withOffset:H(20)];
    [self.beginLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.dateView];
    
    [self.beginDateBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.beginLabel withOffset:H(5)];
    [self.beginDateBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.dateView];
    [self.beginDateBtn autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.dateView];
    [self.beginDateBtn autoSetDimension:ALDimensionHeight toSize:35];
    
    if(showoverDateBtn){
        
        [self.dateView addSubview:self.overLabel];
        [self.dateView addSubview:self.overDateBtn];
        
        [self.overLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.beginDateBtn withOffset:H(20)];
        [self.overLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.dateView];
        
        [self.overDateBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.overLabel withOffset:H(5)];
        [self.overDateBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.dateView];
        [self.overDateBtn autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.dateView];
        [self.overDateBtn autoSetDimension:ALDimensionHeight toSize:35];
        [self.overDateBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.dateView withOffset:0];
        
    }else{
        
        [self.beginDateBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.dateView withOffset:0];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nowDateLab.text = [self dateStringFromDate:[NSDate date]];
    self.timer;
    [self setupDateViewshowoverDateBtn:YES];
    [self checkSubmitEnable];
    
    _isEditBeginDate = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log" style:UIBarButtonItemStylePlain target:self action:@selector(logHandle:)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    
}

- (NSString *)dateStringFromDate:(NSDate *)date{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    
    return [formatter stringFromDate:date];
}

- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    
    return [formatter dateFromString:dateString];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //宣告一个UITouch的指标来存放事件触发时所撷取到的状态
    
    UITouch *touch = [[event allTouches] anyObject];
    CGFloat ly = [touch locationInView:self.view].y;
    
    if (ly <  Screen_height-H(215)) { //点标题栏也会消失，点其他地方捕捉不到了
        self.datePicker.hidden = YES;
        [self.beginDateBtn setButtonWithState:CustomControlStateNormal];
        [self.overDateBtn setButtonWithState:CustomControlStateNormal];
    }
    
    [super touchesBegan:touches withEvent:event];
    NSLog(@"touches:%@",touches);
    [self.view endEditing: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - hnadle
#pragma mark -

- (void)timerHandle:(NSTimer *)timer{
    
    self.nowDateLab.text = [self dateStringFromDate:[NSDate date]];
}

- (void)logHandle:(UIBarButtonItem *)buttonItem{
    
    ManageSystemLogViewController * manageSystemLogVC = [[ManageSystemLogViewController alloc] init];
    [self.navigationController pushViewController:manageSystemLogVC animated:YES];
}

- (void)purposeTFChange:(BaseTextField *)textField{
    
    [self checkSubmitEnable];
}

- (void)showDatePicker:(BaseButton *)button{
    
    self.datePicker.hidden = YES;
    
    if(button == self.beginDateBtn){
        
        self.isEditBeginDate = YES;
        self.datePicker.hidden = NO;
    }else if(button == self.overDateBtn){
        
        self.isEditBeginDate = NO;
        self.datePicker.hidden = NO;
    }
    
    [self checkSubmitEnable];
}

- (void)submitHandle:(BaseButton *)button{
    
    ManageSystemInstruction * instruction = [[ManageSystemInstruction alloc] init];
    instruction.purpose = self.purposeTextField.text;
    instruction.createDate = [NSDate date];
    instruction.beginDate = self.beginDate;
    instruction.overDate = self.overDate;
    instruction.status = @"Pending"; //待执行
    
    [instruction addInstructionToBmob:^(BOOL isSuccessful, NSError *error) {
        
        if(error){
            
            NSLog(@"error: %@",error);
            
            NSString * message = @"Error";
            if([error.userInfo.allKeys containsObject:@"NsLocalizedDescription"]){
                
                message = error.userInfo[@"NsLocalizedDescription"];
            }
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Instruction 添加失败" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alertView show];
            
            
        }else{
            
            NSString * message = @"";
            if(isSuccessful){
                message = @"添加成功！";
            }else{
                message = @"添加失败！";
            }
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Instruction" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alertView show];
        }
    }];
    
    
}

- (void)datePickerHandle:(UIDatePicker *)datePicker{
    
    NSDate * date = datePicker.date;
    if(self.isEditBeginDate){
        
        [self.beginDateBtn setCustomTitle:[self dateStringFromDate:date] forState:CustomControlStateNormal];
        self.beginDate = date;
    }else{
        
        [self.overDateBtn setCustomTitle:[self dateStringFromDate:date] forState:CustomControlStateNormal];
        self.overDate = date;
    }
    
    [self checkSubmitEnable];
}

- (void)checkSubmitEnable{
    
    BOOL enable = YES;
    
    enable &= self.purposeTextField.text.length>0;
    enable &= (self.beginDate != nil);
    enable &= (self.overDate != nil);
    
    self.submitBtn.enabled = enable;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    self.datePicker.hidden = YES;
    [self.beginDateBtn setButtonWithState:CustomControlStateNormal];
    [self.overDateBtn setButtonWithState:CustomControlStateNormal];
    
    return YES;
}

- (void)purposeTFBegin:(BaseTextField *)textField{
    
    self.datePicker.hidden = YES;
    [self.beginDateBtn setButtonWithState:CustomControlStateNormal];
    [self.overDateBtn setButtonWithState:CustomControlStateNormal];
}

#pragma mark - 懒加载
#pragma mark -

- (UIScrollView *)scrollView{
    
    if(!_scrollView){
        
        _scrollView = [UIScrollView newAutoLayoutView];
        _scrollView.backgroundColor = UIColorFromRGB_16(0xffffff);
    }
    return _scrollView;
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

- (UILabel *)purposeLable{
    
    if(!_purposeLable){
        
        UILabel * label = [UILabel newAutoLayoutView];
//        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"命令";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _purposeLable = label;
    }
    return _purposeLable;
}

- (BaseTextField *)purposeTextField{
    
    if(!_purposeTextField){
        
        BaseTextField * textField = [BaseTextField newAutoLayoutView];
        
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius  = 5.0f;
        textField.layer.borderWidth   = 1;
        textField.layer.borderColor   = [UIColorFromRGB_16(0x2d354c) CGColor];
        
        textField.text = @"";
        textField.textColor = UIColorFromRGB_16(0x2d354c);
        textField.font = FONT(13);
        textField.textAlignment = NSTextAlignmentLeft;
        textField.backgroundColor = [UIColor whiteColor];
        
        textField.placeholder = @"";
        
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 5)];
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        [textField addTarget:self action:@selector(purposeTFChange:) forControlEvents:UIControlEventEditingChanged];
        [textField addTarget:self action:@selector(purposeTFBegin:) forControlEvents:UIControlEventEditingDidBegin];
        
        _purposeTextField = textField;
    }
    return _purposeTextField;
}

- (BaseView *)dateView{
    
    if(!_dateView){
        
        _dateView = [BaseView newAutoLayoutView];
    }
    
    return _dateView;
}

- (UILabel *)beginLabel{
    
    if(!_beginLabel){
        
        UILabel * label = [UILabel newAutoLayoutView];
        //        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"开始时间:";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _beginLabel = label;
    }
    
    return _beginLabel;
}

- (BaseButton *)beginDateBtn{
    
    if(!_beginDateBtn){
        
        BaseButton * button = [BaseButton createForTitleCenter];
        button.contentMode = UIViewContentModeScaleToFill;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0f;
        button.layer.borderWidth   = 1;
        [button setCustomBorderColor:UIColorFromRGB_16(0x2d354c) forState:CustomControlStateNormal];
        [button setCustomBorderColor:UIColorFromRGB_16(0xe73737) forState:CustomControlStateCustom];
        
//        [button setTitle:L(@"Limousine_SearchFlightNO_Search", @"Search") forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB_16(0xffffff) forState:UIControlStateNormal];
        //[button setTitleColor:UIColorFromRGB_16(0xdddddd) forState:UIControlStateDisabled];
//        [button setBackgroundColor:UIColorFromRGB_16(0xe73737) forState:UIControlStateNormal];
//        [button setBackgroundColor:UIColorFromRGB_16(0xcccccc) forState:UIControlStateDisabled];
        
        //        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        //
        //            NSLog(@"button:%@",sender);
        //        }];
        [button addTarget:self action:@selector(showDatePicker:) forControlEvents:UIControlEventTouchUpInside];
        
        [button highlightedCompletedBlock:^(CustomControlState state) {
            
            if(state == CustomControlStateNormal){
                
                [self.overDateBtn setButtonWithState:CustomControlStateNormal];
                [self.beginDateBtn setButtonWithState:CustomControlStateCustom];
            }
        }];
        
        _beginDateBtn = button;
    }
    return _beginDateBtn;
}

- (UILabel *)overLabel{
    
    if(!_overLabel){
        
        UILabel * label = [UILabel newAutoLayoutView];
        //        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"结束时间:";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _overLabel = label;
    }
    
    return _overLabel;
}

- (BaseButton *)overDateBtn{
    
    if(!_overDateBtn){
        
        BaseButton * button = [BaseButton createForTitleCenter];
        button.contentMode = UIViewContentModeScaleToFill;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0f;
        button.layer.borderWidth   = 1;
        [button setCustomBorderColor:UIColorFromRGB_16(0x2d354c) forState:CustomControlStateNormal];
        [button setCustomBorderColor:UIColorFromRGB_16(0xe73737) forState:CustomControlStateCustom];
        
//        [button setTitle:L(@"Limousine_SearchFlightNO_Search", @"Search") forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB_16(0xffffff) forState:UIControlStateNormal];
        //[button setTitleColor:UIColorFromRGB_16(0xdddddd) forState:UIControlStateDisabled];
//        [button setBackgroundColor:UIColorFromRGB_16(0xe73737) forState:UIControlStateNormal];
//        [button setBackgroundColor:UIColorFromRGB_16(0xcccccc) forState:UIControlStateDisabled];
        
        //        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        //
        //            NSLog(@"button:%@",sender);
        //        }];
        [button addTarget:self action:@selector(showDatePicker:) forControlEvents:UIControlEventTouchUpInside];
        
        [button highlightedCompletedBlock:^(CustomControlState state) {
            
            if(state == CustomControlStateNormal){
                
                [self.overDateBtn setButtonWithState:CustomControlStateCustom];
                [self.beginDateBtn setButtonWithState:CustomControlStateNormal];
            }
        }];
        
        _overDateBtn = button;
    }
    return _overDateBtn;
}

- (UILabel *)remarksLabel{
    
    if(!_remarksLabel){
        
        UILabel * label = [UILabel newAutoLayoutView];
        //        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"备注";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _remarksLabel = label;
    }
    
    return _remarksLabel;
}

- (BaseTextView *)remarksTextView{
    
    if(!_remarksTextView){
        
        BaseTextView * textView = [BaseTextView newAutoLayoutView];
        textView.layer.masksToBounds = YES;
        textView.layer.borderWidth = 1;
        textView.layer.borderColor = [UIColorFromRGB_16(0x2d354c) CGColor];
        textView.placeholderString = @"Option";
        
        textView.delegate = self;
        
        _remarksTextView = textView;
    }
    return _remarksTextView;
}

- (BaseButton *)submitBtn{
    
    if(!_submitBtn){
        
        BaseButton * button = [BaseButton newAutoLayoutView];
        button.contentMode = UIViewContentModeScaleToFill;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0f;
        
        [button setTitle:@"提交" forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB_16(0xffffff) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB_16(0xdddddd) forState:UIControlStateDisabled];
        [button setBackgroundColor:UIColorFromRGB_16(0xe73737) forState:UIControlStateNormal];
        [button setBackgroundColor:UIColorFromRGB_16(0xcccccc) forState:UIControlStateDisabled];
        
        //        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        //
        //            NSLog(@"button:%@",sender);
        //        }];
        [button addTarget:self action:@selector(submitHandle:) forControlEvents:UIControlEventTouchUpInside];
        
        _submitBtn = button;
    }
    
    return _submitBtn;
}

- (UIDatePicker *)datePicker{
    
    if(!_datePicker){
        
        UIDatePicker * datePicker = [UIDatePicker newAutoLayoutView];
        datePicker.timeZone = [NSTimeZone localTimeZone];
        NSString * dateString = [self dateStringFromDate:[NSDate date]];
        dateString  = [dateString stringByReplacingCharactersInRange:NSMakeRange(dateString.length-2, 2) withString:@"00"];
        NSDate * date = [self dateFromString:dateString];
        datePicker.minimumDate = date;
        datePicker.date = date;
        [datePicker addTarget:self action:@selector(datePickerHandle:) forControlEvents:UIControlEventValueChanged];
        datePicker.hidden = YES;
        
        _datePicker = datePicker;
    }
    return _datePicker;
}

- (NSTimer *)timer{
    
    if(!_timer){
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerHandle:) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
