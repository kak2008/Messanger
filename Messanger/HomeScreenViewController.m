//
//  HomeScreenViewController.m
//  Messanger
//
//  Created by Vasanth Kodeboyina on 1/23/16.
//  Copyright © 2016 Anish Kodeboyina. All rights reserved.
//

#import "HomeScreenViewController.h"
@interface HomeScreenViewController ()
@property (nonatomic,strong) NSArray *jsonUsernameArray;
@end

@implementation HomeScreenViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    [self urlWebserviceCalling];
}

#pragma mark - Webservice calling
- (void) urlWebserviceCalling
{
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.0.2:8888/Messenger/getUsersList.php?"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error)
    {
      //  NSString *dataReceived = [[NSString alloc] initWithData:data
                                              //         encoding:NSUTF8StringEncoding];
       // NSLog(@"datareceived = %@",dataReceived);
        NSDictionary* jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:&error];
//        NSArray *dataReceivedArray = [jsonDictionary objectForKey:@"Data"];
//        NSLog(@"datareceivedarray = %@",dataReceivedArray);
        NSLog(@"json dictionary: %@",jsonDictionary);
        self.jsonUsernameArray = [jsonDictionary valueForKey:@"username"];
        NSLog(@"usernames: %@",self.jsonUsernameArray);
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.homeScreenTableView reloadData];
        });
    }] resume];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"No of rows: %ld", self.jsonUsernameArray.count);
    return self.jsonUsernameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HomeScreenTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.jsonUsernameArray[indexPath.row];
    NSLog(@"jsonArray data: %@", self.jsonUsernameArray[indexPath.row]);
    return cell;
}

@end
