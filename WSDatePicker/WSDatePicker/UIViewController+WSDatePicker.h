//
//  UIViewController+WSDatePicker.h
//  Pods
//
//  Created by winter on 16/8/22.
//
//

#import <Foundation/Foundation.h>

@interface UIViewController (WSDatePicker)   <UIViewControllerTransitioningDelegate>

////弹出日历选择，只能用这个方法弹出,否则没有效果
///
/// @params customerFlag 设置为true,动画效果
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion customerAnimated:(BOOL)customerFlag;

@end
