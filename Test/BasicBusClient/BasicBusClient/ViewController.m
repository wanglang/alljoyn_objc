////////////////////////////////////////////////////////////////////////////////
// Copyright 2012, Qualcomm Innovation Center, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
////////////////////////////////////////////////////////////////////////////////

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) bool isConnectedToService;

@end

@implementation ViewController

@synthesize eventsTextView = _eventsTextView;
@synthesize advertisedNameTextField = _advertisedNameTextField;
@synthesize isConnectedToService = _isConnectedToService;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [PingClient.sharedInstance setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchStartButton:(id)sender
{
    if (!self.isConnectedToService) {
        [PingClient.sharedInstance connectToService:self.advertisedNameTextField.text];
    }
}

#pragma mark - PingClientDelegate implementation

- (void)didConnectWithService:(NSString *)serviceName
{
    [self receivedStatusMessage:[NSString stringWithFormat:@"Successfully connected with the service named %@", serviceName]];
    
    self.isConnectedToService = true;
}

- (void)shouldDisconnectFromService:(NSString *)serviceName
{
    [self receivedStatusMessage:[NSString stringWithFormat:@"Disconnected from the service named %@", serviceName]];
    
    [PingClient.sharedInstance disconnect];
    
    self.isConnectedToService = false;
}

- (void)receivedStatusMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableString *string = self.eventsTextView.text.length ? [self.eventsTextView.text mutableCopy] : [[NSMutableString alloc] init];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle:NSDateFormatterMediumStyle];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [string appendFormat:@"[%@]\n",[formatter stringFromDate:[NSDate date]]];
        [string appendString:message];
        [string appendString:@"\n\n"];
        [self.eventsTextView setText:string];
        NSLog(@"%@",string);
        [self.eventsTextView scrollRangeToVisible:NSMakeRange([self.eventsTextView.text length], 0)];
    });
}

@end