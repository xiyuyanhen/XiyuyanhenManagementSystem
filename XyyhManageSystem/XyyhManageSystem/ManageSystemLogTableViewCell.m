//
//  ManageSystemLogTableViewCell.m
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/30.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import "ManageSystemLogTableViewCell.h"

@interface ManageSystemLogTableViewCell ()

@property (nonatomic, strong) BaseView  * instructionView;
@property (nonatomic, strong) UILabel   * user;
@property (nonatomic, strong) UILabel   * purpose;
@property (nonatomic, strong) UILabel   * createDate;
@property (nonatomic, strong) UILabel   * beginDate;
@property (nonatomic, strong) UILabel   * overDate;
@property (nonatomic, strong) UILabel   * status;

@end

@implementation ManageSystemLogTableViewCell

- (instancetype)init{
    
    self = [super init];
    if(self){
        
//        [self addAll];
//        [self layoutAll];
    }
    return self;
}

- (void)addAll{
    
    [self.contentView addSubview:self.instructionView];
    [self.instructionView addSubview:self.user];
    [self.instructionView addSubview:self.purpose];
    [self.instructionView addSubview:self.createDate];
    [self.instructionView addSubview:self.beginDate];
    [self.instructionView addSubview:self.overDate];
    [self.instructionView addSubview:self.status];
    
}

- (void)layoutAll{
    
//    [self.instructionView autoSetDimension:ALDimensionWidth toSize:Screen_width];
    [self.instructionView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView];
    [self.instructionView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.contentView];
    [self.instructionView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.contentView];
    [self.instructionView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView];
    
    [self.user autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.instructionView withOffset:H(10)];
    [self.user autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.instructionView withOffset:H(25)];
    [self.user autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.instructionView withOffset:-H(25)];
    
    [self.purpose autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.user withOffset:H(10)];
    [self.purpose autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.instructionView withOffset:H(25)];
    [self.purpose autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.instructionView withOffset:-H(25)];
    
    [self.createDate autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.purpose withOffset:H(10)];
    [self.createDate autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.instructionView withOffset:H(25)];
    [self.createDate autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.instructionView withOffset:-H(25)];
    
    [self.beginDate autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.createDate withOffset:H(10)];
    [self.beginDate autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.instructionView withOffset:H(25)];
    [self.beginDate autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.instructionView withOffset:-H(25)];
    
    [self.overDate autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.beginDate withOffset:H(10)];
    [self.overDate autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.instructionView withOffset:H(25)];
    [self.overDate autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.instructionView withOffset:-H(25)];
    
    [self.status autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.overDate withOffset:H(10)];
    [self.status autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.instructionView withOffset:H(25)];
    [self.status autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.instructionView withOffset:-H(25)];
    [self.status autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.instructionView withOffset:-H(25)];
    
    

}

- (void)layoutSubviews{

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupByInstruction:(ManageSystemInstruction *)instruction{
    
    [self addAll];
    [self layoutAll];
    
    self.user.text =       [NSString stringWithFormat:@"用户:    %@",[self checkString:instruction.user]];
    self.purpose.text =    [NSString stringWithFormat:@"动作:    %@",[self checkString:instruction.purpose]];
    self.createDate.text = [NSString stringWithFormat:@"创建时间: %@",[self checkString:[instruction stringFromDate:instruction.createDate]]];
    self.beginDate.text =  [NSString stringWithFormat:@"开始时间: %@",[self checkString:[instruction stringFromDate:instruction.beginDate]]];
    self.overDate.text =   [NSString stringWithFormat:@"结束时间: %@",[self checkString:[instruction stringFromDate:instruction.overDate]]];
    self.status.text =     [NSString stringWithFormat:@"状态:    %@",[self checkString:instruction.status]];
}


- (NSString *)checkString:(NSString *)string{
    
    return (string && string.length>0) ? string : @"";
}

#pragma mark - 懒加载
#pragma mark - 

- (BaseView *)instructionView{
    
    if(!_instructionView){
        
        _instructionView = [BaseView newAutoLayoutView];
    }
    return _instructionView;
}

- (UILabel *)user{
    
    if(!_user){
        
        UILabel * label = [UILabel newAutoLayoutView];
//        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _user = label;
    }
    return _user;
}

- (UILabel *)purpose{
    
    if(!_purpose){
        
        UILabel * label = [UILabel newAutoLayoutView];
        //        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _purpose = label;
    }
    return _purpose;
}

- (UILabel *)createDate{
    
    if(!_createDate){
        
        UILabel * label = [UILabel newAutoLayoutView];
        //        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _createDate = label;
    }
    return _createDate;
}

- (UILabel *)beginDate{
    
    if(!_beginDate){
        
        UILabel * label = [UILabel newAutoLayoutView];
        //        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _beginDate = label;
    }
    return _beginDate;
}

- (UILabel *)overDate{
    
    if(!_overDate){
        
        UILabel * label = [UILabel newAutoLayoutView];
        //        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _overDate = label;
    }
    return _overDate;
}

- (UILabel *)status{
    
    if(!_status){
        
        UILabel * label = [UILabel newAutoLayoutView];
        //        [label setLineHeight:H(8) ForText:label.text];
        label.text = @"";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = UIColorFromRGB_16(0x959cb9);
        label.numberOfLines = 0;
        label.font = FONT(H(14));
        
        _status = label;
    }
    return _status;
}
@end
