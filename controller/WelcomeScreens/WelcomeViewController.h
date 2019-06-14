//
//  WelcomeViewController.h
//  project
//
//  Created by Yuvarani on 05/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WebUrl.h"

@interface WelcomeViewController : UIViewController{
     NSTimer*timer;
}
   
@property (weak, nonatomic) IBOutlet UIScrollView *scrollviewImages;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_background;
-(void)ReceivedSpashscreen:(NSDictionary *)serverDic statusCode:(int)statusCode;

@property (strong, nonatomic) IBOutlet UIButton *button_Next;

@end
