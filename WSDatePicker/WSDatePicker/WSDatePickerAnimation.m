//
//  WSDatePickerAnimation.m
//  Pods
//
//  Created by winter on 16/8/22.
//
//

#import "WSDatePickerAnimation.h"

@implementation WSDatePickerAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return .8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //CGRect screenBounds = [UIScreen mainScreen].bounds;
    //CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    UIView *mirrorView = [[transitionContext viewForKey:UITransitionContextFromViewKey] snapshotViewAfterScreenUpdates:NO];
    
    [[transitionContext viewForKey:UITransitionContextFromViewKey] setHidden:YES];
    
    UIView *container = [transitionContext containerView];
    [container addSubview:mirrorView];
    [container addSubview:toVC.view];
    
    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        CGSize size = [UIScreen mainScreen].bounds.size;
        mirrorView.frame = CGRectMake(size.width*0.1, size.height*0.1, size.width*0.8, size.height*0.8);
        UIView *view = [toVC.view viewWithTag:1000];
        //[UIView animateWithDuration:.5 animations:^{
        if(view)
            [view setFrame:CGRectMake(0, size.height - 240, size.width, 240)];
        //} completion:nil];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        [[transitionContext viewForKey:UITransitionContextFromViewKey] setHidden:NO];
    }];
//    [UIView animateWithDuration:duration
//                          delay:0.0
//         usingSpringWithDamping:0.6
//          initialSpringVelocity:0.0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         //[imgView setTransform:CGAffineTransformMakeScale(.8, .8)];
//                         CGSize size = [UIScreen mainScreen].bounds.size;
//                         imgView.frame = CGRectMake(size.width*0.1, size.height*0.1, size.width*0.8, size.height*0.8);
//                         toVC.view.frame = finalFrame;
//                     } completion:^(BOOL finished) {
//                         // 5. Tell context that we completed.
//                         [transitionContext completeTransition:YES];
//                     }];
}


@end
