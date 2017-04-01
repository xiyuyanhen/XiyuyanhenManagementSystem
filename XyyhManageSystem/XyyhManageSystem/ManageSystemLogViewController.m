//
//  ManageSystemLogViewController.m
//  XyyhManageSystem
//
//  Created by DragonPass on 2017/3/29.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import "ManageSystemLogViewController.h"
#import "ManageSystemInstruction.h"
#import "ManageSystemLogTableViewCell.h"

@interface ManageSystemLogViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSArray        * dataArray;
@property (nonatomic, assign) BOOL         didSetupConstrains;
@end

@implementation ManageSystemLogViewController

static NSString * identifier = @"manageSystemLogTableViewCell";

- (void)loadView {
    [super loadView];
    
    self.tableView = [UITableView newAutoLayoutView];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    [self.tableView registerClass:[ManageSystemLogTableViewCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    
    
    //约束
    [self.view setNeedsUpdateConstraints];
    
}

#pragma mark - 布局
#pragma mark -
- (void)updateViewConstraints {
    
    if (!self.didSetupConstrains) {
        
        [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view];
        
        self.didSetupConstrains   = YES;
    }
    
    [super updateViewConstraints];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reload{
    
    self.dataArray = nil;
    
    ManageSystemInstruction * instruction = [[ManageSystemInstruction alloc] init];
    
    [instruction getUserInstructionFromBmob:instruction.className result:^(NSArray<ManageSystemInstruction *> *array, NSError *error) {
        
        if(!error && array && array.count>0){
            
            
            self.dataArray = array;
            [self.tableView reloadData];
            
        }else{
            
            NSString * message = @"Error";
            if([error.userInfo.allKeys containsObject:@"NsLocalizedDescription"]){
                
                message = error.userInfo[@"NsLocalizedDescription"];
            }
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Instruction 添加失败" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alertView show];
        }
    }];
}


#pragma mark - delegate
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = self.dataArray.count;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(ManageSystemLogTableViewCell * cell) {
        
        [cell setupByInstruction:self.dataArray[indexPath.row]];
    }];
    
//    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ManageSystemLogTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    ManageSystemInstruction * instruction = self.dataArray[indexPath.row];
    
    [cell setupByInstruction:instruction];
    
    return cell;
}

- (NSArray *)dataArray{
    
    if(!_dataArray){
        
        _dataArray = [NSArray new];
    }
    return _dataArray;
}

@end
