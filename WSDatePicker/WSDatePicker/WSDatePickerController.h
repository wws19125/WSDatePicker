//
//  WSDatePickerController.h
//  Pods
//
//  Created by winter on 16/8/22.
//
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, WSDatePickerType)
{
    /// 空白
    WSDatePickerTypeNone = 0,
    /// 年份
    WSDatePickerTypeYEAR = 1 << 0,
    /// 年月
    WSDatePickerTypeYEARANDMONTH = (1 << 0) + (1 << 1),
    /// 年月日
    WSDatePickerTypeYEARANDMONTHANDDAY = (1 << 0) + (1 << 1) + (1 << 2),
    /// 小时
    WSDatePickerTypeHOUR = 1 << 3,
    /// 分钟
    WSDatePickerTypeMINUTE = 1 << 4,
    /// 秒
    WSDatePickerTypeSECOND = 1 << 5
    
};


@interface WSDatePickerController : UIViewController

/// 选择器类型
@property(nonatomic,assign) WSDatePickerType pickerType;
@property(nonatomic,assign) NSInteger maxYear;
@property(nonatomic,assign) NSInteger minYear;
@property(nonatomic,assign) BOOL enableHistory;
@property(nonatomic,assign) BOOL enableFurture;
///默认选择
@property(nonatomic,assign) NSDate *defaultDate;

/// 已经选择的
@property(nonatomic,assign,readonly) NSInteger selectedYear;
@property(nonatomic,assign,readonly) NSInteger selectedMonth;
@property(nonatomic,assign,readonly) NSInteger selectedDay;
@property(nonatomic,assign,readonly) NSInteger selectedHour;
@property(nonatomic,assign,readonly) NSInteger selectedMinute;
@property(nonatomic,assign,readonly) NSInteger selectedSecond;

@property(nonatomic,assign,readonly) NSString *selectedDateStr;

@property(nonatomic,copy) void (^callback)(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger Minute,NSInteger second);

@end
