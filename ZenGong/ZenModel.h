//
//  ZenModel.h
//  ZenGong
//
//  Created by Damian Brunold on 23.10.14.
//  Copyright (c) 2014 Damian Brunold. All rights reserved.
//

#ifndef ZenGong_ZenModel_h
#define ZenGong_ZenModel_h

#import <Foundation/Foundation.h>

@interface ZenModel : NSObject <NSCoding>

+ (id)sharedInstance;

- (id)initWithSeconds: (int)seconds;

- (void)setSeconds: (int)seconds;

- (int)seconds;

- (void)start;

- (void)reset;

- (BOOL)started;

- (double)elapsed;

- (BOOL)expired;

- (BOOL)almostExpired;

- (NSDate*) expirationTime;

- (double)fraction;

- (NSString*)currentTime;

+ (NSString*)archivePath;

+ (void)loadData;

- (BOOL)saveData;

@end

#endif
