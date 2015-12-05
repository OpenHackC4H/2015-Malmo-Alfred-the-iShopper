//
//  AudioManager.m
//  alfred
//
//  Created by Sebastian Axelsen on 05/12/15.
//  Copyright © 2015 TeamYAY. All rights reserved.
//

#import "AudioManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioManager ()

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation AudioManager

static AudioManager *manager;

+(AudioManager *) sharedManager {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[AudioManager alloc] init];
    });
    return manager;
}

- (id) init {
    self = [super init];
    if(self) {
        //Do additional setup here
    }
    
    return self;
}

- (void) playSoundForFileURL:(NSURL *) fileURL withDelegate:(id) delegate {
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
                                                                  error:nil];
    self.audioPlayer.delegate = delegate;
    [self.audioPlayer play];
}


@end
