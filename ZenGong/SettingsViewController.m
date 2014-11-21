//
//  SettingsViewController.m
//  ZenGong
//
//  Created by Damian Brunold on 23.10.14.
//  Copyright (c) 2014 Damian Brunold. All rights reserved.
//

#import "SettingsViewController.h"
#import "ZenModel.h"

@interface SettingsViewController () {
    NSMutableArray *_minutes_data;
    NSMutableArray *_seconds_data;
}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _minutes_data = [[NSMutableArray alloc] init];
    for (int i = 0; i <= 120; i++) {
        [_minutes_data addObject: [NSString stringWithFormat:@"%3d", i]];
    }
    _seconds_data = [[NSMutableArray alloc] init];
    for (int i = 0; i <= 59; i++) {
        [_seconds_data addObject: [NSString stringWithFormat:@"%3d", i]];
    }
    self.duration.delegate = self;
    self.duration.dataSource = self;
    ZenModel *model = [ZenModel sharedInstance];
    int sec = [model seconds] % 60;
    int min = [model seconds] / 60;
    [self.duration selectRow:min inComponent:0 animated:NO];
    [self.duration selectRow:sec inComponent:1 animated:NO];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return component == 0 ? _minutes_data.count : _seconds_data.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return component == 0 ? [_minutes_data objectAtIndex: row] : [_seconds_data objectAtIndex: row];
}

- (IBAction)okAction:(id)sender {
    NSString *min = [_minutes_data objectAtIndex:[self.duration selectedRowInComponent:0]];
    NSString *sec = [_seconds_data objectAtIndex:[self.duration selectedRowInComponent:1]];
    int d = [min intValue] * 60 + [sec intValue];
    ZenModel *model = [ZenModel sharedInstance];
    [model setSeconds:d];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
