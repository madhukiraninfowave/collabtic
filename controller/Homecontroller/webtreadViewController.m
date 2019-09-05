//
//  webtreadViewController.m
//  Collabtic
//
//  Created by mobile on 29/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "webtreadViewController.h"
#import "AppDelegate.h"

@interface webtreadViewController (){
     AppDelegate * appDelegate;
}

@end

@implementation webtreadViewController
@synthesize webviewThread,string;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [webviewThread setDelegate:self];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webviewThread loadRequest:requestObj];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self.view addSubview:appDelegate.loaderView];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [appDelegate.loaderView removeFromSuperview];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}
- (IBAction)button_back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
