//
//  ThreadsTableViewCell.h
//  Collabtic
//
//  Created by mobile on 02/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "MCFireworksButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThreadsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_date;
@property (strong, nonatomic) IBOutlet AsyncImageView *imageview_profile;
@property (strong, nonatomic) IBOutlet UILabel *label_online;
@property (strong, nonatomic) IBOutlet MCFireworksButton *button_thumb;
@property (strong, nonatomic) IBOutlet UIView *view_container;
@property (strong, nonatomic) IBOutlet UILabel *label_edited;
@property (strong, nonatomic) IBOutlet UILabel *label_username;
@property (strong, nonatomic) IBOutlet UILabel *label_username2;
@property (strong, nonatomic) IBOutlet AsyncImageView *imageview_badge;
@property (strong, nonatomic) IBOutlet UILabel *label_make;
@property (strong, nonatomic) IBOutlet UILabel *label_title;
@property (strong, nonatomic) IBOutlet UILabel *label_description;
@property (strong, nonatomic) IBOutlet UIView *view_imagethubnails;
@property (strong, nonatomic) IBOutlet AsyncImageView *imageview_image1;
@property (strong, nonatomic) IBOutlet UILabel *label_imageview1;
@property (strong, nonatomic) IBOutlet AsyncImageView *imageview_image2;
@property (strong, nonatomic) IBOutlet UILabel *label_imageview2;
@property (strong, nonatomic) IBOutlet MCFireworksButton *button_share;
@property (strong, nonatomic) IBOutlet MCFireworksButton *button_pin;
@property (strong, nonatomic) IBOutlet UILabel *label_likes;
@property (strong, nonatomic) IBOutlet UILabel *label_pins;
@property (strong, nonatomic) IBOutlet UILabel *label_views;
@property (strong, nonatomic) IBOutlet UILabel *label_reply;
// mechine model related

@property (strong, nonatomic) IBOutlet UILabel *label_machinename;
@property (strong, nonatomic) IBOutlet UIImageView *imageview_machine;
@property (strong, nonatomic) IBOutlet UILabel *label_machineno;
@property (strong, nonatomic) IBOutlet UIImageView *imageview_machineDate;
@property (strong, nonatomic) IBOutlet UILabel *label_machineDate;
@property (strong, nonatomic) IBOutlet UILabel *label_fistline;
@property (strong, nonatomic) IBOutlet UILabel *label_baseline2;

@property (strong, nonatomic) IBOutlet UILabel *label_lastline3;
@property (strong, nonatomic) IBOutlet AsyncImageView *imageview_center;
@property (strong, nonatomic) IBOutlet UILabel *label_centerimage;

@property (strong, nonatomic) IBOutlet UIImageView *label_play;
@property (strong, nonatomic) IBOutlet UIImageView *lable_play2;

@end

NS_ASSUME_NONNULL_END
