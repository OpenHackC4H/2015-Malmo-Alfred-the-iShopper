//
//  AudioManager.h
//  alfred
//
//  Created by Sebastian Axelsen on 05/12/15.
//  Copyright © 2015 TeamYAY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioManager : NSObject

+(AudioManager *) sharedManager;

- (void) playSoundForFileURL:(NSURL *) fileURL withDelegate:(id) delegate;

- (void) playData:(NSData *) data delegate:(id) delegate;

@end
