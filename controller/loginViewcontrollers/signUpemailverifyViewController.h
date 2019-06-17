//
//  signUpemailverifyViewController.h
//  Collabtic
//
//  Created by mobile on 14/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"



NS_ASSUME_NONNULL_BEGIN

@interface signUpemailverifyViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label_SignUp;
@property (strong, nonatomic) IBOutlet AsyncImageView *Imageview_Profile;
@property (strong, nonatomic) IBOutlet UITextField *textfield_emailverify;
@property (strong, nonatomic) IBOutlet UIButton *button_go;
- (IBAction)buttonAction_go:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageview_Gallary;
@property (strong, nonatomic) IBOutlet UIButton *Button_profileimage;
- (IBAction)button_profileImage:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
