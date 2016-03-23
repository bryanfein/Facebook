//
//  ViewController.m
//  Facebook
//
//  Created by Bryan Fein on 8/17/15.
//  Copyright (c) 2015 Bryan Fein. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Social/Social.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    loginButton.readPermissions = @[@"email"];
    [self.view addSubview:loginButton];

    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@ email: %@", result,result[@"email"]);
             }
         }];
    }
}

- (IBAction)facebook_button:(id)sender {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [fbSheetOBJ setInitialText:@"TurnToTech - NYC"];
        [fbSheetOBJ addURL:[NSURL URLWithString:@"http://turntotech.io"]];
        
        [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
    }
    
}


@end
