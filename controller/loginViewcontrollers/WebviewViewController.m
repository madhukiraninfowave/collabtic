//
//  WebviewViewController.m
//  Collabtic
//
//  Created by mobile on 12/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "WebviewViewController.h"
#import "WebUrl.h"
#import <AFNetworking.h>
#import "AppDelegate.h"
@interface WebviewViewController (){
    
  AppDelegate * appDelegate;
}

@end

@implementation WebviewViewController
@synthesize typeString,webview_tearmcondition;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.label_Headline.text = [NSString stringWithFormat:@"%@",typeString];
    if ([typeString isEqualToString:@"Terms and conditions"]) {
        NSURL *URL = [NSURL URLWithString:termscondition];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
          
            int fontValue = 150;
            NSString *webviewFontSize = [NSString stringWithFormat:[responseObject valueForKey:@"content"],fontValue];
            [self->webview_tearmcondition loadHTMLString:webviewFontSize baseURL:nil];
            [self.webview_tearmcondition setDelegate:self];
            self.webview_tearmcondition.scalesPageToFit=YES;
            [self.view addSubview:self->webview_tearmcondition];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

    }else{
        NSURL *URL = [NSURL URLWithString:privacypolicy];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            int fontValue = 150;
            NSString *webviewFontSize = [NSString stringWithFormat:[responseObject valueForKey:@"content"],fontValue];
            [self->webview_tearmcondition loadHTMLString:webviewFontSize baseURL:nil];
            [self.webview_tearmcondition setDelegate:self];
            self.webview_tearmcondition.scalesPageToFit=YES;
            [self.view addSubview:self->webview_tearmcondition];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    }
    

}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self.view addSubview:appDelegate.loaderView];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
     [appDelegate.loaderView removeFromSuperview];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button_close:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }
                     completion:^(BOOL finished){
                     }];
    [self.navigationController popViewControllerAnimated:NO];
    
}
@end
