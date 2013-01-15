//
//  CMEnvironment.h
//
//  Created by Lucas Medeiros on 14/01/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMEnvironment : NSObject

@property (nonatomic, copy) NSString *name;

+ (id) sharedInstance; //returns a singleton instance using the application main bundle
- (id)initWithBundle:(NSBundle *)bundle;

@end
