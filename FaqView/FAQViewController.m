//
//  ViewController.m
//  FaqView
//
//  Created by IRSHAD PC on 21/01/17.
//  Copyright © 2017 IRSHAD PC. All rights reserved.
//

#import "FAQViewController.h"
#import "ExpnadTableViewCell.h"
#import "FAQItem.h"

static NSString * const kBookCellIdentifier = @"ExpandCellIdentifier";

@interface FAQViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *faqDescription;
@property (strong, nonatomic) NSMutableSet *expandedIndexPaths;
@end

@implementation FAQViewController
@synthesize faqArray;

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
    faqArray = [[NSMutableArray alloc]init];
    self.title = @"FAQ View";
  
    if (!_faqDescription) {
        _faqDescription = @{
                              @"What is reddit?": @"reddit is a source for what's new and popular on the web. Users like you provide all of the content and decide, through voting, what's good and what's junk. Links that receive community approval bubble up towards #1, so the front page is constantly in motion and (hopefully) filled with fresh, interesting links.",
                              @"A Tale of Two Cities": @"It was the best of times, when Mr. Dickens loved rhymes.",
                              @"A Tree Grows in Brooklyn": @"Also, a young author grows up in Brooklyn.",
                              @"Test expand and collapse table view" : @"This sample project shows how to implement Expandable/Collapsable TableView in iOS.",
                              @"reddit is a source for what's new and popular on the web. Users like you provide all of the content and decide, through voting, what's good and what's junk. Links that receive community approval bubble up towards #1, so the front page is constantly in motion and (hopefully) filled with fresh, interesting links." : @"The book that inspired thousands of obliviously themed parties!",
                              };
    }

    
    
    [self setupFAQWithDictinary:_faqDescription];
}

#pragma mark FAQ Model Setup with Dictiinary Method

-(void)setupFAQWithDictinary:(NSDictionary *)dictnary{
    
    NSArray *allQuestions = [dictnary allKeys];
    [faqArray removeAllObjects];
    for (NSString *question in allQuestions) {
        FAQItem *objFaq = [[FAQItem alloc]init];
        objFaq.question = question;
        objFaq.answer = [dictnary valueForKey:question];
        [faqArray addObject:objFaq];
    }
    
}

#pragma mark FAQ Model Setup with Array Method

-(void)setupFAQWithArray:(NSArray *)question WithAnswer:(NSArray *)answer{
    [faqArray removeAllObjects];
    if (question.count == answer.count) {
        for (int i =0; i< question.count; i++) {
            FAQItem *objFaq = [[FAQItem alloc]init];
            objFaq.question = [question objectAtIndex:i];
            objFaq.answer = [answer objectAtIndex:i];
            [faqArray addObject:objFaq];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.faqArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpnadTableViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:kBookCellIdentifier];
    FAQItem *objFaq = [faqArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = objFaq.question;
    cell.DescriptionLabel.text = objFaq.answer;
    //cell.imageIcon.image = [UIImage imageNamed:@"expandGlyph"];
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
        
        if (self.expandedIndexPaths.allObjects.count > 0) {
            
            NSIndexPath *removeExisting = self.expandedIndexPaths.allObjects[0];
            ExpnadTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:removeExisting];
            [cell animateClosed];
            [self.expandedIndexPaths removeObject:removeExisting];
            [tableView reloadRowsAtIndexPaths:@[removeExisting] withRowAnimation:UITableViewRowAnimationNone];
            [self.expandedIndexPaths addObject:indexPath];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            cell = (id)[tableView cellForRowAtIndexPath:indexPath];
            [cell animateOpen];
        }
        else{
            [self.expandedIndexPaths addObject:indexPath];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            ExpnadTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
            [cell animateOpen];
        }
        
      
    }
}


@end
