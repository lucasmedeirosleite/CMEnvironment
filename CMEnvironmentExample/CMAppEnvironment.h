//
//  CMAppEnvironment.h
//  CMEnvironmentExample
//
//  Created by Lucas Medeiros on 14/01/13.
//  Copyright (c) 2013 Codeminer 42. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMEnvironment.h"

@interface CMAppEnvironment : CMEnvironment

@property (nonatomic, copy) NSString *codeURL;
@property (nonatomic, copy) NSNumber *codeNumber;

@end
