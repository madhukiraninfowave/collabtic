//
//  ThreadsViewController.m
//  Collabtic
//
//  Created by mobile on 02/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "ThreadsViewController.h"
#import "ThreadsTableViewCell.h"
#import "MCFireworksButton.h"
#import "UIView+Toast.h"
#import <AFNetworking.h>
#import "WebUrl.h"
#import "AppDelegate.h"
#import <UIKit/UIView.h>

@interface ThreadsViewController (){
     ThreadsTableViewCell * cell;
    BOOL _selected;
    NSMutableArray *ary_Threads;
}

@property (strong, nonatomic) IBOutlet UITableView *table_threads;

@end

@implementation ThreadsViewController{
    
    AppDelegate *appDelegate;
  NSMutableDictionary*heightAtIndexPath;
    
}
    
    - (void)viewDidLoad {
    [super viewDidLoad];
       appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [self.view addSubview:appDelegate.loaderView];
    // Do any additional setup after loading the view.
    
    self.table_threads.estimatedRowHeight = 100;
//
//    self.table_threads.rowHeight = UITableViewAutomaticDimension;
   [self.table_threads registerNib:[UINib nibWithNibName:@"ThreadsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThreadsID"];
        [self.view addSubview:appDelegate.loaderView];
       
        self.table_threads.dataSource = self;
        self.table_threads.delegate = self;
        heightAtIndexPath = [NSMutableDictionary new];
        self.table_threads.estimatedRowHeight = UITableViewAutomaticDimension;
        self.table_threads.rowHeight = UITableViewAutomaticDimension;
}
- (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     [self ThreadsAPICalling:[NSString stringWithFormat:@"0"] limit:[NSString stringWithFormat:@"30"]];
    
    
}
#pragma Tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ary_Threads count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // number of cells or array count
    return 1;
}


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
    NSLog(@"%@",ary_Threads);

    static NSString *simpleTableIdentifier = @"ThreadsID";
    
    ThreadsTableViewCell *cell1 = (ThreadsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  
    cell1.button_thumb.particleImage = [UIImage imageNamed:@"sparkle"];
    cell1.button_thumb.particleScale = 0.05;
    cell1.button_thumb.particleScaleRange = 0.02;
    cell1.button_pin.particleScale = 0.05;
    cell1.button_pin.particleScaleRange = 0.02;
    self.table_threads.delegate = self;
    if (!cell1)
    {
    
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ThreadsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    [cell1.contentView sizeToFit];
    [cell1.contentView layoutSubviews];
    cell1.view_imagethubnails.translatesAutoresizingMaskIntoConstraints = NO;
    [cell1.imageview_profile setImageURL:[NSURL URLWithString:[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"profile_image"]]];
    
    [cell1.imageview_badge setImageURL:[NSURL URLWithString:[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"badge_image"]]];
    
    cell1.label_username2.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"badgestatus"]];
    cell1.label_username.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"user_name"]];
    cell1.lbl_date.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"created_on"]];
    cell1.label_title.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"thread_title"]];
    cell1.label_description.text = [self convertHtmlPlainText:[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"content"]];
    if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"trim"] count]!=0) {
        cell1.label_make.text = [NSString stringWithFormat:@"%@",[[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"trim"] objectAtIndex:0]];
    }if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue] !=0) {
        
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue]>1) {
            cell1.label_likes.text = [NSString stringWithFormat: @"%@ Likes", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
        }else{
            cell1.label_likes.text = [NSString stringWithFormat: @"%@ Like", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
        }
        
    } if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue] !=0){
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue]>1) {
            cell1.label_pins.text = [NSString stringWithFormat: @"%@ Pins", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
        }else{
            
            cell1.label_pins.text = [NSString stringWithFormat: @"%@ Pin", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
        }
        
        
    }if(![[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"]isKindOfClass:[NSNull class]] && [[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]!=0) {
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]>1) {
            cell1.label_views.text = [NSString stringWithFormat: @"%@ Views", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"]];
        }else{
            cell1.label_views.text = [NSString stringWithFormat: @"%@ View", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"]];
        }
        
        
    }
    
    if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]!=0) {
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]>1) {
            cell1.label_views.text = [NSString stringWithFormat: @"%@ Comments", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"]];
        }else{
            cell1.label_views.text = [NSString stringWithFormat: @"%@ Comment", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"]];
        }
    }
   
//    frame.size.height = 0;
//    cell1.view_imagethubnails.frame = frame;
    if (![[NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_make"]] isEqualToString:@""]) {
        cell1.label_machinename.hidden = NO;
         cell1.label_machinename.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_make"]];
        
    }
    if (![[NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_name"]] isEqualToString:@""]){
        cell1.label_machineno.hidden = NO;
        cell1.imageview_machine.hidden = NO;
         cell1.imageview_machineDate.hidden = YES;
        cell1.label_machineno.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_name"]];
        
    }
    if (![[NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_year"]] isEqualToString:@""]){
        cell1.imageview_machineDate.hidden = NO;
        cell1.label_machineDate.text = [NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"model_year"]];
    }
   
 
    cell1.button_thumb.tag = indexPath.row;
    [cell1.button_thumb addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
    cell1.button_pin.tag = indexPath.row;
    [cell1.button_pin addTarget:self action:@selector(myActionPin:) forControlEvents:UIControlEventTouchUpInside];
    cell1.button_share.tag = indexPath.row;
    [cell1.button_share addTarget:self action:@selector(myActionShare:) forControlEvents:UIControlEventTouchUpInside];
    if (![[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] count]) {
        cell1.view_imagethubnails.hidden = YES;
        cell1.imageview_image1.hidden = YES;
        cell1.imageview_image2.hidden = YES;
        cell1.label_imageview1.hidden = YES;
        cell1.label_imageview2.hidden = YES;
        cell1.imageview_center.hidden = YES;
        cell1.label_centerimage.hidden = YES;
    }else{
        cell1.view_imagethubnails.hidden = NO;
        cell1.imageview_image1.hidden = NO;
        cell1.imageview_image2.hidden = NO;
        cell1.label_imageview1.hidden = NO;
        cell1.label_imageview2.hidden = NO;
    }
    if ([[NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"availability"]] isEqualToString:@"0"]) {
        cell1.label_online.backgroundColor = [UIColor colorWithRed:216/255.0f green:61/255.0f blue:61/255.0f alpha:1];
    }else if ([[NSString stringWithFormat:@"%@",[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"availability"]] isEqualToString:@"1"]){
          cell1.label_online.backgroundColor = [UIColor greenColor];
    }
    
    
   return cell1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ThreadsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = @(cell.frame.size.height);
    [heightAtIndexPath setObject:height forKey:indexPath];
        static NSString *simpleTableIdentifier = @"ThreadsID";
    ThreadsTableViewCell *cell1 = (ThreadsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (![[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] count]) {
        cell1.view_imagethubnails.hidden = YES;
        cell1.imageview_image1.hidden = YES;
        cell1.imageview_image2.hidden = YES;
        cell1.label_imageview1.hidden = YES;
        cell1.label_imageview2.hidden = YES;
        cell1.imageview_center.hidden = YES;
        cell1.label_centerimage.hidden = YES;
        
 
    }else{
        
        cell1.view_imagethubnails.hidden = NO;
        cell1.view_imagethubnails.hidden = NO;
        cell1.imageview_image1.hidden = NO;
        cell1.imageview_image2.hidden = NO;
        cell1.label_imageview1.hidden = NO;
        cell1.label_imageview2.hidden = NO;
       
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] count]==1){
            cell1.view_imagethubnails.hidden = NO;
            cell.imageview_image1.hidden = YES;
            cell.imageview_image2.hidden = YES;
            cell.label_imageview1.hidden = YES;
            cell.label_imageview2.hidden = YES;
            cell.imageview_center.hidden = NO;
            cell.label_centerimage.hidden = NO;
            
           
           
        }
        
    }
    if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue] !=0) {
        
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"] intValue]>1) {
            cell.label_likes.text = [NSString stringWithFormat: @"%@ Likes", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
        }else{
            cell.label_likes.text = [NSString stringWithFormat: @"%@ Like", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"like_count"]];
        }
        
    } if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue] !=0){
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"] intValue]>1) {
            cell.label_pins.text = [NSString stringWithFormat: @"%@ pins", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
        }else{
            
            cell.label_pins.text = [NSString stringWithFormat: @"%@ pin", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"pin_count"]];
        }
        
        
    }if(![[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"]isKindOfClass:[NSNull class]] && [[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]!=0) {
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"] intValue]>1) {
            cell.label_views.text = [NSString stringWithFormat: @"%@ views", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"]];
        }else{
            cell.label_views.text = [NSString stringWithFormat: @"%@ view", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"view"]];
        }
        
        
    }
    
    if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]!=0) {
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"] intValue]>1) {
            cell.label_views.text = [NSString stringWithFormat: @"%@ comments", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"]];
        }else{
            cell.label_views.text = [NSString stringWithFormat: @"%@ comment", [[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"comment"]];
        }
    }
    if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] count]!=0 ) {
        
        [cell.imageview_image1 setImageURL:[NSURL URLWithString:[[[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"thumb_file_path"]]];
        cell.label_imageview1.text = [NSString stringWithFormat:@"%@",[[[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"original_name"]];
            cell.label_centerimage.text = [NSString stringWithFormat:@"%@",[[[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"original_name"]];
    
            [cell.imageview_center setImageURL:[NSURL URLWithString:[[[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] objectAtIndex:0] valueForKey:@"thumb_file_path"]]];

        
        if ([[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] count]>1) {
            if ([[[[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] objectAtIndex:1] valueForKey:@"file_type"]isEqualToString:@"video/mp4"]) {
                [cell.imageview_image2 setImageURL:[NSURL URLWithString:[[[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] objectAtIndex:1] valueForKey:@"poster_image"]]];
                     cell.label_imageview2.text = [NSString stringWithFormat:@"%@",[[[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] objectAtIndex:1] valueForKey:@"original_name"]];
                
            }else{
                [cell.imageview_image2 setImageURL:[NSURL URLWithString:[[[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] objectAtIndex:1] valueForKey:@"thumb_file_path"]]];
                
            }
        }
        
    }
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        NSLog(@"end of loading");
        //end of loading
//        [self Reload];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThreadsTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"ThreadsID"];
    if (![[[ary_Threads objectAtIndex:indexPath.row] valueForKey:@"image"] count]) {
       return cell1.contentView.frame.size.height-cell1.view_imagethubnails.frame.size.height;
    }else{
        return cell1.contentView.frame.size.height ;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = [heightAtIndexPath objectForKey:indexPath];
    if(height) {
        return height.floatValue;
    } else {
        return UITableViewAutomaticDimension;
    }
}
-(void)Reload{
    [self.table_threads reloadData];
}
-(NSString *)dateConverter:(NSString *)str{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d, yyyy,HH:mm:ss a"];
    NSDate *date  = [dateFormatter dateFromString:str];
    
    // Convert to new Date Format
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    
    return newDate;
}
/*
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)myAction:(id)sender{
    
    UIButton *button=(UIButton *)sender;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    ThreadsTableViewCell *tappedCell = (ThreadsTableViewCell *)[self.table_threads cellForRowAtIndexPath:indexpath];
    if ([tappedCell.button_thumb.imageView.image isEqual:[UIImage imageNamed:@"Like"]])
    {
        [tappedCell.button_thumb popOutsideWithDuration:0.5];
        [tappedCell.button_thumb setImage:[UIImage imageNamed:@"Like_blue"] forState:UIControlStateNormal];
        [tappedCell.button_thumb animate];
    }
    else
    {
       [tappedCell.button_thumb popInsideWithDuration:0.4];
       [tappedCell.button_thumb setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
    
}
-(void)myActionPin:(id)sender{
    
    UIButton *button=(UIButton *)sender;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    ThreadsTableViewCell *tappedCell = (ThreadsTableViewCell *)[self.table_threads cellForRowAtIndexPath:indexpath];
    if ([tappedCell.button_pin.imageView.image isEqual:[UIImage imageNamed:@"pin_normal"]])
    {
        [tappedCell.button_pin popOutsideWithDuration:0.5];
        [tappedCell.button_pin setImage:[UIImage imageNamed:@"pinfill"] forState:UIControlStateNormal];
        [tappedCell.button_pin animate];
    }
    else
    {
        [tappedCell.button_pin popInsideWithDuration:0.4];
        [tappedCell.button_pin setImage:[UIImage imageNamed:@"pin_normal"] forState:UIControlStateNormal];
    }
    
    
}

-(void)myActionShare:(id)sender{
    

    
    
}

#pragma web Service Calling
-(void)ThreadsAPICalling:(NSString *)offset limit:(NSString *)limit {
 
    [appDelegate.loaderView removeFromSuperview];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    ary_Threads=[[NSMutableArray alloc]init];
    
    NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSString stringWithFormat:@"%@",@"recentthread"], @"type",
                                          [NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key", [NSString stringWithFormat:@""],@"search_text", [NSString stringWithFormat:@"%@",@""],@"filter",[NSString stringWithFormat:@"%d",appDelegate.loginID],@"user_id",[NSString stringWithFormat:@"%d",appDelegate.domineID],@"domain_id",[NSString stringWithFormat:@"%@",limit],@"limit",[NSString stringWithFormat:@"%@",offset],@"offset",nil];
    
    
    
    NSURL *URL = [NSURL URLWithString:Threads];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:parametersDictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        [self->ary_Threads addObjectsFromArray:[[responseObject valueForKey:@"data"] valueForKey:@"thread"]];
        [self.table_threads reloadData];
        [self->appDelegate.loaderView  removeFromSuperview];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
-(NSString*)convertHtmlPlainText:(NSString*)HTMLString{
    NSData *HTMLData = [HTMLString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];
    NSString *plainString = attrString.string;
    
    return plainString;
}

@end
