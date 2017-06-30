//
//  WriteMessageViewController.m
//  MyMessageFeed
//
//  Created by Guillaume Dionisi on 6/22/17.
//  Copyright © 2017 MyGreenCar. All rights reserved.
//

#import "UrlManager.h"
#import "AFHTTPSessionManager.h"
#import "WriteMessageViewController.h"
#import "MessagesFeedViewController.h"

@interface WriteMessageViewController ()
@property (weak, nonatomic) IBOutlet UITextView *messageText;

@end

@implementation WriteMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _messageText.layer.borderWidth = 1;
    _messageText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // called before the unwind segue is executed
    
    MessagesFeedViewController *feed = [segue destinationViewController];

    NSDictionary *content = @{
                              @"text": _messageText.text // the message to be sent
                              };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"testU" password:@"testP"]; // authenticate by Basic Auth
    
    NSString *url = [UrlManager getEndpointUrl:@"Messages"];

    [manager POST:url
       parameters:content
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSLog(@"response: %@", responseObject);
              [feed getAllMessages];
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"response: %@", error);
          }
     ];
}


@end
