//
//  MessagesFeedViewController.m
//  MyMessageFeed
//
//  Created by Guillaume Dionisi on 6/22/17.
//  Copyright © 2017 MyGreenCar. All rights reserved.
//

#import "MessageCell.h"
#import "MessagesFeedViewController.h"
#import "AFHTTPSessionManager.h"
#import "UrlManager.h"

@interface MessagesFeedViewController () <UITableViewDelegate>

@property NSArray *messages; // the array which will receive the messages

@end

@implementation MessagesFeedViewController

#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 71;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAllMessages]; // gets all the messages from the API
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)getAllMessages {
    
    _messages = [[NSArray alloc] init];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager]; // the manager for the request
    
    NSString *url = [UrlManager getEndpointUrl:@"Messages"];
    
    [manager GET:url
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             _messages = responseObject;
             
             // sort the messages by date desc
             _messages = [_messages sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                 NSDate *first = [self getDateFromJSONString:[a objectForKey:@"date"]];
                 NSDate *second = [self getDateFromJSONString:[b objectForKey:@"date"]];
                 return [second compare:first];
             }];
             
             NSLog(@"messages: %@", _messages);
             [self.tableView reloadData]; // reload the Table View once the data has been loaded
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"failed to get the messages");
         }
     ];
    
    return _messages;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    
    NSDictionary *message = [_messages objectAtIndex:indexPath.row];
    NSString *text = [message objectForKey:@"text"]; // the message content
    NSString *user = [message objectForKey:@"user"]; // the user
    
    // for the date, we need to convert the json string to a date object first
    NSDate *dateObject = [self getDateFromJSONString:[message objectForKey:@"date"]];
    
    // then we want to convert it back into a nice displayable string
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    [newDateFormatter setDateFormat:@"HH:mm, MM/dd/yy"];
    NSString *date = [newDateFormatter stringFromDate:dateObject];
    
    cell.messageText.text = [text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    cell.messageAuthorAndDate.text = [NSString stringWithFormat:@"%@ at %@", user, date];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - Unwind from new message

- (IBAction)unwindToMessagesFeed:(UIStoryboardSegue *)segue {
}

#pragma mark - Helpers

- (NSDate *) getDateFromJSONString:(NSString *)dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"];
    NSDate *dateObject = [dateFormat dateFromString:dateString];
    return dateObject;
}

@end
