//
//  ViewController.h
//  Collabtic
//
//  Created by Yuvarani on 06/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *button_newBusiness;
@property (weak, nonatomic) IBOutlet UIButton *button_createNew;

@property (weak, nonatomic) IBOutlet UIButton *button_logIN;
- (IBAction)Action_login:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *button_cancle;
- (IBAction)button_cancle:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *button_newUser;
- (IBAction)button_newuser:(UIButton *)sender;

@end

