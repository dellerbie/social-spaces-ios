//
//  MWWebViewController.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/27/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWWebViewController.h"

@interface MWWebViewController ()

@end

@implementation MWWebViewController

- (void)loadView
{
  CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
  UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
  [wv setScalesPageToFit:YES];
  [self setView:wv];
}

- (UIWebView *)webView
{
  return (UIWebView *)[self view];
}

@end
