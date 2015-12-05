//
//  ViewController.m
//  alfred
//
//  Created by Sebastian Axelsen on 04/12/15.
//  Copyright © 2015 TeamYAY. All rights reserved.
//

#import "MainVoiceViewController.h"

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
    self.isRecording = !self.isRecording;
    
    UIImage *buttonImage;
    
    if(self.isRecording) {
        buttonImage = [UIImage imageNamed:@"redButton"];
    } else {
        buttonImage = [UIImage imageNamed:@"greenButton"];
    }
    
    [self.voiceButton setImage:buttonImage forState:UIControlStateNormal];
}

#pragma mark - Actions

-(IBAction)voiceButtonPressed:(id)sender {
    NSLog(@"Voice button pressed");
    [self changeButtonImage];
    
    [self performSelector:@selector(changeButtonImage) withObject:nil afterDelay:TIME_DELAY];
    
}

@end
