//
//  AppDelegate.h
//  Collabtic
//
//  Created by Yuvarani on 06/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DACircularProgressView.h"
#import "Reachability.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>{
      Reachability * internetReach;
     DACircularProgressView *progressView;
     NSTimer *timer;
}
@property (strong, nonatomic)NSString *loginID;
@property (strong, nonatomic)NSString *businessName;
@property (strong, nonatomic)NSString *businessLogo;
@property (strong, nonatomic)NSString *businessMailid;
@property (strong, nonatomic)NSString *passWord;
@property (strong, nonatomic)UIImage *pickedImage;
@property (strong, nonatomic)NSURL *pickedImageUrl;
@property (nonatomic, assign)BOOL checkbutton,loginStatus;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)UIView *loaderView;
@property () BOOL restrictRotation;
@property(nonatomic,readwrite)NSInteger internetWorking;


-(void)ReceivedErrorData:(NSError *)ServerErrorDict;
- (void)checkNetworkStatus:(NSNotification *)notice;
@property(nonatomic,strong)UIActivityIndicatorView *activityIndicator;


@end

