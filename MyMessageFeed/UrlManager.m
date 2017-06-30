//
//  UrlManager.m
//  MyMessageFeed
//
//  Created by Guillaume Dionisi on 6/22/17.
//  Copyright © 2017 MyGreenCar. All rights reserved.
//

#import "UrlManager.h"

@implementation UrlManager

+ (NSString *)getEndpointUrl:(NSString *)endpoint {
    // get the api url to access the specified endpoint
    
    NSString *urlsplistPath = [[NSBundle mainBundle] pathForResource:@"urls" ofType:@"plist"]; // plist file containing the urls
    NSDictionary *rootDictionary = [[NSDictionary alloc] initWithContentsOfFile:urlsplistPath]; // the root dictionnary in the file
    
    return [NSString stringWithFormat:@"%@%@", [rootDictionary objectForKey:@"Base"], [rootDictionary objectForKey:endpoint]];
}

@end
