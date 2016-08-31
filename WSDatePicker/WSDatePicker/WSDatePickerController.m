//
//  WSDatePickerController.m
//  Pods
//
//  Created by winter on 16/8/22.
//
//

#import "WSDatePickerController.h"


#define ScreenWdith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

/// 月份
#define WSDatePickerTypeMONTH  1 << 1
/// 日
#define WSDatePickerTypeDAY   1 << 2

@interface WSDatePickerController () <UIPickerViewDataSource,UIPickerViewDelegate>
{
    int selectedConValue[6];
    int compontCount[6];
}

@property(nonatomic,strong) UIPickerView *picker;
@property(nonatomic,strong) UIView *dateBoard;
@property(nonatomic,strong) UIView *operationBox;

//@property(nonatomic,strong) NSArray *compontCount;



@end


@implementation WSDatePickerController

#pragma mark - inherit && lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [btn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.2]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self dateBoard];
    [self picker];
    [self operationBox];
    /// observe pickerType
    [self addObserver:self forKeyPath:@"pickerType" options:0 context:nil];
    //compontCount = {20,12,31,24,60,60};//@[@20,@12,@31,@24,@60,@60];
    compontCount[0] = 20;
    compontCount[1] = 12;
    compontCount[2] = 31;
    compontCount[3] = 24;
    compontCount[4] = 60;
    compontCount[5] = 60;
    if(!self.defaultDate)
        self.defaultDate = [NSDate new];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"pickerType"])
    {
        [self.picker reloadAllComponents];
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"pickerType"];
}

#pragma mark - other operation



- (void)btnTaped:(UIButton *)sender
{
    if(sender.tag==1001)
    {
        if(self.callback)
            self.callback(self.selectedYear,self.selectedMonth,self.selectedDay,self.selectedHour,self.selectedMinute,self.selectedSecond);
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)parseDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
    selectedConValue[0] = (int)comp.year;
    selectedConValue[1] = (int)comp.month;
    selectedConValue[2] = (int)comp.day;
    selectedConValue[3] = (int)comp.hour;
    selectedConValue[4] = (int)comp.minute;
    selectedConValue[5] = (int)comp.second;

    if(self.maxYear == 0)
    {
        self.maxYear = self.selectedYear+10;
    }
    if(self.minYear == 0)
    {
        self.minYear = self.selectedYear - 10;
    }
    ///解决天问题
    if(self.pickerType & WSDatePickerTypeMONTH && self.pickerType & WSDatePickerTypeYEAR && self.selectedMonth == 2)
    {
        if([self isLeapYear:self.selectedYear])
        {
            compontCount[2] = 29;
        }
        else
            compontCount[2] = 28;
    }
    else
    {
        switch (self.selectedMonth) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                compontCount[2] = 31;
                break;
            default:
                compontCount[2] = 30;
                break;
        }
    }
    
    
    [self.picker reloadAllComponents];
    NSInteger count = self.picker.numberOfComponents;
    NSInteger index = -1;
    if(self.pickerType & WSDatePickerTypeYEAR)
    {
        if(self.maxYear>self.selectedYear)
        {
            if(self.maxYear>self.selectedYear+200)
            {
                self.maxYear = self.selectedYear + 200;
            }
        }
        else
        {
            self.maxYear = self.selectedYear;
        }
        if(self.minYear > self.selectedYear)
        {
            self.minYear = self.selectedYear;
        }
        else
        {
            if(self.minYear < 1972)
            {
                self.minYear = 1972;
            }
        }
        for (int i=0; ; i++) {
            if(self.maxYear-i == self.selectedYear)
            {
                [self.picker selectRow:i inComponent:++index animated:YES];
                break;
            }
        }
    }
    if(index==count-1)return;
    //月份
    if(self.pickerType & WSDatePickerTypeMONTH)
    {
        [self.picker selectRow:self.selectedMonth-1 inComponent:++index animated:YES];
    }
    if(index==count-1)return;
    // 日
    if(self.pickerType & WSDatePickerTypeDAY)
    {
        [self.picker selectRow:self.selectedDay-1 inComponent:++index animated:YES];
    }
    if(index==count-1)return;
    //小时
    if(self.pickerType & WSDatePickerTypeHOUR)
    {
        [self.picker selectRow:self.selectedHour-1 inComponent:++index animated:YES];
    }
    if(index==count-1)return;
    // 分钟
    if(self.pickerType & WSDatePickerTypeMINUTE)
    {
        [self.picker selectRow:self.selectedMinute-1 inComponent:++index animated:YES];
    }
    if(index==count-1)return;
    // 秒
    if(self.pickerType & WSDatePickerTypeSECOND)
    {
        [self.picker selectRow:self.selectedSecond-1 inComponent:++index animated:YES];
    }
}

///是否是闰年
///
- (BOOL)isLeapYear:(NSInteger)year
{
    if(((year % 4 == 0) && (year % 100 != 0) )|| (year % 400 == 0) )
    {
        return YES;
    }
    return NO;
}

#pragma mark - datesource ** delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat count=0;
    //年
    if(self.pickerType & WSDatePickerTypeYEAR)
    {
        count += 4;
    }
    //月份
    if(self.pickerType & WSDatePickerTypeMONTH)
    {
        count += 3;
    }
    // 日
    if(self.pickerType & WSDatePickerTypeDAY)
    {
        count += 3;
    }
    //小时
    if(self.pickerType & WSDatePickerTypeHOUR)
    {
        count += 3;
    }
    // 分钟
    if(self.pickerType & WSDatePickerTypeMINUTE)
    {
        count += 3;
    }
    // 秒
    if(self.pickerType & WSDatePickerTypeSECOND)
    {
        count += 3;
    }
    
    CGFloat unit = (ScreenWdith-50)/count;
    
    NSInteger index = -1;
    for (int i = 0; i< 6;i++) {
        if(self.pickerType & (1 << i))
        {
            index ++;
        }
        if(index == component)
        {
            index = i;
            break;
        }
    }
    //NSLog(@"%f   %f  %d",count,unit,index);
    int lengthWidth[] = {4,3,3,3,3,3};
    return unit*lengthWidth[index];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger count = 0;
    for (int i = 0; i< 6;i++) {
        if(self.pickerType & (1 << i))
            count ++;
    }
    return count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger index = -1;
    for (int i = 0; i< 6;i++) {
        if(self.pickerType & (1 << i))
        {
            index ++;
        }
        if(index == component)
        {
            index = i;
            break;
        }
    }
    if(index==0)
    {
        ///年份
        return self.maxYear-self.minYear+1;
    }
    return compontCount[index];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSInteger index = -1;
    for (int i = 0; i< 6;i++) {
        if(self.pickerType & (1 << i))
        {
            index ++;
        }
        if(index == component)
        {
            index = i;
            break;
        }
    }
    if((1 << index) & WSDatePickerTypeYEAR)
    {
        return [NSString stringWithFormat:@"%d",(int)(self.maxYear-row)];
    }else
    {
        return [NSString stringWithFormat:@"%d",(int)row+1];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger index = -1;
    for (int i = 0; i< 6;i++) {
        if(self.pickerType & (1 << i))
        {
            index ++;
        }
        if(index == component)
        {
            selectedConValue[i] = [[self pickerView:pickerView titleForRow:row forComponent:component] intValue];
            ///年月改动了
            if((WSDatePickerTypeYEAR&(1 << index)||WSDatePickerTypeMONTH&(1 << index))&&self.pickerType&WSDatePickerTypeDAY)
            {
                if(self.selectedMonth==2)
                {
                    ///闰年
                    if([self isLeapYear:self.selectedYear])
                    {
                        compontCount[2] = 29;
                    }
                    else
                    {
                        compontCount[2] = 28;
                    }
                }
                else if(WSDatePickerTypeMONTH&(1 << index))
                {
                    ///普通月份
                    switch (self.selectedMonth) {
                        case 1:
                        case 3:
                        case 5:
                        case 7:
                        case 8:
                        case 10:
                        case 12:
                            compontCount[2] = 31;
                            break;
                        default:
                            compontCount[2] = 30;
                            break;
                    }
                }
                ///更新日
                
                [self.picker reloadComponent:component+((WSDatePickerTypeYEAR&(1 << index))?2:1)];
                selectedConValue[2] = [[self pickerView:pickerView titleForRow:[self.picker selectedRowInComponent:component+((WSDatePickerTypeYEAR&(1 << index))?2:1)] forComponent:component+((WSDatePickerTypeYEAR&(1 << index))?2:1)] intValue];
            }
            break;
        }
    }
    
    
}

#pragma mark - getter and setter
- (UIPickerView *)picker
{
    if(!_picker)
    {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40,ScreenWdith, 200)];
        [_picker setDataSource:self];
        [_picker setDelegate:self];
        [self.dateBoard addSubview:_picker];
    }
    return _picker;
}

- (UIView *)operationBox
{
    if(!_operationBox)
    {
        _operationBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWdith, 40)];
        [_operationBox setBackgroundColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:.75]];
        [self.dateBoard addSubview:_operationBox];
        /// btn
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWdith-50, 0, 50, 40)];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnTaped:) forControlEvents:UIControlEventTouchUpInside];
        [_operationBox addSubview:btn];
        [btn setTag:1001];
    }
    return _operationBox;
}

- (UIView *)dateBoard
{
    if(!_dateBoard)
    {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _dateBoard = [[UIView alloc] initWithFrame:CGRectMake(0, size.height, size.width, 240)];
        [_dateBoard setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_dateBoard];
        [_dateBoard setTag:1000];
    }
    return _dateBoard;
}

- (void)setDefaultDate:(NSDate *)defaultDate
{
    _defaultDate = defaultDate;
    [self parseDate:_defaultDate];
}

- (NSInteger)selectedYear
{
    return selectedConValue[0];
}
- (NSInteger)selectedMonth
{
    return selectedConValue[1];
}

- (NSInteger)selectedDay
{
    return selectedConValue[2];
}
- (NSInteger)selectedHour
{
    return selectedConValue[3];
}

- (NSInteger)selectedMinute
{
    return selectedConValue[4];
}
- (NSInteger)selectedSecond
{
    return selectedConValue[5];
}
@end
