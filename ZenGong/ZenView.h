//
//  ZenView.h
//  ZenGong
//
//  Created by Damian Brunold on 20.10.14.
//  Copyright (c) 2014 Damian Brunold. All rights reserved.
//

#ifndef ZenGong_ZenView_h
#define ZenGong_ZenView_h

@import UIKit;

@interface ZenView : UIView

- (instancetype)initWithFrame:(CGRect)aRect;

- (instancetype)initWithCoder:(NSCoder *)decoder;

- (void)drawRect:(CGRect)rect;

- (void)setState:(NSString*)label elapsed:(double)fraction;

@end

#endif
