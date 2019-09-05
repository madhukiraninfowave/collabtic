//
//  detailsCollectionViewCell.h
//  Collabtic
//
//  Created by mobile on 20/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface detailsCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet AsyncImageView *imageview_collection;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (strong, nonatomic) IBOutlet UIView *view_temporary;

@end

NS_ASSUME_NONNULL_END
