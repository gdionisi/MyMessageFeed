//
//  MessagesFeedViewController.h
//  MyMessageFeed
//
//  Created by Guillaume Dionisi on 6/22/17.
//  Copyright © 2017 MyGreenCar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesFeedViewController : UITableViewController 

- (IBAction)unwindToMessagesFeed:(UIStoryboardSegue *)segue;
- (void)getAllMessages;

@end
