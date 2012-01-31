//
//  oneTweetViewController.m
//  NetworkingDemo
//
//  Created by Matthew Holden on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "oneTweetViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

//private methods
@interface OneTweetViewController (hidden)
-(void)loadTweetForUser:(NSString*)user;
@end


@implementation OneTweetViewController
@synthesize userName;
@synthesize userImage;
@synthesize tweetText;
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	//clear stuff pre-populated by the nib file
	[[self tweetText] setText:@""];
	[[self userName] setText:@""];
	
	
	//start with me
	[self loadTweetForUser:@"matthewevholden"];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[self setUserImage:nil];
	[self setUserName:nil];
	[self setTweetText:nil];
	[self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)loadTweetForUser:(NSString *)user
{
	//hide the tweet text, show activity indictator
	[tweetText setHidden:YES];
	[userImage setHidden:YES];
	[activityIndicator setHidden:NO];
	
	//get the latest tweet from a user... then show that tweet's information on-screen
	[Tweet latestTweetFromUser:user andThen:^(Tweet *tweet) {
		self.tweetText.text = tweet.tweetText;
		[self.userImage setImageWithURL:tweet.userPhotoURL];
		self.userName.text = tweet.userName;
		
		[tweetText setHidden:NO];
		[userImage setHidden:NO];
		[activityIndicator setHidden:YES];
	}];
}

- (IBAction)userTappedChangeTweeter:(id)sender 
{
	[self loadTweetForUser:nil];
}
@end
