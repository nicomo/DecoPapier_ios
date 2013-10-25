//
//  RootViewController.m
//
//  Created by Jean-André Santoni on 10/07/13.
//  Copyright (c) 2013 Jean-André Santoni. All rights reserved.
//

#import "RootViewController.h"
#import "Pinterest/Pinterest.h"
#import <QuartzCore/QuartzCore.h>
int current;

@interface RootViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, readwrite, strong) UITapGestureRecognizer* tapGRtop;
@property (nonatomic, readwrite, strong) UITapGestureRecognizer* tapGRbottom;
@property (nonatomic, readwrite, strong) UISwipeGestureRecognizer *swipeGRleft;
@property (nonatomic, readwrite, strong) UISwipeGestureRecognizer *swipeGRright;
@property (nonatomic, readwrite, strong) Pinterest* pinterest;
@end

@implementation RootViewController

@synthesize masterViewController, webView, burger, triggeredtop, triggeredbottom, triggeredburger;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // MasterView (menu)
    self.masterViewController = [[MasterViewController alloc] init];
    [self addChildViewController:self.masterViewController];
    [self.view addSubview:self.masterViewController.tableView];
    [self.masterViewController didMoveToParentViewController:self];
    
    // WebView
    self.webView = [[UIWebView alloc] init];
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        self.webView.frame = CGRectMake(0, 64, 778, 960);
    } else {
        self.webView.frame = CGRectMake(0, 0, 778, 1004);
    }
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    for (UIView *view in [[[self.webView subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.hidden = YES;
        }
    }
    for (UIView *subview in self.webView.subviews) {
        subview.clipsToBounds = NO;
    }
    self.webView.scrollView.delegate = self;
    self.webView.delegate = self;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webView];

    // Top pull view
    self.pullviewtop = [[UIView alloc] initWithFrame:CGRectMake(0, -160, 768, 80)];
    self.pullviewtop.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    UIImageView* tapimgviewtop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tap.png"]];
    tapimgviewtop.frame = CGRectMake(236, 20, 40, 40);
    [self.pullviewtop addSubview:tapimgviewtop];
    UILabel* chapternumbertop = [[UILabel alloc] initWithFrame:CGRectMake(296, 20, 200, 20)];
    chapternumbertop.text = @"Passer au chapitre précédant";
    chapternumbertop.textColor = [UIColor grayColor];
    chapternumbertop.font = [UIFont italicSystemFontOfSize:14];
    chapternumbertop.backgroundColor = [UIColor clearColor];
    [self.pullviewtop addSubview:chapternumbertop];
    self.chapternametop = [[UILabel alloc] initWithFrame:CGRectMake(296, 40, 200, 20)];
    if (current > 0) self.chapternametop.text = [chapters objectAtIndex:current-1];
    self.chapternametop.textColor = [UIColor whiteColor];
    self.chapternametop.font = [UIFont boldSystemFontOfSize:14];
    self.chapternametop.backgroundColor = [UIColor clearColor];
    [self.pullviewtop addSubview:self.chapternametop];
    [self.webView addSubview:self.pullviewtop];
    
    // Bottom pull view
    self.pullviewbottom = [[UIView alloc] initWithFrame:CGRectMake(0, self.webView.scrollView.frame.size.height + 80, 768, 80)];
    self.pullviewbottom.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.pullviewbottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    UIImageView* tapimgviewbottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tap.png"]];
    tapimgviewbottom.frame = CGRectMake(236, 20, 40, 40);
    [self.pullviewbottom addSubview:tapimgviewbottom];
    UILabel* chapternumberbottom = [[UILabel alloc] initWithFrame:CGRectMake(296, 20, 200, 20)];
    chapternumberbottom.text = @"Passer au chapitre suivant";
    chapternumberbottom.textColor = [UIColor grayColor];
    chapternumberbottom.font = [UIFont italicSystemFontOfSize:14];
    chapternumberbottom.backgroundColor = [UIColor clearColor];
    [self.pullviewbottom addSubview:chapternumberbottom];
    self.chapternamebottom = [[UILabel alloc] initWithFrame:CGRectMake(296, 40, 200, 20)];
    if (current < [chapters count] - 1) self.chapternamebottom.text = [chapters objectAtIndex:current+1];
    self.chapternamebottom.textColor = [UIColor whiteColor];
    self.chapternamebottom.font = [UIFont boldSystemFontOfSize:14];
    self.chapternamebottom.backgroundColor = [UIColor clearColor];
    [self.pullviewbottom addSubview:self.chapternamebottom];
    [self.webView addSubview:self.pullviewbottom];
    
    // Burger
    [self.burger setEnabled:UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])];
    
    // Separator view
    UIView *separatorview = [[UIView alloc] init];
    separatorview.frame = CGRectMake(-1, 0, 1, 960);
    separatorview.backgroundColor = [UIColor colorWithRed:.56 green:.56 blue:.58 alpha:1];
    [self.webView addSubview:separatorview];
    [self.webView bringSubviewToFront:separatorview];
    
    self.tapGRtop = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnPullView:)];
    self.tapGRtop.delegate = self;
    [self.pullviewtop addGestureRecognizer:self.tapGRtop];
    [self.tapGRtop release];
    
    self.tapGRbottom = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnPullView:)];
    self.tapGRbottom.delegate = self;
    [self.pullviewbottom addGestureRecognizer:self.tapGRbottom];
    [self.tapGRbottom release];
    
    self.swipeGRleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.swipeGRleft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.swipeGRleft];
    
    self.swipeGRright = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.swipeGRright.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.swipeGRright];
    
    self.view.autoresizesSubviews = YES;

    self.triggeredtop = NO;
    self.triggeredbottom = NO;
    self.triggeredburger = NO;
    self.dragging = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.dragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (current > 0) {
        if (self.triggeredtop && scrollView.contentOffset.y >= -80 && !self.dragging) {
            scrollView.contentOffset = CGPointMake(0, -80);
        }
        if (scrollView.contentOffset.y < -80 && self.dragging) {
            self.triggeredtop = YES;
            [UIView animateWithDuration:0.15 animations:^{
                CGRect fr = self.pullviewtop.frame;
                fr.origin.y = 0;
                self.pullviewtop.frame = fr;
            }];
        }
        if (scrollView.contentOffset.y > -80 && scrollView.contentOffset.y < 0 && self.triggeredtop) {
            self.triggeredtop = NO;
            [UIView animateWithDuration:0.15 animations:^{
                CGRect fr = self.pullviewtop.frame;
                fr.origin.y = -160;
                self.pullviewtop.frame = fr;
            }];
        }
    }
    if (current < [chapters count] - 1) {
        float frh = scrollView.frame.size.height;
        if (self.triggeredbottom && scrollView.contentOffset.y + frh <= scrollView.contentSize.height + 80 && !self.dragging) {
            scrollView.contentOffset = CGPointMake(0, scrollView.contentSize.height - frh + 80);
        }
        if (scrollView.contentOffset.y + frh > scrollView.contentSize.height + 80 && self.dragging) {
            self.triggeredbottom = YES;
            [UIView animateWithDuration:0.15 animations:^{
                CGRect fr = self.pullviewbottom.frame;
                fr.origin.y = frh - 80;
                self.pullviewbottom.frame = fr;
            }];
        }
        if (scrollView.contentOffset.y + frh < scrollView.contentSize.height + 80 && scrollView.contentOffset.y + 1024 > scrollView.contentSize.height && self.triggeredbottom) {
            self.triggeredbottom = NO;
            [UIView animateWithDuration:0.15 animations:^{
                CGRect fr = self.pullviewbottom.frame;
                fr.origin.y = frh + 80;
                self.pullviewbottom.frame = fr;
            }];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.dragging = NO;
}

- (void)handleTapOnPullView:(UITapGestureRecognizer *)gestureRecognizer
{
    int next = self.triggeredbottom ? current + 1 : current -1;
    
    NSString* call = [NSString stringWithFormat:@"loadpage(%i, %i)", next, self.triggeredtop];
    
    [UIView animateWithDuration:0.35 animations:^{
        
        if (self.triggeredtop) {
            self.triggeredtop = NO;
            CGRect fr = self.pullviewtop.frame;
            fr.origin.y = -160;
            self.pullviewtop.frame = fr;
            [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
        if (self.triggeredbottom) {
            self.triggeredbottom = NO;
            CGRect fr = self.pullviewbottom.frame;
            fr.origin.y = self.webView.scrollView.frame.size.height + 80;
            self.pullviewbottom.frame = fr;
            [self.webView.scrollView setContentOffset:CGPointMake(0, self.webView.scrollView.contentOffset.y-80) animated:YES];
        }
        
    } completion:^(BOOL finished){
        [self.webView stringByEvaluatingJavaScriptFromString:call];
        if (next > 0) self.chapternametop.text = [chapters objectAtIndex:next-1];
        if (next < [chapters count]-1) self.chapternamebottom.text = [chapters objectAtIndex:next+1];
        NSIndexPath *ip=[NSIndexPath indexPathForRow:next inSection:0];
        [self.masterViewController.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
        current = next;
    }];
}

- (void)showMenu
{
    [UIView animateWithDuration:0.35 animations:^{
        CGRect fr2 = self.webView.frame;
        fr2.origin.x = 256;
        self.webView.frame = fr2;
        self.webView.scrollView.userInteractionEnabled = NO;
        self.triggeredburger = YES;
        if (self.triggeredtop) {
            self.triggeredtop = NO;
            CGRect fr3 = self.pullviewtop.frame;
            fr3.origin.y = -160;
            self.pullviewtop.frame = fr3;
            [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        if (self.triggeredbottom) {
            self.triggeredbottom = NO;
            CGRect fr3 = self.pullviewbottom.frame;
            fr3.origin.y = self.webView.scrollView.frame.size.height + 80;
            self.pullviewbottom.frame = fr3;
            [self.webView.scrollView setContentOffset:CGPointMake(0, self.webView.scrollView.contentOffset.y-80) animated:YES];
        }
    }];
}

- (void)hideMenu
{
    [UIView animateWithDuration:0.35 animations:^{
        CGRect fr2 = self.webView.frame;
        fr2.origin.x = 0;
        self.webView.frame = fr2;
        self.webView.scrollView.userInteractionEnabled = YES;
        self.triggeredburger = NO;
    }];
}

- (void)burgerPushed:(id)sender
{
    if (! self.triggeredburger) {
        [self showMenu];
    } else {
        [self hideMenu];
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    if (self.burger.enabled) {
        if (! self.triggeredburger && recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
            [self showMenu];
        } else if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
            [self hideMenu];
        }
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toOrientation duration:(NSTimeInterval)duration
{
    if (toOrientation == UIInterfaceOrientationPortrait ||
        toOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self.burger setEnabled:YES];
    } else if (toOrientation == UIInterfaceOrientationLandscapeLeft ||
        toOrientation == UIInterfaceOrientationLandscapeRight) {
        [self.burger setEnabled:NO];
        if (self.triggeredburger) {
            self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
            self.webView.scrollView.userInteractionEnabled = YES;
        } else {
            self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        }
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        if (self.triggeredtop) {
            self.triggeredtop = NO;
            CGRect fr3 = self.pullviewtop.frame;
            fr3.origin.y = -160;
            self.pullviewtop.frame = fr3;
        }
        if (self.triggeredbottom) {
            self.triggeredbottom = NO;
            CGRect fr3 = self.pullviewbottom.frame;
            fr3.origin.y = self.webView.scrollView.frame.size.height + 80;
            self.pullviewbottom.frame = fr3;
        }
    }];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait ||
        fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        if (self.triggeredburger) {
            self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
            self.webView.scrollView.userInteractionEnabled = YES;
            self.triggeredburger = NO;
        }
    }
}

- (BOOL)webView:(UIWebView *)webView2 shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    if ([[[request URL] absoluteString] hasPrefix:@"js-call"]) {

        NSArray *components = [[[request URL] absoluteString] componentsSeparatedByString:@":::"];
        NSString *function = [components objectAtIndex:1];

        [self performSelector:NSSelectorFromString([function stringByAppendingString:@":"]) withObject:components];

        return NO;
    }
    
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    if (navigationType == UIWebViewNavigationTypeFormSubmitted || navigationType == UIWebViewNavigationTypeFormSubmitted) {
        return ![[UIApplication sharedApplication] openURL:[request URL]];
    }

    return YES;
}

- (void)goTo:(NSArray *)components {
    NSInteger next = [[components objectAtIndex:2] integerValue];
    
    NSString* call = [NSString stringWithFormat:@"loadpage(%i, %i)", next, 0];
    
    [self.webView stringByEvaluatingJavaScriptFromString:call];

    if (next > 0) self.chapternametop.text = [chapters objectAtIndex:next-1];
    if (next < [chapters count]-1) self.chapternamebottom.text = [chapters objectAtIndex:next+1];
    NSIndexPath *ip=[NSIndexPath indexPathForRow:next inSection:0];
    [self.masterViewController.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    current = next;
}

- (void) share:(NSArray *)components {;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[components objectAtIndex:2] ofType:@"pdf" inDirectory:@"www/assets/pdf"];
    NSData *pdf = [NSData dataWithContentsOfFile:path];
    
    NSArray *activityItems = @[pdf];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void) composePin:(NSArray *)components {
    NSString* clientID = [@"1432309" retain];
    self.pinterest = [[Pinterest alloc] initWithClientId:clientID];
    NSLog([components objectAtIndex:2]);
    [self.pinterest createPinWithImageURL:[NSURL URLWithString:[components objectAtIndex:2]]
                                sourceURL:[NSURL URLWithString:@"http://www.citronours.fr"]
                              description:@"J'ai trouvé cette image dans un livre de citronours.fr"];
}

@end
