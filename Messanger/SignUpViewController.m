//
//  SignUpViewController.m
//  Messanger
//
//  Created by Anish Kodeboyina on 12/25/15.
//  Copyright © 2015 Anish Kodeboyina. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()
@property(nonatomic,strong) NSString *signUpUsername;
@property(nonatomic,strong) NSString *signUpPassword;
@property(nonatomic,strong) NSString *signUpBirthdate;
@property(nonatomic,strong) NSString *signUpName;
@end

static NSString *const signupScreenToHomeScreenSegueID= @"signUpToHomeSegueID";

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"SignUp";
}

#pragma mark - Alert Display
- (void)displayAlertMessageWithTitle:(NSString *)alertTitle
                             message:(NSString *)alertMessage {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:alertTitle
                                                                        message:alertMessage
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    [self addOKActionForAlertController:controller];
    dispatch_async(dispatch_get_main_queue(), ^{
    [self presentViewController:controller
                       animated:YES
                     completion:nil];
    });
}

- (void)addOKActionForAlertController:(UIAlertController *)controller {
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [controller addAction:okAction];
}

#pragma mark - SignUp Page webservice url to store data
- (void)storeUserDataInWebServer
{
    NSString *userSignUpData = [[NSString alloc]initWithFormat:@"http://192.168.0.2:8888/Messenger/registerUser.php?name=%@&username=%@&password=%@&birthdate=%@",self.signUpName,self.signUpUsername,self.signUpPassword,self.signUpBirthdate];

    NSURL *signUpUrl = [NSURL URLWithString:userSignUpData];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:signUpUrl
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error)
      {
          NSString * dataConversionString = [[NSString alloc] initWithData:data
                                                                  encoding:NSUTF8StringEncoding];
          NSLog(@"Data is : %@", dataConversionString);
          NSDictionary* signUpJsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:kNilOptions
                                                                                 error:&error];
          NSArray* dataReceivingArray = [signUpJsonDictionary objectForKey:@"Data"];
          NSLog(@"Data: %@", dataReceivingArray);
          NSLog(@"Data: %@", signUpJsonDictionary);
          NSString *valueForStatus = [signUpJsonDictionary valueForKey:@"status"];
          NSInteger statusValue = [valueForStatus integerValue];
          NSLog(@"value: %@", [signUpJsonDictionary valueForKey:@"status"]);
          if (statusValue == 1)
          {
              [self homeScreenSegue];
          }
      }] resume];
}

#pragma mark - First Responder Resign
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - IBAction User Pressed Done Button
- (IBAction)doneButtonPressed:(id)sender
{
    if(self.userEnteredSignUpUsername.text.length > 0 &&
       self.userEnteredSignUpPassword.text.length > 0 &&
       self.userEnteredSignUpBirthdate.text.length > 0 &&
       self.userEnteredSignUpName.text.length >0)
    {
        self.signUpUsername     = self.userEnteredSignUpUsername.text;
        self.signUpPassword     = self.userEnteredSignUpPassword.text;
        self.signUpBirthdate    = self.userEnteredSignUpBirthdate.text;
        self.signUpName         = self.userEnteredSignUpName.text;
        self.userEnteredSignUpUsername.text = self.userEnteredSignUpPassword.text = self.userEnteredSignUpBirthdate.text = self.userEnteredSignUpName.text = @"";
        [self storeUserDataInWebServer];
    }
    else
    {
        [self displayAlertMessageWithTitle:@"Error"
                                   message:@"Please Provide all the information"];
    }
}

-(void) homeScreenSegue
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:signupScreenToHomeScreenSegueID
                                  sender:nil];
    });
}
@end
