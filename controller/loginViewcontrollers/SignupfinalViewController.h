//
//  SignupfinalViewController.h
//  Collabtic
//
//  Created by mobile on 15/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface SignupfinalViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet AsyncImageView *imagevie_profile;
@property (strong, nonatomic) IBOutlet UILabel *label_newuser;

@property (strong, nonatomic) IBOutlet UITextField *textfield_businessName;
@property (strong, nonatomic) IBOutlet UITextField *textfield_mailid;
@property (strong, nonatomic) IBOutlet UITextField *textfield_firstName;
@property (strong, nonatomic) IBOutlet UITextField *textfield_lastName;

@property (strong, nonatomic) IBOutlet UITextField *textfield_phoneNumber;
@property (strong, nonatomic) IBOutlet UIButton *button_back;
- (IBAction)button_back:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *label_fistName;
@property (strong, nonatomic) IBOutlet UILabel *label_lastName;
@property (strong, nonatomic) IBOutlet UILabel *label_phoneName;
@property(nonatomic,strong)UIImage*profileImage;

@end

NS_ASSUME_NONNULL_END
