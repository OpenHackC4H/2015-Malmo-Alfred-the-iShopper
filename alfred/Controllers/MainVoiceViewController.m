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
#import <ASIHTTPRequest/ASIHTTPRequest.h>


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
    [self postBeacons];
    [self uploadRecording];
}

- (void) getRecording {
    RestManager *restManager = [RestManager sharedManager];
    
    [restManager GET:@"/test" success:^(NSDictionary *result) {
        NSLog(@"Succesfully get requested recording. %@", [result description]);
    } failure:^(NSError *error) {
        NSLog(@"Error get requesting recording. %@", [error description]);
    }];
     
}

- (void) postBeacons {
    RestManager *restManager = [RestManager sharedManager];
    
    NSString *beaconString = @"[{\"id\":\"lsfdaksd\",\"distance\":\"12\",\"key\":\"bread\"},{\"id\":\"abc\", \"distance\":\"12\", \"key\":\"milk\"}]";
    NSData *beaconData = [beaconString dataUsingEncoding:NSUTF8StringEncoding];
    
    [restManager POST:@"/beacons" data:beaconData success:^(NSDictionary *result) {
        NSLog(@"Succesfully posted beacons");
    } failure:^(NSError *error) {
        NSLog(@"Failed posting of beacons. %@", [error description]);
    }];
}

- (void) uploadRecording {
    RestManager *restManager = [RestManager sharedManager];
    
    NSString *recordingPath = [[NSBundle mainBundle] pathForResource:@"bread_query" ofType: @"flac"];
    NSData *recordingData = [[NSFileManager defaultManager] contentsAtPath:recordingPath];
    
    [restManager upload:@"/speech-to-text/upload-speech" data:recordingData delegate:self];
}

- (void) recordInput {
    self.isRecording = YES;
    [self changeButtonImage];
}

- (void) playMockResult {
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"bread_result" ofType: @"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    [[AudioManager sharedManager] playSoundForFileURL:soundFileURL withDelegate:nil];
}

- (void) playResult:(NSData *) data {
    NSError *error;
    [[AudioManager sharedManager] playData:data delegate:nil];
    if(error) {
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *receivedString = [request responseString];
    NSLog(@"Upload request succeeded: %@", [receivedString description]);
    
    NSData *responseData = [request responseData];
    
    //[self playResult:responseData];
    [self playMockResult];
    self.isRecording = NO;
    [self changeButtonImage];
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    NSString *receivedString = [request responseString];
    NSLog(@"Upload request failed. Response: %@", receivedString);
    
    [self playError];
    self.isRecording = NO;
    [self changeButtonImage];

}

- (void) playError {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"alfred_error" ofType: @"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    [[AudioManager sharedManager] playSoundForFileURL:soundFileURL withDelegate:nil];

}


@end
