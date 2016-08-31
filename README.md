# WSDatePicker

[![CI Status](http://img.shields.io/travis/wang/WSDatePicker.svg?style=flat)](https://travis-ci.org/wang/WSDatePicker)
[![Version](https://img.shields.io/cocoapods/v/WSDatePicker.svg?style=flat)](http://cocoapods.org/pods/WSDatePicker)
[![License](https://img.shields.io/cocoapods/l/WSDatePicker.svg?style=flat)](http://cocoapods.org/pods/WSDatePicker)
[![Platform](https://img.shields.io/cocoapods/p/WSDatePicker.svg?style=flat)](http://cocoapods.org/pods/WSDatePicker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

``` objc
    #import <WSDatePicker/WSDatePicer.h>

    /// instance
    WSDatePickerController *b = [WSDatePickerController new];
    /// set type as you like
    b.pickerType = WSDatePickerTypeYEARANDMONTHANDDAY;

    /// set default date
    NSDateFormatter *format = [NSDateFormatter new];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt = [format dateFromString:@"2016-12-12 12:12:12"];
    b.defaultDate = dt;
    
    ///callback block
    [b setCallback:^(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSLog(@"%d  %d  %d  %d  %d  %d",year,month,day,hour,minute,second);
    }];
    /// ok,last, present
    [self presentViewController:b animated:YES completion:nil customerAnimated:YES];

``` 


## Requirements

## Installation

WSDatePicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WSDatePicker"
```

## Author

王的世界, wws19125@126.com

## License

WSDatePicker is available under the MIT license. See the LICENSE file for more info.
