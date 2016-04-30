//
//  HomeScreenViewController.h
//  Messanger
//
//  Created by Vasanth Kodeboyina on 1/23/16.
//  Copyright © 2016 Anish Kodeboyina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScreenViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *homeScreenTableView;
@end
