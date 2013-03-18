#import "Kiwi.h"
#import "CMEnvironment.h"
#import "CMAppEnvironment.h"

SPEC_BEGIN(CMEnvironmentSpec)

describe(@"CMEnvironment", ^{
    
    __block CMEnvironment *environment;
    
    describe(@"#initWithBundle:", ^{
    
        context(@"when bundle is nil", ^{
        
            specify(^{
            
                [[theBlock(^{
                    CMEnvironment *environment = [[CMEnvironment alloc] initWithBundle:nil];
                    NSLog(@"%@", environment.name);
                }) should] raise];
                
                [[theBlock(^{
                    CMEnvironment *environment = [[CMEnvironment alloc] initWithBundle:nil];
                    NSLog(@"%@", environment.name);
                }) should] raiseWithName:@"NoBundleException"
                 reason:@"You must specify a bundle"];
                
            });
            
        });
        
        context(@"when there's no Configuration key pair in app plist", ^{
           
            specify(^{
                
                [[theBlock(^{
                   
                    NSBundle *bundle = [NSBundle nullMock];
                    [bundle stub:@selector(infoDictionary) andReturn:@{ }];
                    
                    CMEnvironment *environment = [[CMEnvironment alloc] initWithBundle:bundle];
                    NSLog(@"%@", environment.name);
                    
                }) should] raiseWithName:@"NoConfigurationOnPlistException"
                                  reason:@"You must have a key called Configuration with the value ${CONFIGURATION} on your app info plist"];
                
            });
            
        });
        
        context(@"when there's no Configuration plist", ^{
            
            specify(^{
                
                [[theBlock(^{
                    
                    NSBundle *bundle = [NSBundle nullMock];
                    [bundle stub:@selector(infoDictionary) andReturn:@{ @"Configuration" : @"Debug" }];
                    [bundle stub:@selector(pathForResource:ofType:) andReturn:nil];
                    
                    CMEnvironment *environment = [[CMEnvironment alloc] initWithBundle:bundle];
                    NSLog(@"%@", environment.name);
                    
                }) should] raiseWithName:@"NoConfigurationPlistException"
                 reason:@"You must have a plist for each ${CONFIGURATION} of your app ex: with scheme on Debug you need to have a Debug.plist, for release Release.plist"];
            });
            
        });
        
        context(@"when is in Debug", ^{
            
            __block NSBundle *bundle;
            
            beforeEach(^{
                bundle = [NSBundle nullMock];
                [bundle stub:@selector(infoDictionary) andReturn:@{ @"Configuration" : @"Debug" }];
                [bundle stub:@selector(pathForResource:ofType:) andReturn:@"Debug.plist"];
                environment = [[CMEnvironment alloc] initWithBundle:bundle];
            });
            
            specify(^{
                [[environment should] respondToSelector:@selector(name)];
            });
            
            specify(^{
                [[environment.name should] equal:@"Debug"];
            });
            
        });
        
        context(@"when is in Release", ^{
            
            __block NSBundle *bundle;
            
            beforeEach(^{
                bundle = [NSBundle nullMock];
                [bundle stub:@selector(infoDictionary) andReturn:@{ @"Configuration" : @"Release" }];
                [bundle stub:@selector(pathForResource:ofType:) andReturn:@"Release.plist"];
                environment = [[CMEnvironment alloc] initWithBundle:bundle];
            });
            
            specify(^{
                [[environment should] respondToSelector:@selector(name)];
            });
            
            specify(^{
                [[environment.name should] equal:@"Release"];
            });
            
        });
        
    });
    
    describe(@"#isDebug", ^{
        
        __block NSBundle *bundle;
        
        beforeEach(^{
            bundle = [NSBundle nullMock];
            [bundle stub:@selector(infoDictionary) andReturn:@{ @"Configuration" : @"Debug" }];
            [bundle stub:@selector(pathForResource:ofType:) andReturn:@"Debug.plist"];
            environment = [[CMEnvironment alloc] initWithBundle:bundle];
        });
        
        specify(^{
            [[environment should] respondToSelector:@selector(isDebug)];
        });
        
        specify(^{
            [[theValue([environment isDebug]) should] beTrue];
        });
        
    });
    
    describe(@"#isRelease", ^{
        
        __block NSBundle *bundle;
        
        beforeEach(^{
            bundle = [NSBundle nullMock];
            [bundle stub:@selector(infoDictionary) andReturn:@{ @"Configuration" : @"Release" }];
            [bundle stub:@selector(pathForResource:ofType:) andReturn:@"Release.plist"];
            environment = [[CMEnvironment alloc] initWithBundle:bundle];
        });
        
        specify(^{
            [[environment should] respondToSelector:@selector(isRelease)];
        });
        
        specify(^{
            [[theValue([environment isRelease]) should] beTrue];
        });
        
    });
    
});

describe(@"CMAppEnvironment", ^{
   
    describe(@"#initWithBundle:", ^{
       
        __block CMAppEnvironment *environment;
        beforeEach(^{
            environment = [[CMAppEnvironment alloc] initWithBundle:[NSBundle mainBundle]];
        });
        
        specify(^{
            [[environment should] beNonNil];
        });
        
        specify(^{
            [[environment.codeURL should] equal:@"www.codeminer42.com"];
        });
        
        specify(^{
            [[environment.codeNumber should] equal:[NSNumber numberWithInteger:10]];
        });
        
    });
    
    describe(@".sharedInstance", ^{
        
        __block CMAppEnvironment *environment;
        beforeEach(^{
            environment = [CMAppEnvironment sharedInstance];
        });
        
        specify(^{
            [[environment should] beNonNil];
        });
        
        specify(^{
            [[environment.codeURL should] equal:@"www.codeminer42.com"];
        });
        
        specify(^{
            [[environment.codeNumber should] equal:[NSNumber numberWithInteger:10]];
        });
        
    });
    
    describe(@"#changeToEnvironmenNamed:", ^{
        
        __block CMAppEnvironment *environment;
        beforeEach(^{
            environment = [CMAppEnvironment sharedInstance];
            [environment changeToEnvironmenNamed:@"Release"];
        });
        
        specify(^{
            [[environment.codeURL should] equal:@"www.google.com"];
        });
        
        specify(^{
            [[environment.codeNumber should] equal:[NSNumber numberWithInteger:5]];
        });
        
    });
    
});

SPEC_END