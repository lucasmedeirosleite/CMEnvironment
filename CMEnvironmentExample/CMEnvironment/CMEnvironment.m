//
//  CMEnvironment.m
//
//  Created by Lucas Medeiros on 14/01/13.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMEnvironment.h"
#import "NSDictionary+TRVSUnderscoreCamelCaseAdditions.h"

@interface CMEnvironment() {
    NSDictionary *_environmentDictionary; // dictionary from Debug.plist or Release.plist or Whatever.plist 
}
@end

@implementation CMEnvironment

+ (instancetype) sharedInstance
{
    static CMEnvironment *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[[self class] alloc] initWithBundle:[NSBundle mainBundle]];
    });
    
    return __sharedInstance;
}

- (instancetype)initWithBundle:(NSBundle *)bundle
{
    self = [super init];
    if (self) {
        [self checkPreConditionsFor:bundle];
        [self setValuesForBundle:bundle];
        [self populateProperties];
    }
    return self;
}

- (void)changeToEnvironmenNamed:(NSString *)environment
{
    NSBundle *bundle = [NSBundle mainBundle];
    [self checkPreConditionsFor:bundle];
    [self setValuesForBundle:bundle withEnvironmentNamed:environment];
    [self populateProperties];
}

- (void)checkPreConditionsFor:(NSBundle *)bundle
{
    // Check if a bundle was passed
    if (bundle == nil) {
        @throw([NSException exceptionWithName:@"NoBundleException" reason:@"You must specify a bundle" userInfo:nil]);
    }
    
    // Check if App-info.plist has a key called Configuration (it must have the value ${CONFIGURATION})
    if ([[bundle infoDictionary] objectForKey:@"Configuration"] == nil) {
        @throw([NSException exceptionWithName:@"NoConfigurationOnPlistException"
                                       reason:@"You must have a key called Configuration with the value ${CONFIGURATION} on your app info plist"
                                     userInfo:nil]);
    }
    
}

- (void)setValuesForBundle:(NSBundle *)bundle
{
    // Set current environment name Ex: Debug, Release, Whatever
    _name = [[bundle infoDictionary] objectForKey:@"Configuration"];
    [self createPlistDictionaryFor:bundle];
}

- (void)setValuesForBundle:(NSBundle *)bundle withEnvironmentNamed:(NSString *)environment
{
    _name = environment;
    [self createPlistDictionaryFor:bundle];
}

- (void)createPlistDictionaryFor:(NSBundle *)bundle
{
    NSString *plistPath = [bundle pathForResource:_name ofType:@"plist"];

    //Check if Debug.plist or Release.plist or Whaterver.plist exists
    if (plistPath == nil) {
        @throw([NSException exceptionWithName:@"NoConfigurationPlistException"
                                       reason:@"You must have a plist for each ${CONFIGURATION} of your app ex: with scheme on Debug you need to have a Debug.plist, for release Release.plist"
                                     userInfo:nil]);
    }
    _environmentDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
}

- (void)populateProperties
{
    if ([[self class] isSubclassOfClass:[CMEnvironment class]]) {
        for (NSString *key in [self iVarsForEnvironmentDictionary]) {
            [self setEnvironmentPropertyWithName:key];
        }
    }
}

- (void)setEnvironmentPropertyWithName:(NSString *)propertyName
{
    @try {
        [self setValue:[_environmentDictionary objectForKey:propertyName] forKey:propertyName];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

- (NSArray *) iVarsForEnvironmentDictionary
{
    return [_environmentDictionary allKeys];
}

- (BOOL)isDebug
{
    return [_name isEqualToString:@"Debug"];
}

- (BOOL)isRelease
{
    return [_name isEqualToString:@"Release"];
}

@end
