//
//  ZenModel.m
//  ZenGong
//
//  Created by Damian Brunold on 23.10.14.
//  Copyright (c) 2014 Damian Brunold. All rights reserved.
//

#import "ZenModel.h"

@implementation ZenModel {
    int _seconds;
    NSDate *_start;
}

static ZenModel *instance = nil;

+ (id)sharedInstance {
    if (!instance) {
        instance = [[[self class] alloc] initWithSeconds:720];
    }
    return instance;
}

- (id)initWithSeconds: (int)seconds {
    self = [super init];
    if (self) {
        _seconds = seconds;
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder  {
    [aCoder encodeObject:[NSNumber numberWithInt:_seconds] forKey:@"seconds"];
    [aCoder encodeObject:_start forKey:@"start"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSNumber *num = [aDecoder decodeObjectForKey:@"seconds"];
        if (num != nil) {
            _seconds = [num intValue];
        } else {
            _seconds = 720;
        }
        _start = [aDecoder decodeObjectForKey:@"start"];
    }
    return self;
}

- (void)setSeconds: (int)seconds {
    _seconds = seconds;
}

- (int)seconds {
    return _seconds;
}

- (void)start {
    _start = [[NSDate alloc] init];
}

- (void)reset {
    _start = nil;
}

- (BOOL)started {
    return _start != nil;
}

- (double)elapsed {
    if (_start == nil) return 0.0;
    NSDate *now = [[NSDate alloc] init];
    return fabs([now timeIntervalSinceDate: _start]);
}

- (NSDate*) expirationTime {
    return [_start dateByAddingTimeInterval: _seconds];
}

- (double)fraction {
    if (_start == nil) return 0.0;
    if (_seconds == 0) return 1.0;
    return [self elapsed] / _seconds;
}

- (BOOL)expired {
    return _start != nil && floor([self elapsed]) >= _seconds + 1;
}

- (BOOL)almostExpired {
    return _start != nil && floor([self elapsed]) >= _seconds;
}

- (NSString*)currentTime {
    int time = fmax(0, _seconds - [self elapsed]);
    return [NSString stringWithFormat:@"%d:%02d", time / 60, time % 60];
}

+ (NSString*)archivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"zen.model.archive"];
}

- (BOOL)saveData {
    return [NSKeyedArchiver archiveRootObject:self toFile:[ZenModel archivePath]];
}

+ (void)loadData {
    instance = [NSKeyedUnarchiver unarchiveObjectWithFile:[ZenModel archivePath]];
}

@end
