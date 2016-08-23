//
//  UIViewController+WSDatePicker.h
//  Pods
//
//  Created by winter on 16/8/22.
//
//

#import <Foundation/Foundation.h>

@interface UIViewController (WSDatePicker)   <UIViewControllerTransitioningDelegate>

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion customerAnimated:(BOOL)customerFlag;

@end
