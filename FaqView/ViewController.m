//
//  ViewController.m
//  FaqView
//
//  Created by IRSHAD PC on 21/01/17.
//  Copyright © 2017 IRSHAD PC. All rights reserved.
//

#import "ViewController.h"
#import "ExpnadTableViewCell.h"

static NSString * const kBookCellIdentifier = @"ExpandCellIdentifier";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *faqDescription;
@property (strong, nonatomic) NSArray *faqTitles;
@property (strong, nonatomic) NSMutableSet *expandedIndexPaths;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([ExpnadTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:kBookCellIdentifier];
    self.expandedIndexPaths = [NSMutableSet set];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50.f;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.title = @"FAQ View";
    
    if (!_faqDescription) {
        _faqDescription = @{
                              @"What is reddit?": @"reddit is a source for what's new and popular on the web. Users like you provide all of the content and decide, through voting, what's good and what's junk. Links that receive community approval bubble up towards #1, so the front page is constantly in motion and (hopefully) filled with fresh, interesting links.",
                              @"A Tale of Two Cities": @"It was the best of times, when Mr. Dickens loved rhymes.",
                              @"A Tree Grows in Brooklyn": @"Also, a young author grows up in Brooklyn.",
                              @"Test expand and collapse table view" : @"This sample project shows how to implement Expandable/Collapsable TableView in iOS.",
                              @"Great Gatsby" : @"The book that inspired thousands of obliviously themed parties!",
                              };
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpnadTableViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:kBookCellIdentifier];
    NSString *title = self.bookTitles[indexPath.row];
    cell.titleLabel.text = title;
    cell.DescriptionLabel.text = self.faqDescription[title];
    cell.withDetails = [self.expandedIndexPaths containsObject:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.expandedIndexPaths containsObject:indexPath]) {
        ExpnadTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
        [cell animateClosed];
        [self.expandedIndexPaths removeObject:indexPath];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        [self.expandedIndexPaths addObject:indexPath];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        ExpnadTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
        [cell animateOpen];
    }
}
#pragma mark - Private

- (NSArray *)bookTitles {
    if (!_faqTitles) {
        _faqTitles = [self.faqDescription allKeys];
    }
    return _faqTitles;
}
@end
