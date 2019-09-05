//
//  webtreadViewController.h
//  Collabtic
//
//  Created by mobile on 29/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface webtreadViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webviewThread;
@property(nonatomic,strong)NSString * string;
- (IBAction)button_back:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
