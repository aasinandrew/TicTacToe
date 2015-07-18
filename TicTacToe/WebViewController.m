//
//  WebViewController.m
//  TicTacToe
//
//  Created by Andrew  Nguyen on 7/16/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://en.wikipedia.org/wiki/Tic-tac-toe"]]];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

}

@end
