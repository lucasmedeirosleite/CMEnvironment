//
//  CMEnvironment.h
//
//  Created by Lucas Medeiros on 14/01/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMEnvironment : NSObject

@property (nonatomic, copy) NSString *name;

+ (instancetype) sharedInstance; //returns a singleton instance using the application main bundle
- (instancetype)initWithBundle:(NSBundle *)bundle;
- (BOOL)isDebug;
- (BOOL)isRelease;
- (void)changeToEnvironmenNamed:(NSString *)environment;

@end
