//
//  DFUViewController.m
//  DFURTSPPlayer
//
//  Created by Bogdan Furdui on 3/7/13.
//  Copyright (c) 2013 Bogdan Furdui. All rights reserved.
//

#import "DFUViewController.h"
#import "RTSPPlayer.h"
#import "Utilities.h"

@interface DFUViewController ()
@property (nonatomic, retain) NSTimer *nextFrameTimer;
@end

@implementation DFUViewController

@synthesize imageView, label, playButton, video;
@synthesize nextFrameTimer = _nextFrameTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    
        //*** WE CALL FOR OPEN VIDEO AND INITIALIZATION PLAYER FUNCTION  ***//
        
      
    }
    
    return self;
}

- (void)dealloc
{
	[video release];
    video = nil;
    
	[imageView release];
    imageView = nil;
    
	[label release];
    label = nil;
    
	[playButton release];
    playButton = nil;

    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [imageView setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//=================== OPEN VIDEO FUNCTION ============================================
- (void) openVideoFunction {
    
    NSString *videoFilename          = @"loadfile";
    NSString *videoFilenameExtension = @"cgi";
    

    
    //*** HERE IS SAMPLE HOW TO OPEN STREAM HTTP VIDEO ****
    /*video = [[RTSPPlayer alloc] initWithVideo:@"http://112.65.235.145/vlive.qqvideo.tc.qq.com/v00113mzdsr.mp4?vkey=03BDF0A68787D1B7937B386F359603E71EB7DD4C2F924DCCD1A956178BAAD4C5B958596242EB5FF8&br=72&platform=0&fmt=mp4&level=3" usesTcp:NO];
     video.outputWidth = 426;
     video.outputHeight = 320;
     
     NSLog(@"video duration: %f",video.duration);
     NSLog(@"video size: %d x %d", video.sourceWidth, video.sourceHeight)*/
    
    
    
    
    //TODO: try to open file
    NSURL *urlFile = [[NSBundle mainBundle] URLForResource: videoFilename withExtension: videoFilenameExtension];
    NSString *stringFile = [NSString stringWithFormat:@"%@", urlFile];
    NSLog(@"URL равен ==  %@", urlFile);
    
    
    
    
    int *i = 0;
    while(i<1000){
        NSLog(@"%i", i);
        NSLog(@"@%", stringFile);
        i++;
    }
 
    video = [[RTSPPlayer alloc] initWithVideo:stringFile  usesTcp:NO];
    video.outputWidth = 426;
    video.outputHeight = 320;
    
    NSLog(@"video duration: %f",video.duration);
    NSLog(@"video size: %d x %d", video.sourceWidth, video.sourceHeight);
}//===========================================================================================





-(IBAction)playButtonAction:(id)sender {
    [self openVideoFunction];
    
//	[playButton setEnabled:NO];
//	lastFrameTime = -1;
//
//	// seek to 0.0 seconds
//	[video seekTime:0.0];             //TODO: DELETED!!!

    [_nextFrameTimer invalidate];
	self.nextFrameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30
                                                           target:self
                                                         selector:@selector(displayNextFrame:)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (IBAction)showTime:(id)sender
{
    NSLog(@"current time: %f s", video.currentTime);
}

#define LERP(A,B,C) ((A)*(1.0-C)+(B)*C)



//****   DISPLAYING NEXT FRAME   **********************************************//
-(void)displayNextFrame:(NSTimer *)timer
{
	NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
	if (![video stepFrame]) {
		[timer invalidate];
		[playButton setEnabled:YES];
        [video closeAudio];
		return;
	}
	imageView.image = video.currentImage;
	float frameTime = 1.0/([NSDate timeIntervalSinceReferenceDate]-startTime);
	if (lastFrameTime<0) {
		lastFrameTime = frameTime;
	} else {
		lastFrameTime = LERP(frameTime, lastFrameTime, 0.8);
	}
	[label setText:[NSString stringWithFormat:@"%.0f",lastFrameTime]];
}//***************************************************************************//
@end
