//
//  UIScrollView+Touch.m
//  DragonPassEn
//
//  Created by Dragonpass on 17/1/22.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "UIScrollView+Touch.h"

@implementation UIScrollView (Touch)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

@end
