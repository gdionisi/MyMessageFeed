//
//  UrlManager.h
//  MyMessageFeed
//
//  Created by Guillaume Dionisi on 6/22/17.
//  Copyright © 2017 MyGreenCar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlManager : NSObject

+ (NSString *)getEndpointUrl:(NSString *)endpoint;

@end
