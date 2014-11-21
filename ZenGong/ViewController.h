//
//  ViewController.h
//  ZenGong
//
//  Created by Damian Brunold on 23.09.14.
//  Copyright (c) 2014 Damian Brunold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak) NSTimer *ticker;

- (void)onTick:(NSTimer *)timer;

- (IBAction)started:(id)sender;

- (IBAction)settings:(id)sender;

- (void)reactivate;

@end

