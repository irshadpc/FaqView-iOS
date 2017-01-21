//
//  UIView+Fold.h
//  FaqView
//
//  Created by IRSHAD PC on 21/01/17.
//  Copyright © 2017 IRSHAD PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Fold)

- (void)foldOpenWithTransparency:(BOOL)withTransparency
             withCompletionBlock:(void (^)(void))completionBlock;

- (void)foldClosedWithTransparency:(BOOL)withTransparency
               withCompletionBlock:(void (^)(void))completionBlock;

@end
