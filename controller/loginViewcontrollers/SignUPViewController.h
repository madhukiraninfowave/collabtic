//
//  SignUPViewController.h
//  Collabtic
//
//  Created by mobile on 12/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUPViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic)IBOutlet AsyncImageView *imageview_signup;
@property (strong, nonatomic) IBOutlet UITextField *textfield_signup;

@property (strong, nonatomic) IBOutlet UIButton *button_check;
- (IBAction)button_check:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *button_terms;

- (IBAction)button_tearms:(UIButton *)sender;
- (IBAction)button_go:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *label_Emailline;
@property (strong, nonatomic) IBOutlet UILabel *label_linepswd;
@property (strong, nonatomic) IBOutlet UITextField *textfield_password;
@property (strong, nonatomic) IBOutlet UIButton *button_back;
- (IBAction)button_backAction:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet AsyncImageView *imageview_companyImage;
@property (nonatomic, strong)UIImage*profileImage;
@property (nonatomic,strong)NSString*businessLogo;
@property (nonatomic,strong)NSString*businessName;
@property (nonatomic,strong)NSString*businessMailid;

@property (strong, nonatomic) IBOutlet UILabel *label_signup;
- (IBAction)button_next:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *button_next;

@end

NS_ASSUME_NONNULL_END
