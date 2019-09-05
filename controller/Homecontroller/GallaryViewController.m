//
//  GallaryViewController.m
//  Collabtic
//
//  Created by mobile on 29/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "GallaryViewController.h"
#import "MWPhotoBrowser.h"
#import "gallaryTableViewCell.h"
#import "webtreadViewController.h"

@interface GallaryViewController ()
{
    MWPhotoBrowser *browser;
}

@end

@implementation GallaryViewController
@synthesize Images;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [Images count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"images%@",Images);
    static NSString *MyIdentifier = @"GallarytableID";
    
    gallaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[gallaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    if ([[[Images objectAtIndex:indexPath.row] valueForKey:@"flag_id"] intValue]==1) {
         [cell.image_gallary setImageURL:[NSURL URLWithString:[[Images objectAtIndex:indexPath.row] valueForKey:@"file_path"]]];
    }else if ([[[Images objectAtIndex:indexPath.row] valueForKey:@"flag_id"] intValue]==5 ||[[[Images objectAtIndex:indexPath.row] valueForKey:@"flag_id"] intValue]==4 ){
        
          [cell.image_gallary setImage:[UIImage imageNamed:@"office"]];
    }else if ([[[Images objectAtIndex:indexPath.row] valueForKey:@"flag_id"] intValue]==6){
          [cell.image_gallary setImage:[UIImage imageNamed:@"Link"]];
    }else if ([[[Images objectAtIndex:indexPath.row] valueForKey:@"flag_id"] intValue]==3){
        [cell.image_gallary setImage:[UIImage imageNamed:@"Audio"]];
         cell.button_play.hidden = NO;
    }else{
          [cell.image_gallary setImageURL:[NSURL URLWithString:[[Images objectAtIndex:indexPath.row] valueForKey:@"poster_image"]]];
        cell.button_play.hidden = NO;
    }
   
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"GallarytableID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    return cell.contentView.frame.size.height+10;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    MWPhoto *photo, *thumb;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = YES;
    BOOL autoPlayOnAppear = NO;

 if ([[[Images objectAtIndex:indexPath.row] valueForKey:@"flag_id"] intValue]==5 || [[[Images objectAtIndex:indexPath.row] valueForKey:@"flag_id"] intValue]==4 ||[[[Images objectAtIndex:indexPath.row] valueForKey:@"flag_id"] intValue]==6){
         UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
         webtreadViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"webtreadID"];
         ViewControllerObj.string = [[Images objectAtIndex:indexPath.row] valueForKey:@"file_path"];
         [self.navigationController pushViewController:ViewControllerObj animated:YES];
         
     }else {
         for (int i = 0; i< [Images count]; i++) {
             if ([[[Images objectAtIndex:i]valueForKey:@"flag_id"]intValue] ==1) {
                 photo = [MWPhoto photoWithURL:[NSURL URLWithString:[[Images objectAtIndex:i] valueForKey:@"file_path"]]];
                 
                 photo.caption = [NSString stringWithFormat:@"%@",[[Images objectAtIndex:i] valueForKey:@"original_file_name"]];
                  [photos addObject:photo];
                
             }else{
                 photo = [MWPhoto photoWithURL:[NSURL URLWithString:[[Images objectAtIndex:i] valueForKey:@"poster_image"]]];
                 photo.videoURL = [NSURL URLWithString:[[Images objectAtIndex:i] valueForKey:@"file_path"]];
                 photo.caption = [NSString stringWithFormat:@"%@",[[Images objectAtIndex:i] valueForKey:@"original_file_name"]];
                 [photos addObject:photo];
             }
             
         }
   
     
        self.photos = photos;
          self.thumbs = thumbs;
         MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
         browser.displayActionButton = displayActionButton;
         browser.displayNavArrows = displayNavArrows;
         browser.displaySelectionButtons = displaySelectionButtons;
         browser.alwaysShowControls = displaySelectionButtons;
         browser.zoomPhotosToFill = YES;
         browser.enableGrid = enableGrid;
         browser.startOnGrid = startOnGrid;
         browser.enableSwipeToDismiss = YES;
         browser.autoPlayOnAppear = autoPlayOnAppear;
         [browser showNextPhotoAnimated:YES];
         [browser showPreviousPhotoAnimated:YES];
         [browser setCurrentPhotoIndex:indexPath.row];
         UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
         nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
         [self presentViewController:nc animated:YES completion:nil];
         
//     UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
//     nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//     [self presentViewController:nc animated:YES completion:nil];
//
//
//
//         photo = [MWPhoto photoWithURL:[[NSURL alloc] initWithString:[[Images objectAtIndex:indexPath.row] valueForKey:@"poster_image"]]];
//         photo.videoURL = [[NSURL alloc] initWithString:[[Images objectAtIndex:indexPath.row] valueForKey:@"file_path"]];
//         [photos addObject:photo];
//
//         UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
//         nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//         self.photos = photos;
//         self.thumbs = thumbs;
//
 }
  //
  
 
    
    // Create browser

    
    // Test custom selection images
    //    browser.customImageSelectedIconName = @"ImageSelected.png";
    //    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    // Reset selections
    if (displaySelectionButtons) {
        _selections = [NSMutableArray new];
        for (int i = 0; i < photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    // Show
//    if (_segmentedControl.selectedSegmentIndex == 0) {
//        // Push
//        [self.navigationController pushViewController:browser animated:YES];
//    } else {
//        // Modal
//
//    }
    
    // Release
    
    // Deselect
   
    
    // Test reloading of data after delay
    double delayInSeconds = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        //        // Test removing an object
        //        [_photos removeLastObject];
        //        [browser reloadData];
        //
        //        // Test all new
        //        [_photos removeAllObjects];
        //        [_photos addObject:[MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
        //        [browser reloadData];
        //
        //        // Test changing photo index
        //        [browser setCurrentPhotoIndex:9];
        
        //        // Test updating selections
        //        _selections = [NSMutableArray new];
        //        for (int i = 0; i < [self numberOfPhotosInPhotoBrowser:browser]; i++) {
        //            [_selections addObject:[NSNumber numberWithBool:YES]];
        //        }
        //        [browser reloadData];
        
    });

   
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}
- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
- (IBAction)back_button:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
