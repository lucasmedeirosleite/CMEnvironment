# CMEnvironment

This project brings the idea of Environment variables to your iOS project in a nicely way.

##Contact:

Developed by [Lucas Medeiros](https://www.twitter.com/aspmedeiros) at [Codeminer42](http://www.codeminer42.com) in [Fortaleza](http://goo.gl/maps/EIAxy)

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

## Requirements

`CMEnvironment` requires iOS 5.x or greater.

## License

Usage is provided under the [MIT License](http://http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.


