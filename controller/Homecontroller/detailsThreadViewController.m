//
//  detailsThreadViewController.m
//  Collabtic
//
//  Created by mobile on 11/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "detailsThreadViewController.h"
//#import "detailThreadTableViewCell.h"
#import "detailsTableViewCell.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "UIView+Toast.h"
#import "WebUrl.h"
#import "Webservices.h"
#import "GallaryViewController.h"
#import "PopoverView.h"
#import <UIKit/UIKit.h>
#import <YangMingShan/UIViewController+YMSPhotoHelper.h>
#import <YangMingShan/YMSPhotoPickerViewController.h>
#import <YangMingShan/YMSPhotoPickerTheme.h>
#import <YangMingShan/YMSPhotoPickerTheme.h>
#import "DemoImageViewCell.h"
#import "GLAssetGridViewController.h"

#define kOFFSET_FOR_KEYBOARD 80.0
int returnPressed = 0;
int newLine,docHeight;
static NSString * const CellIdentifier = @"imageCellIdentifier";
@interface detailsThreadViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,detailsTableViewCell,UITextViewDelegate,MWPhotoBrowserDelegate,YMSPhotoPickerViewControllerDelegate,UITextFieldDelegate>

@end

@implementation detailsThreadViewController{

     NSMutableDictionary*heightAtIndexPath;
    NSMutableArray *ary_Threads;
    NSMutableArray *ary_details;
    NSMutableArray *array;
    AppDelegate *appDelegate;
   CGFloat height1,collectionHeight1 ;
    CGRect previousRect;
    CGRect TableHeight;
    NSMutableArray *_selections;
    NSMutableDictionary*Caption;
    UITapGestureRecognizer *singleFingerTap;
    BOOL clicked,Noscroll;
    int height;
    
   
    
}
@synthesize threadID,images;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.textfirld_caption.delegate = self;
    [self.textfirld_caption resignFirstResponder];
    heightAtIndexPath = [NSMutableDictionary new];
    Caption = [[NSMutableDictionary alloc]init];
    ary_Threads = [NSMutableArray new];
    ary_details = [NSMutableArray new];
     [self.view addSubview:appDelegate.loaderView];
    self.tableview_threadDetails.delegate = self;
    self.tableview_threadDetails.dataSource = self;
    TableHeight = self.tableview_threadDetails.frame;
    Noscroll = YES;
    TableHeight.size.height = self.view.frame.size.height;
    clicked = NO;
    self.tableview_threadDetails.estimatedRowHeight = 500;
    self.tableview_threadDetails.rowHeight = UITableViewAutomaticDimension;
    [self.tableview_threadDetails setNeedsLayout];
    [self.tableview_threadDetails layoutIfNeeded];
    self.doc.hidden = YES;
    previousRect = CGRectZero;
    
    _textview_Chat.delegate = self;
    
  _textview_Chat.layer.borderWidth = 1.0f;
   _textview_Chat.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _textview_Chat.textContainer.maximumNumberOfLines = 6;
    [_textview_Chat.layoutManager textContainerChangedGeometry:_textview_Chat.textContainer];
    _textview_Chat.layer.cornerRadius = 10;
    _textview_Chat.textColor = [UIColor lightGrayColor];
    _textview_Chat.editable = YES;
    _textview_Chat.scrollEnabled = YES;
    _textview_Chat.text = @"Enter Your Post";
    self.view_transparentview.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    self.view_popup.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.view_popup.alpha = 1;
    self.button_close.layer.cornerRadius = self.button_close.frame.size.width/2;
    self.button_close2popup.layer.cornerRadius = self.button_close2popup.frame.size.width/2;
    self.view_popupnotUser.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    self.view_notauser.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.view_notauser.alpha = 1;
//    UITapGestureRecognizer *singleFingerTap =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(handleSingleTap)];
//
//    [self.view addGestureRecognizer:singleFingerTap];
//    [self.tableview_threadDetails removeGestureRecognizer:singleFingerTap];
//    singleFingerTap.cancelsTouchesInView = YES;

    [self ThreadsAPICalling];
    //images = [[NSMutableArray alloc] init];
       [self.collectionView registerNib:[UINib nibWithNibName:@"DemoImageViewCell" bundle:nil] forCellWithReuseIdentifier:@"imageCellIdentifier"];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"TestNotification" object:nil];
    self.doc.hidden = YES;
}


- (NSArray<PopoverAction *> *)QQActions {
    // 发起多人聊天 action
    PopoverAction *multichatAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_multichat"] title:@"发起多人聊天" handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
    
    }];
    // 加好友 action
    PopoverAction *addFriAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_addFri"] title:@"加好友" handler:^(PopoverAction *action) {
        
    
    }];
    // 扫一扫 action
    PopoverAction *QRAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_QR"] title:@"扫一扫" handler:^(PopoverAction *action) {
        
    }];
    // 面对面快传 action
    PopoverAction *facetofaceAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_facetoface"] title:@"面对面快传" handler:^(PopoverAction *action) {
       
    }];
    // 付款 action
    PopoverAction *payMoneyAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_payMoney"] title:@"付款" handler:^(PopoverAction *action) {
        
    }];
    
    return @[multichatAction, addFriAction, QRAction, facetofaceAction, payMoneyAction];
}
#pragma Tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return [ary_Threads count];
    }else {
        
        return [ary_details count];
    }
    
   
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // number of cells or array count
    return 2;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSNumber *height = [heightAtIndexPath objectForKey:indexPath];
////    if(height) {
////        return height.floatValue;
////    } else {
//        return UITableViewAutomaticDimension;
//    //}
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    // space between cells
//    return 10;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [UIView new];
//    [view setBackgroundColor:[UIColor clearColor]];
//    return view;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"detailsTableID";
    detailsTableViewCell *cell = (detailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    CGFloat height = cell.view_container.frame.size.height;
    CGFloat collectionHeight = cell.view_container.frame.size.height;
//     [cell.collectionview_images registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cvcell"];
    if (height > 0 ||collectionHeight >0 )
    {
        
        height1 = cell.view_container.frame.size.height;
        collectionHeight1 = cell.collectionview_images.frame.size.height;
    }
    else if (height == 0)
    {
        height = height1;
        collectionHeight = collectionHeight1;
    }

    if (cell == nil){
      
        [cell.collectionview_images registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cvcell"];
        cell = [[detailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:MyIdentifier];
    }
   
    cell.delegate = self;
    cell.dataSource = self;
    
  
    cell.indexPath = indexPath.row;
    
    //cell.collectionview_images.collectionViewLayout = 0;
    switch (indexPath.section) {
        case 0:
        {
            cell.view_temporory.hidden = YES;
            cell.button_reply.hidden = YES;
            //NSLog(@"Section%d",cell.view_container.frame);
            cell.label_title.hidden = NO;
            cell.section = indexPath.section;
            cell.tag = 1;
            
            if (![[[ary_Threads valueForKey:@"image"]objectAtIndex:0] count]) {
                cell.collectionview_images.hidden = YES;
                cell.collectionview_height.constant = 0;
                [cell updateConstraintsIfNeeded];
                [cell layoutSubviews];
            }else{

                cell.collectionview_images.hidden = NO;
                cell.collectionview_height.constant = collectionHeight;
                [cell updateConstraintsIfNeeded];
                [cell layoutSubviews];
                cell.indexing = [[[ary_Threads valueForKey:@"image"]objectAtIndex:0] count];
                cell.delegate = self;
                cell.dataSource = self;

            }
            cell.label_description.lineBreakMode = NSLineBreakByWordWrapping;
            [cell.label_description sizeToFit];
            if (![[[ary_Threads valueForKey:@"current_dtc"]objectAtIndex:0] count]) {
                cell.errorcode_height.constant = 0;
                [cell updateConstraintsIfNeeded];
                [cell layoutSubviews];
            }else{
                
                cell.errorcode_height.constant = 25;
                [cell updateConstraintsIfNeeded];
                [cell layoutSubviews];
                cell.view_errorcode.hidden = NO;
                cell.label_errorcode.text = [NSString stringWithFormat:@"%@",[[[[ary_Threads valueForKey:@"current_dtc"]objectAtIndex:0] objectAtIndex:0] valueForKey:@"code"]];
                cell.label_errorname.text = [NSString stringWithFormat:@"-%@",[[[[ary_Threads valueForKey:@"current_dtc"]objectAtIndex:0] objectAtIndex:0]valueForKey:@"description"]];
            }
             cell.view_container.hidden = NO;
            cell.viewcontainer_height.constant = height;
            [cell updateConstraintsIfNeeded];
            [cell layoutSubviews];
            [cell.vehicalimage setImageURL:[NSURL URLWithString:[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"vehiclecarimage"]]];
            [cell.imageview_profile setImageURL:[NSURL URLWithString:[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"profile_image"]]];
            cell.label_2.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"badgestatus"]];
            cell.label_name.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"user_name"]];
            //
    
           cell.label_date.text = [self dateConverter:[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"created_on_new"]];
            cell.label_description.text = [self convertHtmlPlainText:[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"content"]];
            cell.label_title.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"thread_title"]];
       
            if (![[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_year"]isEqual:@""]) {
             
                  cell.label_machineName.text = [NSString stringWithFormat:@" %@ > %@ > %@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_make"],[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_name"],[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_year"]];
            }else{
                     cell.label_machineName.text = [NSString stringWithFormat:@" %@ > %@", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_make"],[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_name"]];
            }
            //
            [cell.imageview_badge setImageURL:[NSURL URLWithString:[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"badge_image"]]];
            if ([[NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"availability"]] isEqualToString:@"0"]) {
                cell.label_online.backgroundColor = [UIColor colorWithRed:216/255.0f green:61/255.0f blue:61/255.0f alpha:1];
            }else if ([[NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"availability"]] isEqualToString:@"1"]){
                
                cell.label_online.backgroundColor = [UIColor greenColor];
            }
            if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue] !=0) {
                
                if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue]>1) {
                    cell.label_likes.text = [NSString stringWithFormat: @"%@ Likes", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
                }else{
                    cell.label_likes.text = [NSString stringWithFormat: @"%@ Like", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
                }
                
            } if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue] !=0){
                if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue]>1) {
                    cell.label_pins.text = [NSString stringWithFormat: @"%@ Pins", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
                }else{
                    
                    cell.label_pins.text = [NSString stringWithFormat: @"%@ Pin", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
                }
                
                
            }if(![[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"]isKindOfClass:[NSNull class]] && [[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]!=0) {
                if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]>1) {
                    cell.label_views.text = [NSString stringWithFormat: @"%@ Views", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"]];
                }else{
                    cell.label_views.text = [NSString stringWithFormat: @"%@ View", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"]];
                }
                
                
            }
            
            if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]!=0) {
                if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]>1) {
                    cell.label_views.text = [NSString stringWithFormat: @"%@ Comments", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"]];
                }else{
                    cell.label_views.text = [NSString stringWithFormat: @"%@ Comment", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"]];
                }
               
                [cell.collectionview_images reloadData];
            }
            return cell;
        }
        case 1:
        {
            cell.view_errorcode.hidden = YES;
            cell.errorcode_height.constant = 0;
            [cell updateConstraintsIfNeeded];
            [cell layoutSubviews];
            
            cell.label_description.lineBreakMode = NSLineBreakByWordWrapping;
            [cell.label_description sizeToFit];
            cell.label_views.text = @"";
             cell.label_pins.text = @"";
             cell.label_likes.text = @"";
//            UITapGestureRecognizer *singleFingerTap =
//            [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                    action:@selector(handleSingleTap:)];
//            [cell.view_temporory addGestureRecognizer:singleFingerTap];

              cell.view_temporory.hidden = NO;
         
            
//            static NSString *MyIdentifier = @"detailsTableID";
//            detailsTableViewCell *cell1 =  (detailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
//            if (cell1 == nil){
//                cell1 = [[detailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                                   reuseIdentifier:MyIdentifier];
//            }
            
//            cell.delegate = self;
//            cell.dataSource = self;
               // cell.section = indexPath.section;
//                    cell.label_description.lineBreakMode = NSLineBreakByWordWrapping;

           [cell.label_description sizeToFit];
            cell.section = indexPath.section;
//              cell.indexPath = indexPath.row;
            if([ary_details count] > 0 && [ary_details count] > indexPath.row){
                cell.label_title.hidden = YES;
                    cell.view_container.hidden = YES;
                    cell.viewcontainer_height.constant = 0;
                    [cell updateConstraintsIfNeeded];
                cell.errorcode_height.constant = 0;
                [cell updateConstraintsIfNeeded];
                [cell layoutSubviews];
                    [cell layoutSubviews];
                    [cell.imageview_profile setImageURL:[NSURL URLWithString:[[ary_details objectAtIndex:indexPath.row] valueForKey:@"profile_image"]]];
                 cell.label_name.text = [NSString stringWithFormat:@"%@",[[ary_details objectAtIndex:indexPath.row] valueForKey:@"user_name"]];
                 cell.label_2.text = [NSString stringWithFormat:@"%@",[[ary_details objectAtIndex:indexPath.row] valueForKey:@"badgestatus"]];
                if (![[[ary_details objectAtIndex:indexPath.row] objectForKey:@"image"] count]) {
                    cell.collectionview_images.hidden = YES;
                    cell.collectionview_height.constant = 0;
                    [cell updateConstraintsIfNeeded];
                    [cell layoutSubviews];
                }else{
                    
                    cell.collectionview_images.hidden = NO;
                    cell.collectionview_height.constant = 154;
                    [cell updateConstraintsIfNeeded];
                    [cell layoutSubviews];
                    cell.button_reply.tag = indexPath.row;
                    [cell.button_reply addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
                    cell.indexing = [[[ary_details objectAtIndex:indexPath.row] objectForKey:@"image"] count];
                    
                   
                }
//                cell.delegate = self;
//                cell.dataSource = self;
            }
           
            if ([[NSString stringWithFormat:@"%@",[[ary_details objectAtIndex:indexPath.row] valueForKey:@"availability"]] isEqualToString:@"0"]) {
                cell.label_online.backgroundColor = [UIColor colorWithRed:216/255.0f green:61/255.0f blue:61/255.0f alpha:1];
            }else if ([[NSString stringWithFormat:@"%@",[[ary_details objectAtIndex:indexPath.row] valueForKey:@"availability"]] isEqualToString:@"1"]){
                
                cell.label_online.backgroundColor = [UIColor greenColor];
            }
            
            cell.label_date.text = [self dateConverter:[[ary_details objectAtIndex:indexPath.row] valueForKey:@"created_on_new"]];
            cell.label_description.text = [self convertHtmlPlainText:[[ary_details objectAtIndex:indexPath.row] valueForKey:@"content"]];
            if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue] !=0) {
                
                if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue]>1) {
                    cell.label_likes.text = [NSString stringWithFormat: @"%@ Likes", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
                }else{
                    cell.label_likes.text = [NSString stringWithFormat: @"%@ Like", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
                }
                
            } if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue] !=0){
                if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue]>1) {
                    cell.label_pins.text = [NSString stringWithFormat: @"%@ Pins", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
                }else{
                    
                    cell.label_pins.text = [NSString stringWithFormat: @"%@ Pin", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
                }
                
                
            }if(![[[ary_details objectAtIndex:indexPath.row] valueForKey:@"view"]isKindOfClass:[NSNull class]] && [[[ary_details objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]!=0) {
                if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]>1) {
                    cell.label_views.text = [NSString stringWithFormat: @"%@ Views", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"view"]];
                }else{
                    cell.label_views.text = [NSString stringWithFormat: @"%@ View", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"view"]];
                }
                
                
            }
            
            if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]!=0) {
                if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]>1) {
                    cell.label_views.text = [NSString stringWithFormat: @"%@ Comments", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"comment"]];
                }else{
                    cell.label_views.text = [NSString stringWithFormat: @"%@ Comment", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"comment"]];
                }
            }
            
            if ([[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"] count]!=0) {
                if ([[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"] count]==1) {
                    cell.label_imageCount.hidden = YES;
                    cell.view_blurr.hidden = YES;
                    if ([[[[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"] objectAtIndex:0] valueForKey:@"flag_id"] intValue]==2) {
                        [cell.imageTemp setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"]objectAtIndex:0]valueForKey:@"poster_image"]]];
                        cell.temp_play.hidden = NO;
                    }else{
                        [cell.imageTemp setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"]objectAtIndex:0]valueForKey:@"file_path"]]];
                    }
                    
                }else{
                    cell.label_imageCount.text = [NSString stringWithFormat:@"+%lu",(unsigned long)[[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"] count]];
                    if ([[[[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"] objectAtIndex:0] valueForKey:@"flag_id"] intValue]==2) {
                        [cell.imageTemp setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"]objectAtIndex:0]valueForKey:@"poster_image"]]];
                        cell.temp_play.hidden = NO;
                    }else{
                        [cell.imageTemp setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"]objectAtIndex:0]valueForKey:@"file_path"]]];
                    }
                    
                }

                
            }
            cell.collectionview_images.hidden = YES;
           
            return cell;
        }
        default:
            break;
    }
    return 0;

//    if (indexPath.section == 0) {
//        detailsTableViewCell *cell;
//        cell=[tableView dequeueReusableCellWithIdentifier:@"detailsTableID"];
//
//        if(cell==nil)
//        {
//            cell = [[detailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                               reuseIdentifier:@"detailsTableID"];
//        }
//
//        return cell;
//
//    }else{
//        detailsTableViewCell *cell1;
//        cell1=[tableView dequeueReusableCellWithIdentifier:@"detailsTableID"];
//
//        if(cell1==nil)
//        {
//            cell1 = [[detailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                               reuseIdentifier:@"detailsTableID"];
//        }
//
//        cell1.label_description.lineBreakMode = NSLineBreakByWordWrapping;
//        [cell1.label_description sizeToFit];
//        cell1.errorcode_height.constant = 0;
//        [cell1 updateConstraintsIfNeeded];
//        [cell1 layoutSubviews];
//       cell1.view_container.hidden = YES;
//        cell1.viewcontainer_height.constant = 0;
//        [cell1 updateConstraintsIfNeeded];
//        [cell1 layoutSubviews];
////        if (![[[ary_details valueForKey:@"image"]objectAtIndex:0] count]) {
////            cell1.collectionview_images.hidden = YES;
////            cell1.collectionview_height.constant = 0;
////            [cell1 updateConstraintsIfNeeded];
////            [cell1 layoutSubviews];
////        }else{
////            cell1.indexing = [[[ary_details valueForKey:@"image"]objectAtIndex:0] count];
////            cell1.collectionview_images.hidden = NO;
////            cell1.indexing = [[[ary_details valueForKey:@"image"]objectAtIndex:0] count];
////
////            cell1.delegate = self;
////            cell1.dataSource = self;
////        }
//
//        //[[ary_details objectAtIndex:indexPath.row] valueForKey:@"profile_image"]
////        for (int i = 0; i <= [ary_details count] ; i++) {
////
////        }
//        if([ary_details count] > 0 && [ary_details count] > indexPath.row){
//
//           // shrObj=[arrMydata objectAtIndex:indexPath.row];
//             [cell1.imageview_profile setImageURL:[NSURL URLWithString:[[ary_details objectAtIndex:indexPath.row] valueForKey:@"profile_image"]]];
//        }
//        else{
//
//            //Array is empty,handle as you needed
//
//        }
////        cell1.label_2.text = [NSString stringWithFormat:@"%@",[[ary_details objectAtIndex:indexPath.row] valueForKey:@"badgestatus"]];
////        cell1.label_name.text = [NSString stringWithFormat:@"%@",[[ary_details objectAtIndex:indexPath.row] valueForKey:@"user_name"]];
////        cell1.label_date.text = [NSString stringWithFormat:@"%@",[[ary_details objectAtIndex:indexPath.row] valueForKey:@"created_on"]];
////         cell1.label_description.text = [self convertHtmlPlainText:[[ary_details objectAtIndex:indexPath.row] valueForKey:@"content"]];
////        if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue] !=0) {
////
////            if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue]>1) {
////                cell1.label_likes.text = [NSString stringWithFormat: @"%@ Likes", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
////            }else{
////                cell1.label_likes.text = [NSString stringWithFormat: @"%@ Like", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
////            }
////
////        } if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue] !=0){
////            if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue]>1) {
////                cell1.label_pins.text = [NSString stringWithFormat: @"%@ Pins", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
////            }else{
////
////                cell1.label_pins.text = [NSString stringWithFormat: @"%@ Pin", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
////            }
////
////
////        }if(![[[ary_details objectAtIndex:indexPath.row] valueForKey:@"view"]isKindOfClass:[NSNull class]] && [[[ary_details objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]!=0) {
////            if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]>1) {
////                cell1.label_views.text = [NSString stringWithFormat: @"%@ Views", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"view"]];
////            }else{
////                cell1.label_views.text = [NSString stringWithFormat: @"%@ View", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"view"]];
////            }
////
////
////        }
////
////        if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]!=0) {
////            if ([[[ary_details objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]>1) {
////                cell1.label_views.text = [NSString stringWithFormat: @"%@ Comments", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"comment"]];
////            }else{
////                cell1.label_views.text = [NSString stringWithFormat: @"%@ Comment", [[ary_details objectAtIndex:indexPath.row] valueForKey:@"comment"]];
////            }
////        }
//        return cell1;
//    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(detailsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section ==0) {
        NSNumber *height = @(cell.frame.size.height);
        [heightAtIndexPath setObject:height forKey:indexPath];
        //static NSString *simpleTableIdentifier = @"detailsTableID";
        detailsTableViewCell *mtCell = (detailsTableViewCell *)cell;
        if (!mtCell.collectionview_images.superview) {
            [mtCell addSubview:mtCell.collectionview_images];
            mtCell.collectionview_images.delegate = mtCell;
            mtCell.collectionview_images.dataSource = mtCell;
            mtCell.collectionview_images.scrollEnabled = YES;
        }
    }else if (indexPath.section ==1){
        if (indexPath.row == [ary_details count]) {
            CGRect frame = self.tableview_threadDetails.frame;
            frame.size.height =(CGRectGetMaxY(self.doc.frame)+self.doc.frame.size.height);
             self.tableview_threadDetails.frame = frame;
        }
        
    }
    
   
//    }else{
//        NSNumber *height = @(cell.frame.size.height);
//        [heightAtIndexPath setObject:height forKey:indexPath];
//        //static NSString *simpleTableIdentifier = @"detailsTableID";
//        detailsTableViewCell *mtCell1 = (detailsTableViewCell *)cell;
//        if (!mtCell1.collectionview_images.superview) {
//            [mtCell1 addSubview:mtCell1.collectionview_images];
//            mtCell1.collectionview_images.delegate = mtCell1;
//            mtCell1.collectionview_images.dataSource = mtCell1;
//        }
//        mtCell1.collectionview_images.scrollEnabled = YES;
//    }
   
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    detailsTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"detailsTableID"];
//    if (![[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] count]) {
////        return cell1.contentView.frame.size.height-cell1.view_imagethubnails.frame.size.height;
//    }else{
//
//    }
    

//    detailsTableViewCell *cell;
//    cell=[tableView dequeueReusableCellWithIdentifier:@"detailsTableID"];
////    if (indexPath.row == 3) {
////        return cell.contentView.frame.size.height-cell.collectionview_images.frame.size.height;
////    }else{
//     return UITableViewAutomaticDimension;
    if (indexPath.section ==0) {
        return UITableViewAutomaticDimension;
    }else{
        
        return UITableViewAutomaticDimension;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
         return UITableViewAutomaticDimension;
    }else{
        return UITableViewAutomaticDimension;
    }
   
    
   
     // customize the height
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - MTTableViewCellDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath InTableViewCell:(detailsTableViewCell *)cell {
    UICollectionViewCell *cCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvcell"forIndexPath:indexPath];

  
    if (cell.section == 0) {
        UICollectionViewCell* cCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvcell"
                                                                                forIndexPath:indexPath];
        cCell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cCell.layer.cornerRadius = 8.0f;
        cCell.clipsToBounds = YES;
        AsyncImageView * image1 = [[AsyncImageView alloc] init];
        image1.frame = CGRectMake(0, 0, cCell.frame.size.width, cCell.frame.size.height);
        image1.contentMode = UIViewContentModeScaleAspectFill; 
        
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(image1.frame.origin.x,image1.frame.origin.y+image1.frame.size.height-30, image1.frame.size.width , 50)];

    fromLabel.font = [UIFont fontWithName:@"Roboto-bold" size:12];
    [fromLabel setAlpha:0.5f];
    fromLabel.numberOfLines = 1;
    fromLabel.baselineAdjustment = YES;
    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor blackColor];
    fromLabel.textColor = [UIColor whiteColor];
    fromLabel.textAlignment = NSTextAlignmentLeft;
    UIImageView *playImage = [[UIImageView alloc]initWithFrame:CGRectMake(cCell.frame.size.width/3,cCell.frame.size.height/3.5, 50 ,50)];
    //playImage.center = cCell.center;
    playImage.contentMode = UIViewContentModeScaleAspectFill;
    playImage.image = [UIImage imageNamed:@"playBtn"];
    playImage.hidden = YES;


    if ([[[[[ary_Threads valueForKey:@"image"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"image/jpeg"]) {

        [image1 setImageURL:[NSURL URLWithString:[[[[ary_Threads valueForKey:@"image"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"thumb_file_path"]]];

    }else if ([[[[[ary_Threads valueForKey:@"image"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"video/mp4"]){
        [image1 setImageURL:[NSURL URLWithString:[[[[ary_Threads valueForKey:@"image"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"poster_image"]]];
        playImage.hidden = NO;


    }else if ([[[[[ary_Threads valueForKey:@"image"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"application/octet-stream"]  ){

        [image1 setImage:[UIImage imageNamed:@"office"]];

    }else if ([[[[[ary_Threads valueForKey:@"image"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"audio/mp3"]){
        [image1 setImage:[UIImage imageNamed:@"Audio"]];
         playImage.hidden = NO;
    }else if ([[[[[ary_Threads valueForKey:@"image"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"link"]){
         [image1 setImage:[UIImage imageNamed:@"Link"]];
    }
    //        [cCell.imageview_collection setImageURL:[[[[ary_Threads valueForKey:@"image"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"thumb_file_path"]];
       
    [cCell.contentView addSubview:image1];
    [image1 addSubview:fromLabel];
    [image1 addSubview:playImage];

  
    return cCell;
    }else{
        
        
        
        cCell.tag = indexPath.row;
//        NSLog(@"cCell1 %@", cCell1);
        //NSLog(@"indexPath %ld", (long)indexPath.row);
        //cCell1.contentView.backgroundColor = [UIColor redColor];
        AsyncImageView * image2 = [[AsyncImageView alloc] init];
        image2.frame = CGRectMake(0, 0, cCell.frame.size.width, cCell.frame.size.height);
        image2.contentMode = UIViewContentModeScaleAspectFill;
        cCell.backgroundColor = [UIColor whiteColor];
        cCell.layer.cornerRadius = 8.0f;
        cCell.clipsToBounds = YES;
        UIImageView *playImage = [[UIImageView alloc]initWithFrame:CGRectMake(cCell.frame.size.width/3,cCell.frame.size.height/3.5, 50 ,50)];
        //playImage.center = cCell.center;
        playImage.contentMode = UIViewContentModeScaleAspectFill;
        playImage.image = [UIImage imageNamed:@"playBtn"];
          playImage.hidden = YES;
//        if(indexPath.row  == 0)
//        {
//            cCell.backgroundColor = [UIColor greenColor];
//        }
//        else
//        {
//            cCell.backgroundColor = [UIColor greenColor];
//        }
//        for (int i = 0; i < [self.tableview_threadDetails numberOfRowsInSection:cell.section]; i++) {
       // NSLog(@"i......%d",i);
//            for (int j = 0; j<[[[ary_details objectAtIndex:cell.indexPath] objectForKey:@"image"] count]; j++) {
////                NSLog(@"j......%@",[[[[ary_details objectAtIndex:indexPath.row]valueForKey:@"image"]objectAtIndex:0]valueForKey:@"thumb_file_path"]);
//            if ([[[[[ary_details objectAtIndex:cell.indexPath]valueForKey:@"image"]objectAtIndex:j]valueForKey:@"flag_id"] intValue]==2) {
//        [image2 setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:cell.indexPath]valueForKey:@"image"]objectAtIndex:j]valueForKey:@"poster_image"]]];
////                     [image2 setImageURL:[NSURL URLWithString:[[[[ary_details valueForKey:@"image"] objectAtIndex:j] objectAtIndex:indexPath.row] valueForKey:@"poster_image"]]];
//                    playImage.hidden = NO;
//                }else if ([[[[[ary_details objectAtIndex:cell.indexPath]valueForKey:@"image"]objectAtIndex:j]valueForKey:@"flag_id"] intValue]==1){
//                     //thumb_file_path
//                      [image2 setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:cell.indexPath]valueForKey:@"image"]objectAtIndex:j]valueForKey:@"thumb_file_path"]]];
//                }else if ([[[[[ary_details objectAtIndex:cell.indexPath]valueForKey:@"image"]objectAtIndex:j]valueForKey:@"flag_id"] intValue]==3){
//                    [image2 setImage:[UIImage imageNamed:@"Audio"]];
//                }else if ([[[[[ary_details objectAtIndex:cell.indexing]valueForKey:@"image"]objectAtIndex:j]valueForKey:@"flag_id"] intValue]==6){
//                    [image2 setImage:[UIImage imageNamed:@"Link"]];
//                }
//                else {
//
//                      [image2 setImage:[UIImage imageNamed:@"thembnail"]];
//                }
//
//                }
        
//            }
        
        
//
//
            
//            if (i != indexPath.row) {
//                detailsTableViewCell* cell = [self.tableview_threadDetails cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
           
                //Do your stuff
            //}
      
//        if ([[[[[ary_details objectAtIndex:cell.indexPath] objectForKey:@"image"] objectAtIndex:0] objectForKey:@"file_type"] isEqualToString:@"image/jpeg"]) {
//
//            [image2 setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:cell.indexPath] objectForKey:@"image"] objectAtIndex:0] objectForKey:@"thumb_file_path"]]];
//
//        }else if ([[[[[ary_details objectAtIndex:cell.indexPath] objectForKey:@"image"] objectAtIndex:0] objectForKey:@"file_type"] isEqualToString:@"video/mp4"]){
//            [image2 setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:cell.indexPath] objectForKey:@"image"] objectAtIndex:0] objectForKey:@"poster_image"]]];
//
//
//
//        }else if ([[[[[ary_details objectAtIndex:cell.indexPath] objectForKey:@"image"] objectAtIndex:0] objectForKey:@"file_type"] isEqualToString:@"application/octet-stream"]){
//
//            [image2 setImage:[UIImage imageNamed:@"office"]];
//
//        }
//        if ([[[ary_details objectAtIndex:cell.indexPath] valueForKey:@"image"] count]!=0) {
//            if ([[[[[ary_details objectAtIndex:cell.indexPath] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"file_type"] isEqualToString:@"image/jpeg"]) {
//                [image2 setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:cell.indexPath]valueForKey:@"image"] objectAtIndex:0] valueForKey:@"thumb_file_path"]]];
//                //[image2 setImage:[UIImage imageNamed:@"office"]];
//            }
//            }else if ([[[[[ary_details objectAtIndex:cell.indexPath] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"file_type"] isEqualToString:@"video/mp4"]){
//                //            [image2 setImageURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:cell.indexPath]valueForKey:@"image"] objectAtIndex:0] valueForKey:@"poster_image"]]];
//                //            playImage.hidden = NO;
//                [image2 setImage:[UIImage imageNamed:@"office"]];
//
//            }else if ([[[[[ary_details objectAtIndex:cell.indexPath] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"file_type"] isEqualToString:@"application/octet-stream"]){
//
//                [image2 setImage:[UIImage imageNamed:@"office"]];
//
//            }
         [cCell.contentView addSubview:image2];
        // [image2 addSubview:fromLabel];
         [image2 addSubview:playImage];
        
        return cCell;
        }
        
//        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(image2.frame.origin.x,image2.frame.origin.y+image2.frame.size.height-30, image2.frame.size.width , 50)];
//
//        fromLabel.font = [UIFont fontWithName:@"Roboto-bold" size:12];
//        [fromLabel setAlpha:0.5f];
//        fromLabel.numberOfLines = 1;
//        fromLabel.baselineAdjustment = YES;
//        fromLabel.adjustsFontSizeToFitWidth = YES;
//        fromLabel.clipsToBounds = YES;
//        fromLabel.backgroundColor = [UIColor blackColor];
//        fromLabel.textColor = [UIColor whiteColor];
//        fromLabel.textAlignment = NSTextAlignmentLeft;
//        UIImageView *playImage = [[UIImageView alloc]initWithFrame:CGRectMake(cCell1.frame.size.width/3,cCell1.frame.size.height/3.5, 50 ,50)];
//        //playImage.center = cCell.center;
//        playImage.contentMode = UIViewContentModeScaleAspectFill;
//        playImage.image = [UIImage imageNamed:@"playBtn"];
//        playImage.hidden = YES;
//        NSLog (@"%ld", (long)cCell1.indexPath.row);

        //        [cCell.imageview_collection setImageURL:[[[[ary_Threads valueForKey:@"image"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"thumb_file_path"]];

    
   
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section     InTableViewCell:(detailsTableViewCell *)cell {
    
    [self.tableview_threadDetails indexPathForCell:cell];

    if (cell.section == 0) {
        return cell.indexing;
    }else{
        return cell.indexing;
    }
 

    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section InTableViewCell:(detailsTableViewCell *)cell{
    //UIEdgeInsetsMake(5, 10,5, 10);
    //(5, cell.collectionview_images.frame.size.width/5,5, 0)
  //collectionViewLayout.
    
    
    if (cell.indexing ==1 || cell.indexing ==2 || cell.indexing2 == 1 || cell.indexing2 == 2) {
        CGFloat cellSpacing = ((UICollectionViewFlowLayout *) collectionViewLayout).minimumLineSpacing;
        CGFloat cellWidth = ((UICollectionViewFlowLayout *) collectionViewLayout).itemSize.width;
        NSInteger cellCount = [collectionView numberOfItemsInSection:section];
        CGFloat inset = (collectionView.bounds.size.width - (cellCount * cellWidth) - ((cellCount - 1)*cellSpacing)) * 0.45;
        inset = MAX(inset, 0.0);
        
         return UIEdgeInsetsMake(0.0, inset, 0.0, 0.0);
    }else{
    CGFloat cellSpacing = ((UICollectionViewFlowLayout *) collectionViewLayout).minimumLineSpacing;
    CGFloat cellWidth = ((UICollectionViewFlowLayout *) collectionViewLayout).itemSize.width;
    NSInteger cellCount = [collectionView numberOfItemsInSection:section];
    CGFloat inset = (collectionView.bounds.size.width - (cellCount * cellWidth) - ((cellCount - 1)*cellSpacing)) * 0.1;
    inset = MAX(inset, 0.0);
    return UIEdgeInsetsMake(0.5, inset, 0.0, 0.0);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath InTableViewCell:(detailsTableViewCell *)cell{
    
         return CGSizeMake(120, 150);
   
   
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
   // NSLog(@"iam calling");
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath InTableViewCell:(detailsTableViewCell *)cell{

    UICollectionViewCell *cCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvcell"forIndexPath:indexPath];
   

    return cCell;

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath InTableViewCell:(detailsTableViewCell *)cell{
    if (cell.section == 0) {
        
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GallaryViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"GallaryID"];
    ViewControllerObj.Images = [[ary_Threads valueForKey:@"image"] objectAtIndex:0];
    [self.navigationController pushViewController:ViewControllerObj animated:YES];
    }else{
        
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GallaryViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"GallaryID"];
        ViewControllerObj.Images = [[ary_details objectAtIndex:cell.indexPath]valueForKey:@"image"] ;
        [self.navigationController pushViewController:ViewControllerObj animated:YES];
    }
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView InTableViewCell:(detailsTableViewCell *)cell{
    
    
    return 1;
}
- (IBAction)back_button:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ThreadsAPICalling{
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self->appDelegate.loaderView removeFromSuperview];
    //    });
    [self.view addSubview:appDelegate.loaderView];
    ary_Threads=[[NSMutableArray alloc]init];
    
    NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key",[NSString stringWithFormat:@"%d",appDelegate.loginID],@"user_id",[NSString stringWithFormat:@"%d",appDelegate.domineID],@"domain_id",[NSString stringWithFormat:@"%@",threadID],@"thread_id",nil];
    
    
    
    NSURL *URL = [NSURL URLWithString:ThreadDetails];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
    [manager GET:URL.absoluteString parameters:parametersDictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        //[self->appDelegate.loaderView removeFromSuperview];
        [self->ary_Threads addObjectsFromArray:[[responseObject valueForKey:@"data"] objectForKey:@"thread"]];
        
        [manager.session invalidateAndCancel];
       
        //NSLog(@"ary_Threads: %@", self->ary_Threads);
       
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //[manager.session invalidateAndCancel];
    }];
     [self ThreadsreplyAPICalling];
     [self.tableview_threadDetails reloadData];
}
-(void)ThreadsreplyAPICalling{
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self->appDelegate.loaderView removeFromSuperview];
    //    });

    
    ary_details=[[NSMutableArray alloc]init];
    
    NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key",[NSString stringWithFormat:@"%d",appDelegate.loginID],@"user_id",[NSString stringWithFormat:@"%d",appDelegate.domineID],@"domain_id",[NSString stringWithFormat:@"%@",threadID],@"thread_id",nil];
    
    
    
    NSURL *URL = [NSURL URLWithString:postList];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
     //[manager.session invalidateAndCancel];
    [manager GET:URL.absoluteString parameters:parametersDictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        [self handleSingleTap];
        if (![[responseObject valueForKey:@"result"] isEqualToString:@"No record found."]) {
           
             [self->ary_details addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"post"]];
             [self.tableview_threadDetails reloadData];
            if (self->clicked==YES) {
                [self reload];
            }
            
        }
        if ([self->ary_details count] <= 1){
            
            self.doc.hidden = NO;
        }
        
        [self->appDelegate.loaderView removeFromSuperview];
       
//        if (self.tableview_threadDetails.contentSize.height > self.tableview_threadDetails.frame.size.height)
//        {
//            [self ScrollBottom];
//        }
//        if (self.tableview_threadDetails.contentSize.height > self.tableview_threadDetails.frame.size.height)
//        {
//            CGPoint offset = CGPointMake(0, self.tableview_threadDetails.contentSize.height - self.tableview_threadDetails.frame.size.height);
//            [self.tableview_threadDetails setContentOffset:offset animated:YES];
//
//        }
        
        
      } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self->appDelegate.loaderView removeFromSuperview];
    }];
    
   
}
    
-(NSString*)convertHtmlPlainText:(NSString*)HTMLString{
    NSData *HTMLData = [HTMLString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];
    NSString *plainString = attrString.string;
    
    return plainString;
}
-(NSString *)dateConverter:(NSString *)str{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date  = [dateFormatter dateFromString:str];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"MMM dd, yyyy h:mm aa"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    
    return newDate;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
     Noscroll = NO;
  
        singleFingerTap =
       [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap)];
    
        [self.view addGestureRecognizer:singleFingerTap];
   
  UITextPosition *beginning = [textView beginningOfDocument];
    [textView setSelectedTextRange:[textView textRangeFromPosition:beginning
                                                          toPosition:beginning]];
    textView.selectedRange = NSMakeRange(5, 5);
    [textView becomeFirstResponder];
    _textview_Chat.editable = YES;
    _textview_Chat.textColor = [UIColor blackColor];
   newLine =0;
    returnPressed=0;
    returnPressed +=1;
    
    if(returnPressed < 8){
        
//        _textview_Chat.frame = CGRectMake(8, 8, _textview_Chat.frame.size.width, _textview_Chat.frame.size.height + 17);
        NSLog(@"self.view%f",self.view.frame.size.height);
        self.textview_Chat.text = @"";
        newLine -= kOFFSET_FOR_KEYBOARD;
        
        [UIView animateWithDuration:0.3 animations:^
         {
      
             self->_doc.transform = CGAffineTransformMakeTranslation(0,-250-newLine-self->height);
             [self.tableview_threadDetails setContentOffset:self.tableview_threadDetails.contentOffset animated:NO];
         }
         ];
        

    }
     UITextPosition* pos = _textview_Chat.endOfDocument;
    CGRect currentRect = [_textview_Chat caretRectForPosition:pos];
    previousRect = currentRect;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
   
    
    const char * _char = [text cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    if (isBackSpace == -8) {
        [UIView animateWithDuration:0.1 animations:^
         {
             if(self.textview_Chat.frame.size.height>51){

                
                 CGRect frame = self.doc.frame;
                 frame.size.height = newLine-5;
                 self.doc.frame = frame;
//                 if(returnPressed > 15 && returnPressed > 1){
                     //self->height = newLine-50;
                     //
                     self.textview_Chat.frame = CGRectMake(self.textview_Chat.frame.origin.x,self.textview_Chat.frame.origin.y , self.textview_Chat.frame.size.width, self.textview_Chat.frame.size.height-8);
                     
                     [UIView animateWithDuration:0.1 animations:^
                      {
                          //
                          self->_doc.transform = CGAffineTransformMakeTranslation(0,-330);
                      }
                      ];
                     
                 }
             }
             
         //}
         ];
        
    }
    
    
    if ([text isEqualToString:@"\n"]) {
        
        returnPressed +=1;
        
        if(returnPressed < 15 && returnPressed > 1){
            
           
            newLine = 17*returnPressed;
            [UIView animateWithDuration:0.1 animations:^
             {
                
                 self->height = newLine;
                 CGRect frame = self.doc.frame;
                 frame.size.height = newLine+5;
                 self.doc.frame = frame;
                 self.textview_Chat.frame = CGRectMake(self.textview_Chat.frame.origin.x,self.textview_Chat.frame.origin.y , self.textview_Chat.frame.size.width, newLine+20);
                self->_doc.transform = CGAffineTransformMakeTranslation(0,-295-newLine+10);
          
            
                 
             }
             ];
            
        }
    }
    
   return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
 
    UITextPosition* pos = textView.endOfDocument;
    
    CGRect currentRect = [textView caretRectForPosition:pos];
    
    if (currentRect.origin.y > previousRect.origin.y || [textView.text isEqualToString:@"\n"]){
         returnPressed +=1;
        if(returnPressed < 15 && returnPressed > 1){
            self->height = self.textview_Chat.frame.origin.y;
//
            self.textview_Chat.frame = CGRectMake(self.textview_Chat.frame.origin.x,self.textview_Chat.frame.origin.y , self.textview_Chat.frame.size.width, self.textview_Chat.frame.size.height+8);
  
            [UIView animateWithDuration:0.1 animations:^
             {
//
                 self->_doc.transform = CGAffineTransformMakeTranslation(0,-250-newLine-self->height);
                 }
             ];
            
        }
    }
    previousRect = currentRect;
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [_textview_Chat resignFirstResponder];
        [self.view endEditing:YES];
        if([_textview_Chat.text isEqualToString:@""]){
             int height1 = returnPressed;
            height= 0;
            _textview_Chat.textColor = [UIColor lightGrayColor];
            _textview_Chat.text = @"Enter your Post";
            [UIView animateWithDuration:0.3 animations:^
             {
                 self->_textview_Chat.frame = CGRectMake(self->_button_Gallary.frame.size.width+5, 5, self->_textview_Chat.frame.size.width,51);
                 CGRect frame = self.doc.frame;
                 frame.size.height = 80;
                 self.doc.frame = frame;
                 [self.view endEditing:YES];
                 self->_doc.transform = CGAffineTransformMakeTranslation(0, -height1);
             }];
        }else{
           
            [self.view removeGestureRecognizer:singleFingerTap];
            _textview_Chat.textColor = [UIColor blackColor];
              [self.view endEditing:NO];

            int height1 = 17*returnPressed;

            [UIView animateWithDuration:0.3 animations:^
             {
                 
                 self->_doc.transform = CGAffineTransformMakeTranslation(0, -height1);
             }];
        }
  
        
        
    }
}
//- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
//{
//    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
//
//
//}
-(void)showInfo:(UIButton*)button{
    int row = button.tag;
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    MWPhoto *photo, *thumb;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;//you know that which row button is tapped
    if ([[[ary_details objectAtIndex:row]valueForKey:@"image"] count]==1){
        if ([[[[[ary_details objectAtIndex:row]valueForKey:@"image"] objectAtIndex:0] valueForKey:@"flag_id"] intValue]==2) {

            photo = [MWPhoto photoWithURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:row]valueForKey:@"image"] objectAtIndex:0] valueForKey:@"poster_image"]]];
            photo.videoURL = [NSURL URLWithString:[[[[ary_details objectAtIndex:row]valueForKey:@"image"]objectAtIndex:0]valueForKey:@"file_path"]];
            [photos addObject:photo];
            enableGrid = NO;
            autoPlayOnAppear = YES;
            [photos addObject:photo];

        }else if ([[[[[ary_details objectAtIndex:row]valueForKey:@"image"] objectAtIndex:0] valueForKey:@"flag_id"] intValue]==1){
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:[[[[ary_details objectAtIndex:row]valueForKey:@"image"]objectAtIndex:0]valueForKey:@"file_path"]]];
            
            photo.caption = [[[[ary_details objectAtIndex:row]valueForKey:@"image"]objectAtIndex:0]valueForKey:@"original_file_name"];
            [photos addObject:photo];
            // Options
            enableGrid = NO;
            
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
        browser.enableSwipeToDismiss = NO;
        browser.autoPlayOnAppear = autoPlayOnAppear;
        [browser setCurrentPhotoIndex:0];
        if (displaySelectionButtons) {
            _selections = [NSMutableArray new];
            for (int i = 0; i < photos.count; i++) {
                [_selections addObject:[NSNumber numberWithBool:NO]];
            }
        }
         [self.navigationController pushViewController:browser animated:YES];
        // Show
      
        
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
        
    }else{
        
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GallaryViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"GallaryID"];
        ViewControllerObj.Images = [[ary_details objectAtIndex:row]valueForKey:@"image"] ;
        [self.navigationController pushViewController:ViewControllerObj animated:YES];
    }

}
- (IBAction)reply_Add:(UIButton *)sender {
    
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"image" handler:^(PopoverAction *action) {
        NSString *numberOfPhotoSelectionString = [NSString stringWithFormat:@"10"];
        if (numberOfPhotoSelectionString.length > 0
            && [numberOfPhotoSelectionString integerValue] != 1) {
            // Custom selection number
            YMSPhotoPickerViewController *pickerViewController = [[YMSPhotoPickerViewController alloc] init];
            pickerViewController.numberOfPhotoToSelect = [numberOfPhotoSelectionString integerValue];
            UIColor *customColor = [UIColor colorWithRed:216/255.0 green:61/255.0 blue:61/255.0 alpha:1.0];
            pickerViewController.theme.titleLabelTextColor = [UIColor blackColor];
            pickerViewController.theme.navigationBarBackgroundColor = customColor;
            pickerViewController.theme.tintColor = [UIColor blackColor];
            pickerViewController.theme.orderTintColor = customColor;
            pickerViewController.theme.orderLabelTextColor = [UIColor blackColor];
            pickerViewController.theme.cameraVeilColor = customColor;
            pickerViewController.theme.cameraIconColor = [UIColor whiteColor];
            pickerViewController.theme.statusBarStyle = UIStatusBarStyleDefault;
            
            [self yms_presentCustomAlbumPhotoView:pickerViewController delegate:self];
        }
        else {
            [[YMSPhotoPickerTheme sharedInstance] reset];
            [self yms_presentAlbumPhotoViewWithDelegate:self];
        }
    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"video" handler:^(PopoverAction *action) {
        GLAssetGridViewController *assetGridVC = [[GLAssetGridViewController alloc]init];
        assetGridVC.pickerType = GLAssetGridType_Video;
        [self presentViewController:
         [[UINavigationController alloc]initWithRootViewController:assetGridVC] animated:YES completion:nil];
        
    }];
    PopoverAction *action3 = [PopoverAction actionWithTitle:@"Audio" handler:^(PopoverAction *action) {
        
    }];
    PopoverAction *action4 = [PopoverAction actionWithTitle:@"links" handler:^(PopoverAction *action) {
        
    }];
    
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    popoverView.hideAfterTouchOutside = YES; // 点击外部时不允许隐藏
    [popoverView showToView:sender withActions:@[action1, action2, action3, action4]];

    
}
#pragma mark - YMSPhotoPickerViewControllerDelegate

#pragma mark - YMSPhotoPickerViewControllerDelegate

- (void)photoPickerViewControllerDidReceivePhotoAlbumAccessDenied:(YMSPhotoPickerViewController *)picker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow photo album access?", nil) message:NSLocalizedString(@"Need your permission to access photo albumbs", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)photoPickerViewControllerDidReceiveCameraAccessDenied:(YMSPhotoPickerViewController *)picker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow camera access?", nil) message:NSLocalizedString(@"Need your permission to take a photo", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    
    // The access denied of camera is always happened on picker, present alert on it to follow the view hierarchy
    [picker presentViewController:alertController animated:YES completion:nil];
}

- (void)photoPickerViewController:(YMSPhotoPickerViewController *)picker didFinishPickingImage:(UIImage *)image
{
    [picker dismissViewControllerAnimated:YES completion:^() {
        self.images = @[image];
        
        [self.collectionView reloadData];
    }];
}

- (void)photoPickerViewController:(YMSPhotoPickerViewController *)picker didFinishPickingImages:(NSArray *)photoAssets
{
    [picker dismissViewControllerAnimated:YES completion:^() {
        
        PHImageManager *imageManager = [[PHImageManager alloc] init];
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.networkAccessAllowed = YES;
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        options.synchronous = YES;
        
        NSMutableArray *mutableImages = [NSMutableArray array];
        
        for (PHAsset *asset in photoAssets) {
            CGSize targetSize = CGSizeMake((CGRectGetWidth(self.collectionView.bounds) - 20*2) * [UIScreen mainScreen].scale, (CGRectGetHeight(self.collectionView.bounds) - 20*2) * [UIScreen mainScreen].scale);
            [imageManager requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage *image, NSDictionary *info) {
                [mutableImages addObject:image];
            }];
        }
 
        //[self.images addObjectsFromArray:mutableImages];
        self.images = [mutableImages copy];
        [self handleSingleTap];
        [self.view bringSubviewToFront:self.view_backsideCollectionview];
        self.view_backsideCollectionview.hidden = NO;
        [self.collectionView reloadData];
        
    }];
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.photoImage = [self.images objectAtIndex:indexPath.item];
    cell.deleteButton.tag = indexPath.item;
    [cell.deleteButton addTarget:self action:@selector(deletePhotoImage:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), CGRectGetHeight(collectionView.bounds));
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
  
if (velocity.y < 0 && Noscroll == YES){
        CGRect frame = self.tableview_threadDetails.frame;
        frame.size.height = self.view.frame.size.height;
        self.tableview_threadDetails.frame = frame;
         //TableHeight = frame;
        [UIView transitionWithView:self.doc
                          duration:0.4
                           options:UIViewAnimationOptionTransitionFlipFromBottom
                        animations:^{
                           
                            self.doc.hidden = YES;
                        }
                        completion:NULL];
}
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat contentYoffset = scrollView.contentOffset.y;
    
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    
    if(distanceFromBottom < height && Noscroll == YES)
    {
      
        [UIView transitionWithView:self.doc
                          duration:0.4
                           options:UIViewAnimationOptionTransitionFlipFromTop
                        animations:^{
                            
                            self.doc.hidden = NO;
                        }
                        completion:NULL];
    }
}

-(void)userChecking:(int)userID{
    if (appDelegate.loginID==userID) {
        [UIView transitionWithView:self.view_transparentview
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [self.view bringSubviewToFront:self.view_transparentview];
                            self.view_transparentview.hidden = NO;
                            self.view_popup.hidden = NO;
                            self.view_notauser.hidden = YES;
                            
                        }
                        completion:NULL];
    }else{
        [UIView transitionWithView:self.view_transparentview
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                             [self.view bringSubviewToFront:self.view_transparentview];
                             self.view_popup.hidden = YES;
                            self.view_notauser.hidden = NO;
                            self.view_transparentview.hidden = NO;
                        }
                        completion:NULL];
    }
}
- (IBAction)button_sent:(UIButton *)sender {
   
if ([self.textview_Chat.text isEqualToString:@"Enter Your Post"] ||[self.textview_Chat.text isEqualToString:@""]) {
        [self.view makeToast:@"Please Enter the Text." duration:3.0 position:CSToastPositionCenter];
    
    }else{
             [self.textview_Chat resignFirstResponder];
           [self userChecking:[[[self->ary_Threads objectAtIndex:0] valueForKey:@"user_id"] intValue]];

}

}
- (void)handleSingleTap
{
//    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
   
     self.tableview_threadDetails.scrollEnabled = YES;
        [_textview_Chat resignFirstResponder];
        [self.view endEditing:YES];
        
        Noscroll = YES;
        if([_textview_Chat.text isEqualToString:@""]){
         
            int height = returnPressed;
            _textview_Chat.textColor = [UIColor lightGrayColor];
            _textview_Chat.text = @"Enter your Post";
            [UIView animateWithDuration:0.3 animations:^
             {
                 self->_textview_Chat.frame = CGRectMake(self->_button_Gallary.frame.size.width+5, 5, self->_textview_Chat.frame.size.width,51);
                 CGRect frame = self.doc.frame;
                 frame.size.height = 80;
                 self.doc.frame = frame;
                 self->_doc.transform = CGAffineTransformMakeTranslation(0, -height);
             }];
        }else{
            
            
            _textview_Chat.textColor = [UIColor blackColor];;
            //            self->_textview_Chat.frame = CGRectMake(self->_button_Gallary.frame.size.width+5, 5, self->_textview_Chat.frame.size.width,self.textview_Chat.frame.size.height);
            int height = 17*returnPressed;
            //  int height = self.view.frame.size.height-self.doc.frame.size.height;
            [UIView animateWithDuration:0.3 animations:^
             {
                 
                 self->_doc.transform = CGAffineTransformMakeTranslation(0, -height);
             }];
        }
        
        
        

}
- (IBAction)button_close:(UIButton *)sender {
    
    [UIView transitionWithView:self.view_transparentview
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.view_transparentview.hidden = YES;
                        self.doc.hidden = YES;
                    }
                    completion:NULL];
    [self handleSingleTap];
    
}

- (IBAction)button_reply:(UIButton *)sender {
    
    UIButton *button = (UIButton *)sender;
    //NSLog(@"%ld", (long)[button tag]);
     [self.view addSubview:appDelegate.loaderView];
    if (button.tag == 0 ||button.tag == 3 ) {
       
        NSAttributedString *s = self.textview_Chat.attributedText;
        NSDictionary *documentAttributes = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
        NSData *htmlData = [s dataFromRange:NSMakeRange(0, s.length) documentAttributes:documentAttributes error:NULL];
        NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
        NSMutableArray *linkArray = [[NSMutableArray alloc]init];
        NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:   [NSString stringWithFormat:@"%@",@"dG9wZml4MTIz"], @"api_key",
                                              [NSString stringWithFormat:@"%d",appDelegate.loginID], @"user_id",
                                              [NSString stringWithFormat:@"%@",threadID], @"thread_id",
                                              [NSString stringWithFormat:@"%@",htmlString], @"description",[NSString stringWithFormat:@"%@",@"Comment"], @"post_type",[NSString stringWithFormat:@"%@",@"NO"], @"close_status",[NSString stringWithFormat:@"%@",@"0"], @"post_status",[NSString stringWithFormat:@"%@",@"true"], @"image_flag",[NSString stringWithFormat:@"%d",appDelegate.domineID], @"domain_id",[NSString stringWithFormat:@"%@",@"0"], @"post_display_status",linkArray,@"link",nil];
        
           [Webservices requestPostUrl:PostThread parameters:parametersDictionary success:^(NSDictionary *responce) {
               if (self.images.count!=0) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                          [self VideoUpload:[[responce objectForKey:@"data"] valueForKey:@"post_id"]];
//                       [self imageUpload:[[responce objectForKey:@"data"] valueForKey:@"post_id"]];
                      
                       
                   });
                  
               }else if (self.VideoURL.count!=0){
                   
                   [self VideoUpload:[[responce objectForKey:@"data"] valueForKey:@"post_id"]];
               }
               
               //NSLog(@"%@",responce);
            [self.view makeToast:@"Sent successfully" duration:3.0 position:CSToastPositionTop];
            [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
            self.textview_Chat.text = @"";
               self->clicked = YES;
                 if (self.images.count!=0) {
                     
                 }else{
                    [self ThreadsreplyAPICalling];
                 }
          
          
            
            if ([[responce valueForKey:@"status"]isEqualToString:@"Failure"]) {
                
            }
            
        } failure:^(NSError *error) {
             [self->appDelegate.loaderView removeFromSuperview];
        }];
    }else if (button.tag ==1){
        
        NSAttributedString *s = self.textview_Chat.attributedText;
        NSDictionary *documentAttributes = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
        NSData *htmlData = [s dataFromRange:NSMakeRange(0, s.length) documentAttributes:documentAttributes error:NULL];
        NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
        NSMutableArray *linkArray = [[NSMutableArray alloc]init];
        NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:   [NSString stringWithFormat:@"%@",@"dG9wZml4MTIz"], @"api_key",
                                              [NSString stringWithFormat:@"%d",appDelegate.loginID], @"user_id",
                                              [NSString stringWithFormat:@"%@",threadID], @"thread_id",
                                              [NSString stringWithFormat:@"%@",htmlString], @"description",[NSString stringWithFormat:@"%@",@"Fix"], @"post_type",[NSString stringWithFormat:@"%@",@"NO"], @"close_status",[NSString stringWithFormat:@"%@",@"1"], @"post_status",[NSString stringWithFormat:@"%@",@"true"], @"image_flag",[NSString stringWithFormat:@"%d",appDelegate.domineID], @"domain_id",[NSString stringWithFormat:@"%@",@"0"], @"post_display_status",linkArray,@"link",nil];
        
        [Webservices requestPostUrl:PostThread parameters:parametersDictionary success:^(NSDictionary *responce) {
           
            [self.view makeToast:@"Sent successfully" duration:3.0 position:CSToastPositionTop];
            self.textview_Chat.text = @"";
            [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
            [self ThreadsreplyAPICalling];
            
            if ([[responce valueForKey:@"status"]isEqualToString:@"Failure"]) {
                
            }
            
        } failure:^(NSError *error) {
           [self->appDelegate.loaderView removeFromSuperview];
        }];
        
    }else if (button.tag ==2){
        
        NSAttributedString *s = self.textview_Chat.attributedText;
        NSDictionary *documentAttributes = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
        NSData *htmlData = [s dataFromRange:NSMakeRange(0, s.length) documentAttributes:documentAttributes error:NULL];
        NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
        NSMutableArray *linkArray = [[NSMutableArray alloc]init];
        NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:   [NSString stringWithFormat:@"%@",@"dG9wZml4MTIz"], @"api_key",
                                              [NSString stringWithFormat:@"%d",appDelegate.loginID], @"user_id",
                                              [NSString stringWithFormat:@"%@",threadID], @"thread_id",
                                              [NSString stringWithFormat:@"%@",htmlString], @"description",[NSString stringWithFormat:@"%@",@"Fix"], @"post_type",[NSString stringWithFormat:@"%@",@"NO"], @"close_status",[NSString stringWithFormat:@"%@",@"2"], @"post_status",[NSString stringWithFormat:@"%@",@"true"], @"image_flag",[NSString stringWithFormat:@"%d",appDelegate.domineID], @"domain_id",[NSString stringWithFormat:@"%@",@"0"], @"post_display_status",linkArray,@"link",nil];
        
        [Webservices requestPostUrl:PostThread parameters:parametersDictionary success:^(NSDictionary *responce) {
           
            [self.view makeToast:@"Sent successfully" duration:3.0 position:CSToastPositionTop];
             self.textview_Chat.text = @"";
            [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
            [self ThreadsreplyAPICalling];
            
            if ([[responce valueForKey:@"status"]isEqualToString:@"Failure"]) {
                
            }
            
        } failure:^(NSError *error) {
             [self->appDelegate.loaderView removeFromSuperview];
        }];
    }else if (button.tag ==4){
        
        
        NSAttributedString *s = self.textview_Chat.attributedText;
        NSDictionary *documentAttributes = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
        NSData *htmlData = [s dataFromRange:NSMakeRange(0, s.length) documentAttributes:documentAttributes error:NULL];
        NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
        NSMutableArray *linkArray = [[NSMutableArray alloc]init];
        NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:   [NSString stringWithFormat:@"%@",@"dG9wZml4MTIz"], @"api_key",
                                              [NSString stringWithFormat:@"%d",appDelegate.loginID], @"user_id",
                                              [NSString stringWithFormat:@"%@",threadID], @"thread_id",
                                              [NSString stringWithFormat:@"%@",htmlString], @"description",[NSString stringWithFormat:@"%@",@"Fix"], @"post_type",[NSString stringWithFormat:@"%@",@"NO"], @"close_status",[NSString stringWithFormat:@"%@",@"0"], @"post_status",[NSString stringWithFormat:@"%@",@"true"], @"image_flag",[NSString stringWithFormat:@"%d",appDelegate.domineID], @"domain_id",[NSString stringWithFormat:@"%@",@"0"], @"post_display_status",linkArray,@"link",nil];
        
        [Webservices requestPostUrl:PostThread parameters:parametersDictionary success:^(NSDictionary *responce) {
            
            [self.view makeToast:@"Sent successfully" duration:3.0 position:CSToastPositionTop];
            self.textview_Chat.text = @"";
            [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
            [self ThreadsreplyAPICalling];
            
            if ([[responce valueForKey:@"status"]isEqualToString:@"Failure"]) {
                
            }
            
        } failure:^(NSError *error) {
             [self->appDelegate.loaderView removeFromSuperview];
        }];
    }
   
   // [self.tableview_threadDetails reloadData];
    self.view_transparentview.hidden = YES;
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    //NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
   //NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    //NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)ScrollBottom{

    //[self.tableview_threadDetails reloadData];
            if (self.tableview_threadDetails.contentSize.height > self.tableview_threadDetails.frame.size.height)
            {
//                CGPoint offset = CGPointMake(0, self.tableview_threadDetails.contentSize.height - self.tableview_threadDetails.frame.size.height);
//                [self.tableview_threadDetails setContentOffset:offset animated:YES];
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[ary_details count]-1 inSection:1];
//                    [self.tableview_threadDetails scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
            }
}
- (IBAction)deletePhotoImage:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *deleteButton = (UIButton *)sender;
        NSMutableArray *mutableImages = [NSMutableArray arrayWithArray:self.images];
        [mutableImages removeObjectAtIndex:deleteButton.tag];
        self.images = [mutableImages copy];
        [self.collectionView performBatchUpdates:^{
            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:deleteButton.tag inSection:0]]];
        } completion:nil];
    }
}
#pragma mark Text Field Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
 
//    [UIView animateWithDuration:0.3 animations:^
//     {
//          CGRect rect = self.view.frame;
//         rect.origin.y -= kOFFSET_FOR_KEYBOARD;
//         rect.size.height += kOFFSET_FOR_KEYBOARD;
//         self.view.frame = rect;
//
//     }
//     ];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
//    CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
//    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
//    NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];
//    NSLog(@"%@",visibleIndexPath);
//
//
//    NSLog(@"%@",Caption);
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    // add your method here
  
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
   // [self setViewMovedUp:NO];
    CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];
    [Caption setObject:_textfirld_caption.text forKey:[NSString stringWithFormat:@"%ld",(long)visibleIndexPath.row]];
//    [UIView animateWithDuration:0.3 animations:^
//     {
//         CGRect rect = self.view.frame;
//         rect.origin.y += kOFFSET_FOR_KEYBOARD*3;
//         rect.size.height -= kOFFSET_FOR_KEYBOARD;
//         self.view.frame = rect;
//
//     }
//     ];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];
   [Caption setObject:searchStr forKey:[NSString stringWithFormat:@"%ld",(long)visibleIndexPath.row]];
    return YES;
}

-(void)imageUpload:(NSString *)ID{
    //NSLog(@"self.textfield_mailid.text%@",self.textfield_mailid.text);
    self.label_uploading.text = [NSString stringWithFormat:@"Uploading...."];
    self.view_progressbar.value = 0.0f;
    [appDelegate.loaderView removeFromSuperview];
    for (int i = 0; i < self.images.count; i++) {
        NSString * caption;
        if (![Caption valueForKey:[NSString stringWithFormat:@"%d",i]]) {
            caption = @"";
        }else{
            caption = [Caption valueForKey:[NSString stringWithFormat:@"%d",i]];
        }
        NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key",[NSString stringWithFormat:@"%lu",(unsigned long)[self.images count]],@"upload_count",[NSString stringWithFormat:@"%@",ID],@"post_id",[NSString stringWithFormat:@"%@",@"image/jpeg"],@"type",[NSString stringWithFormat:@"%@",@"true"],@"upload_flag",[NSString stringWithFormat:@"%@",caption],@"file_caption",[NSString stringWithFormat:@"%@",@"NO"],@"reattempt",nil];
         NSURL *URL = [NSURL URLWithString:ReplyImages];
        UIImage *myImageObj = [self.images objectAtIndex:i];
        NSData *imageData= UIImageJPEGRepresentation(myImageObj, 1);

        int percentComplete = i;
        NSString *combined = [NSString stringWithFormat: @"%d/%lu",percentComplete, [self.images count]];
        self.label_totalcount.text = combined;
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URL.absoluteString parameters:parametersDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                        {
                                            [formData appendPartWithFileData:imageData
                                                                        name:@"file"
                                                                    fileName:[NSString stringWithFormat:@"%d",i] mimeType:@"image/jpeg"];
                                            
                           
                                            
                                        } error:nil];
        
        NSURLSessionUploadTask *uploadTask;
        uploadTask = [manager
                      uploadTaskWithStreamedRequest:request
                      progress:^(NSProgress * _Nonnull uploadProgress) {
                          
                          dispatch_async(dispatch_get_main_queue(), ^{
                              self.view_backsideCollectionview.hidden = YES;
                              self.view_progress.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5f];
                              self.view_progress.hidden = NO;
                              [self.view bringSubviewToFront:self.view_progress];
                            
//                              self.label_totalcount.text = combined; NSLog(@"progress%lld",uploadProgress.completedUnitCount);
                              [UIView animateWithDuration:2.f animations:^{
                                  self.view_progressbar.value =100.f - uploadProgress.fractionCompleted;
//
                                 
                                  
                              }];

                          });
                          
                      }
                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                          
                          //NSLog(@"responseObject%@",responseObject);
//
                          if (error)
                          {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  
                                  self->ary_details=[[NSMutableArray alloc]init];
                                  self.label_uploading.text = [NSString stringWithFormat:@"Completed."];
                                  self.view_progressbar.value =100.f;
                                  NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key",[NSString stringWithFormat:@"%d",self->appDelegate.loginID],@"user_id",[NSString stringWithFormat:@"%d",self->appDelegate.domineID],@"domain_id",[NSString stringWithFormat:@"%@",self->threadID],@"thread_id",nil];
                                  
                                  
                                  
                                  NSURL *URL = [NSURL URLWithString:postList];
                                  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                  [manager.operationQueue cancelAllOperations];
                                  [manager GET:URL.absoluteString parameters:parametersDictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                                      
                                      if (![[responseObject objectForKey:@"result"] isEqualToString:@"No record found."]) {
                                          
                                          [self->ary_details addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"post"]];
                                         [self.tableview_threadDetails reloadData];
                                          
                                      }
                                       self.view_progress.hidden = YES;
                                      [manager.session invalidateAndCancel];
                                     
                                      [self reload];
                                     
                                      
                                     
                                     
                        
                                  } failure:^(NSURLSessionTask *operation, NSError *error) {
                                      //NSLog(@"Error: %@", error);
                                      [self->appDelegate.loaderView removeFromSuperview];
                                  }];
                              });
                              

                         
                          }
                          else
                          {
                            //NSLog(@"calling2");
                          }
                      }];
        
        [uploadTask resume];
      
    }
   
    
    
    
  
}

-(void)VideoUpload:(NSString *)ID{
    self.label_uploading.text = [NSString stringWithFormat:@"Uploading...."];
    self.view_progressbar.value = 0.0f;
    [appDelegate.loaderView removeFromSuperview];
    for (int i = 0; i < self.images.count; i++) {
        NSString * caption;
        if (![Caption valueForKey:[NSString stringWithFormat:@"%d",i]]) {
            caption = @"";
        }else{
            caption = [Caption valueForKey:[NSString stringWithFormat:@"%d",i]];
        }
     
    NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key",[NSString stringWithFormat:@"%lu",(unsigned long)[self.images count]],@"upload_count",[NSString stringWithFormat:@"%@",ID],@"post_id",[NSString stringWithFormat:@"%@",@"video/mp4"],@"type",[NSString stringWithFormat:@"%@",@"true"],@"upload_flag",[NSString stringWithFormat:@"%@",caption],@"file_caption",[NSString stringWithFormat:@"%@",@"NO"],@"reattempt",nil];
   
   int percentComplete = i;
    NSString *combined = [NSString stringWithFormat: @"%d/%lu",percentComplete, [self.images count]];
    self.label_totalcount.text = combined;
        NSURL *URL = [NSURL URLWithString:ReplyImages];
         NSData *imageData = [NSData dataWithContentsOfURL:[[_VideoURL valueForKey:@"URL"] objectAtIndex:0]];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URL.absoluteString parameters:parametersDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                        {
                                            [formData appendPartWithFileData:imageData
                                                                        name:@"file"
                                                                    fileName:[NSString stringWithFormat:@"%d",i] mimeType:@"video/mp4"];



                                        } error:nil];

        NSURLSessionUploadTask *uploadTask;
        uploadTask = [manager
                      uploadTaskWithStreamedRequest:request
                      progress:^(NSProgress * _Nonnull uploadProgress) {

                          dispatch_async(dispatch_get_main_queue(), ^{
                              self.view_backsideCollectionview.hidden = YES;
                              self.view_progress.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5f];
                              self.view_progress.hidden = NO;
                              [self.view bringSubviewToFront:self.view_progress];

                              //                              self.label_totalcount.text = combined; NSLog(@"progress%lld",uploadProgress.completedUnitCount);
                              [UIView animateWithDuration:2.f animations:^{
                                  self.view_progressbar.value =100.f - uploadProgress.fractionCompleted;
                                  //


                              }];

                          });

                      }
                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                         
                              self.label_uploading.text = [NSString stringWithFormat:@"Completed."];
                              self.view_progressbar.value =100.f;
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  
                                  
                                  self->ary_details=[[NSMutableArray alloc]init];
                                  self.label_uploading.text = [NSString stringWithFormat:@"Completed."];
                                  self.view_progressbar.value =100.f;
                                  NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key",[NSString stringWithFormat:@"%d",self->appDelegate.loginID],@"user_id",[NSString stringWithFormat:@"%d",self->appDelegate.domineID],@"domain_id",[NSString stringWithFormat:@"%@",self->threadID],@"thread_id",nil];
                                  
                                  
                                  
                                  NSURL *URL = [NSURL URLWithString:postList];
                                  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                                  [manager.operationQueue cancelAllOperations];
                                  [manager GET:URL.absoluteString parameters:parametersDictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                                      
                                      if (![[responseObject objectForKey:@"result"] isEqualToString:@"No record found."]) {
                                          
                                          [self->ary_details addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"post"]];
                                          [self.tableview_threadDetails reloadData];
                                          
                                      }
                                      self.view_progress.hidden = YES;
                                      [manager.session invalidateAndCancel];
                                      
                                      [self reload];
                                      
                                      
                                      
                                      
                                      
                                  } failure:^(NSURLSessionTask *operation, NSError *error) {
                                      //NSLog(@"Error: %@", error);
                                      [self->appDelegate.loaderView removeFromSuperview];
                                  }];
                              });

                        
                      }];

        [uploadTask resume];
}
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD*3;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
        self.view.frame = rect;
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        CGRect rect = self.view.frame;
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        self.view.frame = rect;
        
    }
    
    
    [UIView commitAnimations];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.textfirld_caption.text = @"";
    CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];
    
   if ([Caption objectForKey:[NSString stringWithFormat:@"%ld",(long)visibleIndexPath.row]]) {
            self.textfirld_caption.text = [Caption objectForKey:[NSString stringWithFormat:@"%ld",(long)visibleIndexPath.row]];
        } else {
            
           
        }
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];

    if ([Caption objectForKey:[NSString stringWithFormat:@"%ld",(long)visibleIndexPath.row]]) {
        self.textfirld_caption.text = [Caption objectForKey:[NSString stringWithFormat:@"%ld",(long)visibleIndexPath.row]];
    } else {
      

    }
}

-(void)reload{
    
      [self.tableview_threadDetails reloadData];
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: [ary_details count]-1 inSection: 1];
    [_tableview_threadDetails scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
       self.images = [[NSArray alloc]init];
    //[self HideandUnhideView];
}

-(void)HideandUnhideView{
    CGRect frame = self.tableview_threadDetails.frame;
    frame.size.height = self.view.frame.size.height-self.doc.frame.size.height*3;
    self.tableview_threadDetails.frame = frame;
    
}

-(void) triggerAction:(NSNotification *) notification
{
    _VideoURL = [[NSMutableArray alloc]init];
    [_VideoURL addObject:[notification.userInfo valueForKey:@"URL"]];
    self.images = @[[self testGenerateThumbNailDataWithVideo:[[_VideoURL valueForKey:@"URL"] objectAtIndex:0]]];
    [self.view bringSubviewToFront:self.view_backsideCollectionview];
    self.view_backsideCollectionview.hidden = NO;
    [self.collectionView reloadData];
    
}
-(UIImage*)testGenerateThumbNailDataWithVideo:(AVAsset *)vidPath {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:vidPath options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

@end
