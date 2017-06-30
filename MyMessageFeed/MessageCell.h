//
//  MessageCell.h
//  MyMessageFeed
//
//  Created by Guillaume Dionisi on 6/29/17.
//  Copyright © 2017 MyGreenCar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageText;
@property (weak, nonatomic) IBOutlet UILabel *messageAuthorAndDate;

@end
