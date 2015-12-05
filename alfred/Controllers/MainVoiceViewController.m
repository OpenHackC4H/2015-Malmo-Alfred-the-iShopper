//
//  ViewController.m
//  alfred
//
//  Created by Sebastian Axelsen on 04/12/15.
//  Copyright © 2015 TeamYAY. All rights reserved.
//

#import "MainVoiceViewController.h"
#import "AudioManager.h"
#import "RestManager.h"

#define TIME_DELAY 3.0

@interface MainVoiceViewController ()

@property BOOL isRecording;

@end

@implementation MainVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isRecording = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) changeButtonImage {
    UIImage *buttonImage;
    
    if(self.isRecording) {
        buttonImage = [UIImage imageNamed:@"redButton"];
    } else {
        buttonImage = [UIImage imageNamed:@"greenButton"];
    }
    
    [self.voiceButton setImage:buttonImage forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)voiceButtonPressed:(id)sender {
    [self recordInput];
    [self postRecording];
    [self performSelector:@selector(playResult) withObject:nil afterDelay:2.0];
}

- (void) postRecording {
    RestManager *restManager = [RestManager sharedManager];
    
    [restManager GET:@"/test" success:^(NSDictionary *result) {
        NSLog(@"Succesfully posted recording. %@", [result description]);
    } failure:^(NSError *error) {
        NSLog(@"Error posting recording. %@", [error description]);
    }];
     
}

- (void) recordInput {
    self.isRecording = YES;
    [self changeButtonImage];
}

- (void) playResult {
    self.isRecording = NO;
    [self changeButtonImage];
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"bread_result" ofType: @"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    [[AudioManager sharedManager] playSoundForFileURL:soundFileURL withDelegate:nil];
}

@end
