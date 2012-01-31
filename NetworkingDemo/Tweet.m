//
//  Tweet.m
//  NetworkingDemo
//
//  Created by Matthew Holden on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tweet.h"
#import "AFJSONRequestOperation.h"

@implementation Tweet

@synthesize userName = _userName;
@synthesize userPhotoURL = _userPhotoURL;
@synthesize tweetText = _tweetText;
@synthesize tweetDate = _tweetDate;


+(void)latestTweetFromUser:(NSString *)user andThen:(void (^)(Tweet *tweet))andThen
{
	//Where are we going to ask Twitter for information?
	NSString *url;
	if (user != nil) { 	
		//if we are asking about a specific person...
		url = [NSString stringWithFormat:@"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@&count=1", user];
	} else { 
		//otherwise, grab a random person...
		url = @"https://api.twitter.com/1/statuses/public_timeline.json?count=1";
	}
	
	//build NSURLRequest
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	
	//Use sweet-a$$ AFJSONRequestOperation to get a tweet:
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
				
		//we're only looking at the first tweet that comes back over the wire!
		NSArray *thisTweet = [JSON objectAtIndex:0];						
		
		//make a new simple "Tweet" object
		Tweet *tweet = [[Tweet alloc] init];
		
		//populate it with properties from the returned JSON data
		tweet.userName = [NSString stringWithFormat:@"@%@",[thisTweet valueForKeyPath:@"user.screen_name"]];
		tweet.tweetText = [thisTweet valueForKeyPath:@"text"];
		
		//get the user's photo url, make an NSURL out of it
		NSString *urlString = [NSString stringWithFormat:@"http://api.twitter.com/1/users/profile_image/%@?size=bigger", tweet.userName]; 
		tweet.userPhotoURL = [NSURL URLWithString:urlString];

		
		/*NOTE!!
		 A top priority in refactoring this would be to wait for the user's photo to load as well, instead of calling andThen() right now.
		 Currently the app will show the tweet text -- the photo will download and display just moments later.
		 It's tacky.
		*/
		
		//call the function block we passed in, pass it the new tweet object
		andThen(tweet);
			
	} failure:nil];
	
	//start the NSOperation!
	[operation start];

}

//Helper method. all it does is call latestTweetFromUser:andThen: by pissing in a nil value for username
+(void)latestTweetFromRandomUserAndThen:(void (^)(Tweet *))andThen
{
	[Tweet latestTweetFromUser:nil andThen:andThen];
}



@end
