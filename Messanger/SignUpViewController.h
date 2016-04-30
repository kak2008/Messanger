//
//  SignUpViewController.h
//  Messanger
//
//  Created by Anish Kodeboyina on 12/25/15.
//  Copyright © 2015 Anish Kodeboyina. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userEnteredSignUpUsername;
@property (weak, nonatomic) IBOutlet UITextField *userEnteredSignUpPassword;
@property (weak, nonatomic) IBOutlet UITextField *userEnteredSignUpBirthdate;
@property (weak, nonatomic) IBOutlet UITextField *userEnteredSignUpName;
- (IBAction)doneButtonPressed:(id)sender;
@end
