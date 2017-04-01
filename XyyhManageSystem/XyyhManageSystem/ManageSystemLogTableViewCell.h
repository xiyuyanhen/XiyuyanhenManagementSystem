//
//  ManageSystemLogTableViewCell.h
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/30.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageSystemInstruction.h"

@interface ManageSystemLogTableViewCell : UITableViewCell

- (void)setupByInstruction:(ManageSystemInstruction *)instruction;

@end
