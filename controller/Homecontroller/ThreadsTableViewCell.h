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
@property (strong, nonatomic) IBOutlet UIImageView *imageview_badge;
@property (strong, nonatomic) IBOutlet UILabel *label_make;
@property (strong, nonatomic) IBOutlet UILabel *label_title;
@property (strong, nonatomic) IBOutlet UILabel *label_description;
@property (strong, nonatomic) IBOutlet UIView *view_imagethubnails;

@end

NS_ASSUME_NONNULL_END
