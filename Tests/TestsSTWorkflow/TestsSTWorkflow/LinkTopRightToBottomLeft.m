//
//  LinkTopRightToBottomLeft.m
//  TestsSTWorkflow
//
//  Created by Thomas Dupont on 09/10/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "LinkTopRightToBottomLeft.h"

#import <QuartzCore/QuartzCore.h>

@interface LinkTopRightToBottomLeft ()

@property (nonatomic, strong) CAShapeLayer* shape;

@end

@implementation LinkTopRightToBottomLeft

- (void)awakeFromNib
{
    self.shape = [CAShapeLayer layer];
    [self.shape setStrokeColor:[UIColor blackColor].CGColor];
    [self.shape setLineWidth:2];
    [self.layer addSublayer:self.shape];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.shape setFrame:self.bounds];
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.bounds.size.width, 0)];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [self.shape setPath:path.CGPath];
}

@end
