//
//  ManageSystemLogViewController.m
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/29.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import "ManageSystemLogViewController.h"

@interface ManageSystemLogViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL         didSetupConstrains;
@end

@implementation ManageSystemLogViewController



- (void)loadView {
    [super loadView];
    
    
    //约束
    [self.view setNeedsUpdateConstraints];
    
}

#pragma mark - 布局
#pragma mark -
- (void)updateViewConstraints {
    
    if (!self.didSetupConstrains) {
        
        
        
        self.didSetupConstrains   = YES;
    }
    
    [super updateViewConstraints];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - delegate
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}



@end
