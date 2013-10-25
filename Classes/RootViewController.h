//
//  ViewController.h
//
//  Created by Jean-André Santoni on 10/07/13.
//  Copyright (c) 2013 Jean-André Santoni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
//#import "Cordova/CDVViewController.h"

@interface RootViewController : UIViewController
@property (nonatomic, strong) MasterViewController* masterViewController;
//@property (nonatomic, strong) CDVViewController* cdvViewController;
@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* burger;
@property (nonatomic, strong) UIView* pullviewtop;
@property (nonatomic, strong) UIView* pullviewbottom;
@property (nonatomic, readwrite, strong) UILabel* chapternametop;
@property (nonatomic, readwrite, strong) UILabel* chapternamebottom;
@property (nonatomic) BOOL triggeredtop;
@property (nonatomic) BOOL triggeredbottom;
@property (nonatomic) BOOL triggeredburger;
@property (nonatomic) BOOL dragging;
- (IBAction)burgerPushed:(id)sender;
- (void)showMenu;
- (void)hideMenu;
@end
