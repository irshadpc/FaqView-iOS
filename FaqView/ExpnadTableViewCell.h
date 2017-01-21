//
//  ExpnadTableViewCell.h
//  FaqView
//
//  Created by IRSHAD PC on 21/01/17.
//  Copyright © 2017 IRSHAD PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpnadTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *detailContainerView;

@property (nonatomic, assign) BOOL withDetails;

- (void)animateOpen;
- (void)animateClosed;

@end
