//
//  forgotViewController.h
//  Collabtic
//
//  Created by Yuvarani on 11/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface forgotViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textfield_email;
- (IBAction)button_reset:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *button_reset;
- (IBAction)button_back:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *label_colered;

@end
