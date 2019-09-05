//
//  tearmsViewController.h
//  Collabtic
//
//  Created by mobile on 12/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface tearmsViewController : UIViewController
- (IBAction)button_Cancle:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *button_tearms;
@property (strong, nonatomic) IBOutlet UIButton *button_privacy;
- (IBAction)button_tearms:(UIButton *)sender;
- (IBAction)button_privacy:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
