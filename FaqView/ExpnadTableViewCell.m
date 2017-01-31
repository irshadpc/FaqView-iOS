//
//  ExpnadTableViewCell.m
//  FaqView
//
//  Created by IRSHAD PC on 21/01/17.
//  Copyright © 2017 IRSHAD PC. All rights reserved.
//

#import "ExpnadTableViewCell.h"
#import "UIView+Fold.h"


@interface ExpnadTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *titleContainer;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *detailContainerViewHeightConstraint;
@end

@implementation ExpnadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.withDetails = NO;
    self.backgroundView = nil;
    self.detailContainerViewHeightConstraint.constant = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark Set with details
- (void)setWithDetails:(BOOL)withDetails {
    _withDetails = withDetails;
    
    if (withDetails) {
        self.detailContainerViewHeightConstraint.priority = 250;
    } else {
        self.detailContainerViewHeightConstraint.priority = 999;
    }
}

#pragma mark Animated open cell

- (void)animateOpen {
    UIColor *originalBackgroundColor = self.contentView.backgroundColor;
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.detailContainerView foldOpenWithTransparency:YES
                                   withCompletionBlock:^{
                                      // _buttonIcon.imageView.image = [UIImage imageNamed:@"expandGlyphUp"];
                                        self.contentView.backgroundColor = originalBackgroundColor;
                                        _imageIcon.image = [UIImage imageNamed:@"expandGlyphUp"];
                                   }];
}

#pragma mark Animated closed cell

- (void)animateClosed {
    UIColor *originalBackgroundColor = self.contentView.backgroundColor;
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.detailContainerView foldClosedWithTransparency:YES withCompletionBlock:^{
        //_buttonIcon.imageView.image = [UIImage imageNamed:@"expandGlyph"];
        self.contentView.backgroundColor = originalBackgroundColor;
        _imageIcon.image = [UIImage imageNamed:@"expandGlyph"];
    }];
}

@end
