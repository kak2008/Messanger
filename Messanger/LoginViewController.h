//
//  LoginViewController.h
//  Messanger
//
//  Created by Anish Kodeboyina on 12/25/15.
//  Copyright © 2015 Anish Kodeboyina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userEnteredUserName;
@property (weak, nonatomic) IBOutlet UITextField *userEnteredPassword;
- (IBAction)userPressedLoginButton:(id)sender;
@end

