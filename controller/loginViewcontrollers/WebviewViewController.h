//
//  WebviewViewController.h
//  Collabtic
//
//  Created by mobile on 12/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebviewViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label_Headline;
@property (strong, nonatomic) IBOutlet UIButton *button_close;
- (IBAction)button_close:(UIButton *)sender;
@property(nonatomic,strong)NSString*typeString;

@property (strong, nonatomic) IBOutlet UIWebView *webview_tearmcondition;

@end

NS_ASSUME_NONNULL_END
