//
//  ZenView.m
//  ZenGong
//
//  Created by Damian Brunold on 20.10.14.
//  Copyright (c) 2014 Damian Brunold. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZenView.h"

@interface ZenView ()

- (void)drawTimeRemaining:(CGRect) rect;

- (void)drawTimeCircle:(CGRect) rect;

@end

@implementation ZenView {
    double _fraction;
    NSString *_label;
}

- (instancetype)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    if (self) {
        [self setOpaque:NO];
        [self setBackgroundColor: [UIColor clearColor]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        // empty
    }
    return self;
}

- (void)setState:(NSString *)label elapsed:(double)fraction {
    _fraction = fraction;
    _label = label;
}

- (void)drawRect:(CGRect)rect {
    [self drawBackgroundCircle:rect];
    [self drawTimeRemaining:rect];
    [self drawTimeCircle:rect];
}

- (void)drawTimeRemaining:(CGRect) rect {
    NSDictionary *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:24.0f],
                            NSForegroundColorAttributeName:
                                [UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1.0]};
    CGSize textsize = [_label sizeWithAttributes:attrs];
    CGRect textrect = self.bounds;
    textrect.origin.x = (textrect.size.width - textsize.width) / 2.0;
    textrect.origin.y = (textrect.size.height - textsize.height) / 2.0;
    textrect.size = textsize;
    [_label drawInRect:textrect withAttributes:attrs];
}

- (void)drawTimeCircle:(CGRect) rect {
    if (_fraction == 0.0) return;
    CGFloat radius = fmin(rect.size.height / 2 - 5, rect.size.width / 2 - 5);
    CGPoint centerPoint;
    centerPoint.x = rect.origin.x + rect.size.width / 2;
    centerPoint.y = rect.origin.y + rect.size.height / 2;
    CGFloat start = 2 * M_PI / 4 * 3;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:centerPoint
                    radius:radius
                startAngle:start
                  endAngle:start + 2 * M_PI * _fraction
                 clockwise:YES];
    path.lineWidth = 8;
    [[UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1.0] setStroke];
    [path stroke];
}

- (void)drawBackgroundCircle:(CGRect) rect {
    CGFloat radius = fmin(rect.size.height / 2 - 5, rect.size.width / 2 - 5);
    CGPoint centerPoint;
    centerPoint.x = rect.origin.x + rect.size.width / 2;
    centerPoint.y = rect.origin.y + rect.size.height / 2;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:centerPoint
                    radius:radius
                startAngle:0
                  endAngle:2 * M_PI
                 clockwise:YES];
    path.lineWidth = 8;
    [[UIColor colorWithRed:0.1 green:0.20 blue:0.5 alpha:1.0] setStroke];
    [path stroke];
}

@end
