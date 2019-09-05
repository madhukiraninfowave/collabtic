//
//  WelcomeViewController.m
//  project
//
//  Created by Yuvarani on 05/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AsyncImageView.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "ViewController.h"
#import "UIView+Toast.h"
#import "Webservices.h"



@interface WelcomeViewController ()
{
    NSMutableArray*ary_welcomeimages;
    NSMutableArray*ary_Titleimages;
    UIPageControl *pageControl;
    int currentindex;
    AppDelegate*appDelegate;
    UIButton*btn_getstarted;
   
    
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    ary_welcomeimages=[[NSMutableArray alloc]init];
    
    NSURL *URL = [NSURL URLWithString:Splash];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {


[self->ary_welcomeimages addObjectsFromArray:[[responseObject valueForKey:@"data"] valueForKey:@"data"]];
        [self AddtheimagetoScroll];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
//[Webservices requestGetUrl:Splash success:^(NSDictionary *responce) {
//        if ([[responce valueForKey:@"status"]isEqualToString:@"Failure"]) {
//            [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
//
//        }else{
//
//            [self->ary_welcomeimages addObjectsFromArray:[[responce valueForKey:@"data"] valueForKey:@"data"]];
//            [self AddtheimagetoScroll];
//
//        }
//
//    } failure:^(NSError *error) {
//        //error
//    }];
    
   
    
//    ary_welcomeimages=[[NSArray alloc ]initWithObjects:@"screen1.jpg",
//                       @"screen2.jpg",
//                       @"screen3.jpg",
//                       @"screen4.jpg",
//                       @"screen5.jpg",
//                       @"screen6.jpg",
//                       @"screen7.jpg",
//                       @"screen8.jpg",nil];
//    ary_Titleimages= [[NSArray alloc]initWithObjects:@"title1",@"title2",@"title3",@"title4",@"title5",@"title6",@"title7",@"title8",nil];
    
    
    
}
-(void) viewWillAppear:(BOOL)animated {
    if (![[AFNetworkReachabilityManager sharedManager] isReachable])
    {
//        [self.view makeToast:@"Check your internet connection" duration:3.0 position:CSToastPositionBottom];
    }
    

    
}
-(void)AddtheimagetoScroll
{
    AsyncImageView*img_welcometour;
    [img_welcometour removeFromSuperview];
    UILabel * titleLabel;
    //UIButton *btn_getstarted;
    
    
    for (int i=0; i<[ary_welcomeimages count]; i++)
    {
        
        
        img_welcometour = [[AsyncImageView alloc] init];
        img_welcometour.frame =CGRectMake((i * self.scrollviewImages.frame.size.width)+10,self.scrollviewImages.frame.size.height/3, self.scrollviewImages.frame.size.width-20, self.scrollviewImages.frame.size.height/3);
//        NSString *combined = [NSString stringWithFormat:@"%@",[[ary_welcomeimages objectAtIndex:i] valueForKey:@"img_url"]];
//        NSString *encodedImageUrlString = [combined stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
//        NSURL *imageURL = [[NSURL alloc]initWithString:encodedImageUrlString];
        [img_welcometour setImageURL:[NSURL URLWithString:[[ary_welcomeimages objectAtIndex:i] valueForKey:@"img_url"]]];
        [img_welcometour setUserInteractionEnabled:YES];
        img_welcometour.contentMode = UIViewContentModeScaleAspectFit;
        img_welcometour.clipsToBounds = YES;
        img_welcometour.userInteractionEnabled=YES;
     img_welcometour.contentMode=UIViewContentModeScaleAspectFill;
        [_scrollviewImages addSubview: img_welcometour];
        [appDelegate.loaderView removeFromSuperview];

         titleLabel = [[UILabel alloc] init];
         titleLabel.frame =CGRectMake(img_welcometour.frame.origin.x+15,img_welcometour.frame.origin.y+img_welcometour.frame.size.height,img_welcometour.frame.size.width-20, img_welcometour.frame.size.height/3);
        titleLabel.text = [NSString stringWithFormat:@"%@",[[ary_welcomeimages objectAtIndex:i] valueForKey:@"caption"]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont fontWithName:@"Halvatic-bold" size:30];
        [_scrollviewImages addSubview: titleLabel];
        [self.button_Next setBackgroundImage:[UIImage imageNamed:@"Gobutton"] forState:UIControlStateNormal];
        [self.button_Next addTarget:self
                   action:@selector(goButton:)
         forControlEvents:UIControlEventTouchUpInside];

        
        
    }
    [_scrollviewImages setContentSize:CGSizeMake(_scrollviewImages.frame.size.width*[ary_welcomeimages count],_scrollviewImages.frame.size.height)];
    
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0,img_welcometour.frame.origin.y+img_welcometour.frame.size.height+titleLabel.frame.size.height+20,_scrollviewImages.frame.size.width,20);
    pageControl.numberOfPages = [ary_welcomeimages count];
    pageControl.currentPage = 0;

    pageControl.pageIndicatorTintColor= [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [pageControl addTarget:self action:@selector(didChangePage:) forControlEvents: UIControlEventValueChanged];

    [self.view addSubview:pageControl];
    pageControl.backgroundColor = [UIColor clearColor];
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(ScrollImage) userInfo:nil repeats:YES];
}
-(void)ScrollImage
{
    CGFloat pageWidth = 0.0;
    pageWidth = _scrollviewImages.frame.size.width;
    if([ary_welcomeimages  count]>currentindex+1)
    {
        pageControl.numberOfPages=ary_welcomeimages.count;
        int page = floor((_scrollviewImages.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage=page+1;
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [_scrollviewImages.layer addAnimation:transition forKey:nil];
        
        //[_scrollviewImages addSubview:myVC.view];
        [_scrollviewImages setContentOffset:CGPointMake(pageWidth*(page+1), 0)];
        
        
      
        
        
        //        [UIView animateWithDuration:0 delay:0.0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        //        } completion:^(BOOL finished) {
        //            [UIView animateWithDuration:0.7 delay:0.0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        //
        //                if([[[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceID"] isEqualToString:@"iphone"]){
        //                    if (modelandscape==1)
        //                    {
        //                        [scrollview_start setContentOffset:CGPointMake(568*(page+1), 0)];
        //                    }
        //                    else{
        //                        [scrollview_start setContentOffset:CGPointMake(320*(page+1), 0)];
        //
        //                    }
        //
        //                }
        //                else{
        //                    if (modelandscape==1)
        //                    {
        //                        [scrollview_start setContentOffset:CGPointMake(1024*(page+1), 0)];
        //                    }
        //                    else{
        //                        [scrollview_start setContentOffset:CGPointMake(768*(page+1), 0)];
        //
        //                    }
        //                }
        //
        //
        //            } completion:^(BOOL finished)
        //             {
        //
        //             }];
        //        }];
        
        //
        
        /*
         CATransition *animation = [CATransition animation];
         animation.delegate = self;
         animation.duration = 1.0f;
         animation.timingFunction = UIViewAnimationCurveEaseInOut;
         animation.fillMode = kCAFillModeForwards;
         animation.removedOnCompletion = NO;
         animation.type = kCATransitionPush;
         animation.subtype = kCATransitionFromRight;
         [scrollview_start.layer addAnimation:animation forKey:@"animation"];
         
         if([[[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceID"] isEqualToString:@"iphone"]){
         if (modelandscape==1)
         {
         CGRect frame = scrollview_start.frame;
         frame.origin.x = 568 * (page+1);
         frame.origin.y = 0;
         [scrollview_start scrollRectToVisible:frame animated:NO];
         
         //[scrollview_start setContentOffset:CGPointMake(568*(page+1), 0)];
         }
         else{
         CGRect frame = scrollview_start.frame;
         frame.origin.x = 320 * (page+1);
         frame.origin.y = 0;
         [scrollview_start scrollRectToVisible:frame animated:NO];
         
         // [scrollview_start setContentOffset:CGPointMake(320*(page+1), 0)];
         
         }
         
         }else{
         if (modelandscape==1)
         {
         CGRect frame = scrollview_start.frame;
         frame.origin.x = 1024 * (page+1);
         frame.origin.y = 0;
         [scrollview_start scrollRectToVisible:frame animated:NO];
         
         //[scrollview_start setContentOffset:CGPointMake(568*(page+1), 0)];
         }
         else{
         CGRect frame = scrollview_start.frame;
         frame.origin.x = 768 * (page+1);
         frame.origin.y = 0;
         [scrollview_start scrollRectToVisible:frame animated:NO];
         
         // [scrollview_start setContentOffset:CGPointMake(320*(page+1), 0)];
         
         }
         
         
         }
         
         
         
         */
        
        
        //add bView to current view
        //
    }
    else if([ary_welcomeimages  count]==currentindex+1)
    {
        
        pageControl.currentPage=0;
        currentindex=0;
         [self ScrollImage];
       [_scrollviewImages setContentOffset:CGPointMake(0, 0) animated:NO];
       
        
        
        
    }
    
}
-(void)didChangePage:(UIButton*)sender
{
    currentindex= (int)sender.tag;
    CGRect frame = _scrollviewImages.frame;
    frame.origin.x = frame.size.width * currentindex;
    frame.origin.y = 0;
    [_scrollviewImages scrollRectToVisible:frame animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    CGFloat pageWidth = _scrollviewImages.frame.size.width;
    float fractionalPage = _scrollviewImages.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
    currentindex = (int)page;
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma responsce call for splash screen
-(void)ReceivedSpashscreen:(NSDictionary *)serverDic statusCode:(int)statusCode{
    NSLog(@"serverDic%@",serverDic);
}

#pragma buttonActions
-(void)goButton:(UIButton *)sender{
  
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController  *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"ViewControllerID"];
        [self.navigationController pushViewController:ViewControllerObj animated:YES];
//    }
//    else
//    {
//        [self.view makeToast:@"Check your internet connection" duration:3.0 position:CSToastPositionBottom];
//    }
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
