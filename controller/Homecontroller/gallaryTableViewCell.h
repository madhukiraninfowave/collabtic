//
//  gallaryTableViewCell.h
//  Collabtic
//
//  Created by mobile on 29/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface gallaryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *view_gallaryimage;
@property (strong, nonatomic) IBOutlet AsyncImageView *image_gallary;
@property (strong, nonatomic) IBOutlet UIImageView *button_play;

@end

NS_ASSUME_NONNULL_END
