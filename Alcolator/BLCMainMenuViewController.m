//
//  BLCMainMenuViewController.m
//  Alcolator
//
//  Created by Tim on 2015-03-19.
//  Copyright (c) 2015 Tim Pryor. All rights reserved.
//

#import "BLCMainMenuViewController.h"
#import "BLCViewController.h"
#import "BLCWhiskeyViewController.h"

@interface BLCMainMenuViewController ()

@property (nonatomic, strong) UIButton *wineButton;
@property (nonatomic, strong) UIButton *whiskeyButton;

@end

// This is the bottom of the Navigation Stack, the UINavigationController's root view controller
@implementation BLCMainMenuViewController

- (void) loadView {
  
  self.wineButton = [UIButton buttonWithType:UIButtonTypeSystem];
  self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
  
  [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine") forState:UIControlStateNormal];
  [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey") forState:UIControlStateNormal];
  // target is self, action is winePressed: method for TouchUpInside
  [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  // initialize this VC's view object
   self.view = [[UIView alloc] init];
  
  // addSubviews wineButton and whiskeyButton
  [self.view addSubview:self.wineButton];
  [self.view addSubview:self.whiskeyButton];
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
  // white: grayscale value of the color object, between 0 and 1; alpha: opacity, bet. 0 and 1
  self.view.backgroundColor = [UIColor colorWithWhite:0.91f alpha:1];
  
  // set a new font. You use font objects by passing them to methods that accept them as a paraemeter.
  // boldSystemFontOfSize: returns the font object used for standard interface items that are rendered in boldface type in the specified size
  UIFont *bigFont = [UIFont boldSystemFontOfSize:20];
  
  [self.wineButton.titleLabel setFont:bigFont];

  //self.wineButton.titleLabel.font = bigFont;
  
  [self.whiskeyButton.titleLabel setFont:bigFont];
  
  self.title = NSLocalizedString(@"Select Alcolator", @"Select Alcolator");
}

- (void) viewWillLayoutSubviews {
  // In this function we create the wineButtonFrame and whiskeyButtonFrame
  
  [super viewWillLayoutSubviews];
  
  CGRect wineButtonFrame, whiskeyButtonFrame;
  
  // CGRectDivide
  // Divides a source rectangle into two component rectangles
  
  // self.view.bounds: the source rectangle
  
  // slice: &wineButtonFrame
  // On input, a pointer to an uninitialized rectangle. On return, the rectangle is filled in with the specified edge and values that extends the distance beyond the edge specified by the amount parameter.
  
  // remainder: &whiskeyButtonFrame
  // On input, a pointer to an uninitialized rectangle. On return, the rectangle contains the portion of the source rectangle that remains after CGRectEdge produces the “slice” rectangle.
  CGRectDivide(self.view.bounds, &wineButtonFrame, &whiskeyButtonFrame, CGRectGetWidth(self.view.bounds) / 2, CGRectMinXEdge);
  
  self.wineButton.frame = wineButtonFrame;
  self.whiskeyButton.frame = whiskeyButtonFrame;
  
}

- (void) winePressed:(UIButton *) sender {
  // Allocate mem for a new BLCViewController, create it, initialize it, and assign to wineVC, which points to it
  BLCViewController *wineVC = [[BLCViewController alloc] init];
  // push wineVC onto the Navigation Stack
  // navigationController is a property of UIViewController that returns the nearest Navigation Controller
  /* 
   The nearest ancestor in the view controller hierarchy that is a navigation controller. (read-only)
   If the receiver or one of its ancestors is a child of a navigation controller, this property contains the owning navigation controller. This property is nil if the view controller is not embedded inside a navigation controller.
   */
  [self.navigationController pushViewController:wineVC animated:YES];
  NSLog(@"%@", self.navigationController.viewControllers);
}

- (void) whiskeyPressed:(UIButton *) sender {

  BLCWhiskeyViewController *whiskeyVC = [[BLCWhiskeyViewController alloc] init];
  [whiskeyVC setTitle:@"FOOBAR"];
  [self.navigationController pushViewController:whiskeyVC animated:YES];
  
  NSLog(@"%@", self.navigationController.viewControllers);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
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
