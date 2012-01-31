//
//  Tweet.h
//  NetworkingDemo
//
//  Created by Matthew Holden on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject


@property(strong, nonatomic) NSString *userName;
@property(strong, nonatomic) NSURL *userPhotoURL;
@property(strong, nonatomic) NSString *tweetText;
@property(strong, nonatomic) NSDate *tweetDate;

+(void)latestTweetFromUser:(NSString *)user andThen:(void (^)(Tweet *tweet))andThen;
+(void)latestTweetFromRandomUserAndThen:(void (^)(Tweet *tweet))andThen;

@end
