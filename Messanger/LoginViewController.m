//
//  LoginViewController.m
//  Messanger
//
//  Created by Anish Kodeboyina on 12/25/15.
//  Copyright © 2015 Anish Kodeboyina. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property(nonatomic,strong) NSString *usernameText;
@property(nonatomic,strong) NSString *passwordText;
@end

static NSString *const loginToHomeScreenSegueID= @"loginToHomeSegueID";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

#pragma mark - webservice url calling
- (void)urlCalling
{
    NSString *usernameAndPassword = [[NSString alloc]initWithFormat:@"http://192.168.0.2:8888/Messenger/checkLogin.php?username=%@&password=%@",self.usernameText,self.passwordText];

    NSURL *url = [NSURL URLWithString:usernameAndPassword];

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error)
    {
        NSString * dataConversionString = [[NSString alloc] initWithData:data
                                                                encoding:NSUTF8StringEncoding];
        NSLog(@"Data is : %@", dataConversionString);
        
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        NSArray* dataReceivingArray = [json objectForKey:@"Data"];
        NSLog(@"Data: %@", dataReceivingArray);
        NSLog(@"Data: %@", json);
        NSString *valueForStatus = [json valueForKey:@"status"];
        NSInteger statusValue = [valueForStatus integerValue];
        NSLog(@"value: %@", [json valueForKey:@"status"]);
        if (statusValue == 1)
        {
            [self goToHomeScreen];
        }
        else
        {
            [self displayAlertMessageWithTitle:@"Login Failed"
                                       message:@"Your username and password do not match. Please try again...!"];
        }
    }] resume];

    NSLog(@"user entered username is %@",self.usernameText);
    NSLog(@"user entered password is %@",self.passwordText);
    NSLog(@"username&Password %@", usernameAndPassword);
}

#pragma mark - First Responder Resign
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - IBAction Login Button Pressed By User
- (IBAction)userPressedLoginButton:(id)sender {

    if(self.userEnteredUserName.text.length > 0 && self.userEnteredPassword.text.length > 0)
    {
        self.usernameText = self.userEnteredUserName.text;
        self.passwordText = self.userEnteredPassword.text;
        self.userEnteredUserName.text = self.userEnteredPassword.text = @"";
        [self urlCalling];
    }
    else
    {
        [self displayAlertMessageWithTitle:@"Error"
                                   message:@"Please provide both username and password"];
    }
}

#pragma mark - Create segue to Home screen
-(void) goToHomeScreen {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:loginToHomeScreenSegueID sender:self];
    });
}

@end
