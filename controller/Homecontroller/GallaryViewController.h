//
//  GallaryViewController.h
//  Collabtic
//
//  Created by mobile on 29/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "AsyncImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GallaryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>{
    UISegmentedControl *_segmentedControl;
    NSMutableArray *_selections;
}
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic,strong)NSMutableArray *Images;
- (IBAction)back_button:(UIButton *)sender;



@end

NS_ASSUME_NONNULL_END
