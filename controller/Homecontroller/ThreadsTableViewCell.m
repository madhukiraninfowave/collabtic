//
//  ThreadsTableViewCell.m
//  Collabtic
//
//  Created by mobile on 02/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "ThreadsTableViewCell.h"

@implementation ThreadsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageview_profile.clipsToBounds = YES;
    self.imageview_profile.layer.cornerRadius = self.imageview_profile.frame.size.height/2;
    self.label_online.clipsToBounds = YES;
    self.label_online.layer.cornerRadius = self.label_online.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
