//
//  SettingsViewController.h
//  ZenGong
//
//  Created by Damian Brunold on 23.10.14.
//  Copyright (c) 2014 Damian Brunold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *duration;

- (IBAction)okAction:(id)sender;

@end
