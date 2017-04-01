//
//  XyyhManageSystemTests.m
//  XyyhManageSystemTests
//
//  Created by DragonPass on 2017/3/28.
//  Copyright © 2017年 XyyH. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XyyhManageSystemTests : XCTestCase

@end

@implementation XyyhManageSystemTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSInteger prices[7] = {250,300,350,400,450,500,550};
    NSInteger counts[] = {4000000000,3333333400,2857142900,2500000000,2222222300,2000000000,1818181900};
    
    for(int n=0; n<7; n++){
        
        NSInteger price = prices[n];
        NSInteger count = 0;
        for(NSInteger i=0; i<10000000000; i++){
            
            if( i%price < 100 ){
                
                count ++;
            }
        }
        
        double rate = (double)count/(double)10000000000;
        
        NSLog(@"Price:%ld count:%ld rate:%lf",price,count,rate);
    }
    

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
