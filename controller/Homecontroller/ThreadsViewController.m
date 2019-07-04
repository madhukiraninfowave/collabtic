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

@interface ThreadsViewController (){
     ThreadsTableViewCell * cell;
    BOOL _selected;
}

@property (strong, nonatomic) IBOutlet UITableView *table_threads;

@end

@implementation ThreadsViewController
    
    - (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.table_threads.estimatedRowHeight = 300.0;
//
//    self.table_threads.rowHeight = UITableViewAutomaticDimension;
    [self.table_threads registerNib:[UINib nibWithNibName:@"ThreadsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThreadsID"];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    
     ThreadsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ThreadsID"];
    cell.button_thumb.particleImage = [UIImage imageNamed:@"sparkle"];
    cell.button_thumb.particleScale = 0.05;
    cell.button_thumb.particleScaleRange = 0.02;
    if (!cell)
    {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ThreadsID"];
        
    }
     cell.button_thumb.tag = indexPath.row;
    [cell.button_thumb addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    CGRect frame = cell.view_imagethubnails.frame;
//    frame.size.height = 0;
//   cell.view_imagethubnails.frame = frame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ThreadsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThreadsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ThreadsID"];
    
    
      return cell.contentView.frame.size.height;
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
@end
