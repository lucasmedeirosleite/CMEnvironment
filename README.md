# CMEnvironment

This project brings the idea of Environment variables to your iOS project in a nicely way.

##Contact:

Developed by [Lucas Medeiros](https://www.twitter.com/aspmedeiros) and [Alisson Sales](https://twitter.com/alissonsales) at [Codeminer42](http://www.codeminer42.com) in [Fortaleza](http://goo.gl/maps/EIAxy)

Follow us on twitter: [@Codeminer42](https://twitter.com/Codeminer42)

## Development requirements

* Cocoapods - https://github.com/CocoaPods/CocoaPods

## Install cocoapods

To install cocoapods you will need ruby.

	gem install cocoapods
	
More information about cocoapods:

* https://github.com/CocoaPods/CocoaPods
* http://nsscreencast.com/episodes/5-cocoapods

## Cocoapods

Add the dependency to your `Podfile`:

```ruby
platform :ios
pod 'CMEnvironment'
...
```
Run `pod install` to install the dependencies.

## Setup

* On your App-info.plist under the Information Property List put a key called Configuration with value ${CONFIGURATION}

* Create files Debug.plist, Release.plist, Adhoc.plist under the root path of your app

* Put your configuration values on your plists

* In your code create an objective-c class that inherits from CMEnvironment and create properties with the same key name of your plists keys

* See the example code

## Usage 

Inherit from CMEnvironment class and create properties with the same name of the key attribute of your plist. For example:

* If you have, on your Environment.plist, a key named baseURL with the value https://api.app.com, you can do this:

```objective-c

#import "CMEnvironment.h"

@interface CMAppEnvironment : CMEnvironment

@property (nonatomic, copy) NSString *baseURL;

@end

```

* The class and its methods:

```objective-c

@interface CMEnvironment : NSObject

@property (nonatomic, copy) NSString *name;

+ (id) sharedInstance; //returns a singleton instance using the application main bundle
- (id)initWithBundle:(NSBundle *)bundle;
- (BOOL)isDebug;
- (BOOL)isRelease;
- (void)changeToEnvironmenNamed:(NSString *)environment;

@end

```

## Requirements

`CMEnvironment` requires iOS 5.x or greater.

## The idea

The idea came from [this post](http://blog.carbonfive.com/2011/06/20/managing-ios-configurations-per-environment-in-xcode-4/) by [Rob Pak](http://blog.carbonfive.com/author/rpak/).

## License

Usage is provided under the [MIT License](http://http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.


