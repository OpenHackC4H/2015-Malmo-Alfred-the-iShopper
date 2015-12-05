//
//  AudioManagerTest.m
//  alfred
//
//  Created by Sebastian Axelsen on 05/12/15.
//  Copyright © 2015 TeamYAY. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AudioManager.h"

@interface AudioManagerTest : XCTestCase

@property (nonatomic) AudioManager *audioManager;

@end

@implementation AudioManagerTest

- (void)setUp {
    [super setUp];
    
    self.audioManager = [AudioManager sharedManager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPlayAudioFile {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"bread_result" ofType: @"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    [self.audioManager playSoundForFileURL:soundFileURL withDelegate:nil];
    
}


@end
