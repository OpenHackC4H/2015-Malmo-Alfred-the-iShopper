//
//  ViewController.h
//  alfred
//
//  Created by Sebastian Axelsen on 04/12/15.
//  Copyright © 2015 TeamYAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ASIHTTPRequest/ASIHTTPRequestDelegate.h>

@interface MainVoiceViewController : UIViewController <ASIHTTPRequestDelegate>


@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

- (IBAction)voiceButtonPressed:(id)sender;


@end

