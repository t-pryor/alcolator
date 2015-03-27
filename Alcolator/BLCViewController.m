//
//  ViewController.m
//  Alcolator
//
//  Created by Tim on 2015-03-16.
//  Copyright (c) 2015 Tim Pryor. All rights reserved.
//

#import "BLCViewController.h"

// private interface
// parentheses allows you to declare this private interface inside .m file

@interface BLCViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UILabel *numberOfBeers;
@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation BLCViewController

-(instancetype) init {
  self = [super init];
  
  if (self) {
    self.title = NSLocalizedString(@"Wine", @"wine");
  }
  
  [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
  
  return self;
}

-(void)loadView {
  
  // Allocate and initialize the all-encompassing view
  self.view = [[UIView alloc] init];

  // Allocate and initialize each of our views and the gesture recognizer
  UITextField *textField = [[UITextField alloc] init];
  UISlider *slider = [[UISlider alloc] init];
  UILabel *label = [[UILabel alloc] init];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
  
  // Add each view and the gesture recognizer as the view's subviews
  [self.view addSubview:textField];
  [self.view addSubview:slider];
  [self.view addSubview:label];
  [self.view addSubview:button];
  [self.view addGestureRecognizer:tap];
  
  // Assign the views and gesture recognizer to our properties
  self.beerPercentTextField = textField;
  self.beerCountSlider = slider;
  self.resultLabel = label;
  self.calculateButton = button;
  self.hideKeyboardTapGestureRecognizer = tap;
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor yellowColor];
  
  /* beerPercentTextField Settings */
  self.beerPercentTextField.delegate = self;
  
  // Set the placeholder text
  self.beerPercentTextField.placeholder =
  NSLocalizedString(@"%Alcohol Content Per Beer", @"Beer percent placeholder text");
  
  // Assignment: Place a bezel around the text field to make more apparent
  [self.beerPercentTextField setBorderStyle: UITextBorderStyleBezel];
  
  // Assignment: Set font style and size
  [self.beerPercentTextField setFont: [UIFont fontWithName:@"HelveticaNeue" size:30]];
  
  
  /* beerCountSlider Settings */
  
  [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];

  // Set the minimum and maximum number of beers
  self.beerCountSlider.minimumValue = 1;
  self.beerCountSlider.maximumValue = 10;
  
  /* resultLabel Settings */
  
  // assignment: change the size and style of the font
  [self.resultLabel setFont:[UIFont fontWithName: @"HelveticaNeue" size:20]];
  
  // Gets rid of the maximum number of lines on the label
  self.resultLabel.numberOfLines = 0;

  /* calculateButton */
  
  // Tells self.calculateButton that when a finger is lifted from the button while still inside its bounds, to call '[self -buttonPressed:]'
  
  [self.calculateButton addTarget:self action:@selector(buttonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
  
  // Set the title of the button
  [self.calculateButton setTitle:NSLocalizedString(@"Calculate!",@"Calculate command")
                        forState:UIControlStateNormal];
  
  [self.calculateButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:24]];
  
  self.calculateButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |
  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
   UIViewAutoresizingFlexibleBottomMargin;
  
  CGPointMake(self.view.bounds.size.width /2, self.view.bounds.size.height / 2);
  
  /* tap gesture recognizer */
  
  // Tells the tap gesture recognizer to call '[self -tapGestureDidfire:]' when it detects a tap
  [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
  
  self.view.backgroundColor = [UIColor colorWithRed:0.741 green:0.925 blue:0.714 alpha:1.0];
  
}

- (void) viewWillLayoutSubviews {
  
  [super viewWillLayoutSubviews];
  
  //Every view is going to be 280 points wide, at least 44 points tall and 20 points away from anything else on screen
  
  // 320 is number of horizontal points available to all iPhones and iPods predating iPhone6
  // Dynamically set based on view controller's frame as it rotates
  CGFloat viewWidth = self.view.frame.size.width;
  // 20 is the size of the status bar
  CGFloat padding = 20;
  // itemWidth is the width each of our items will fill and allow us too keep them 20 points away from the left and right sides of the screen
  CGFloat itemWidth = viewWidth - padding - padding;
  // arbitratry, but the size of a standard navigation bar
  CGFloat itemHeight = 44;
  
  // need extra room to print out results of calculation
  CGFloat resultLabelHeight = 100;
  
  self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);

  CGFloat bottomOfBeerPercentTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
  
  self.beerCountSlider.frame = CGRectMake(padding, bottomOfBeerPercentTextField + padding, itemWidth, itemHeight);
  
  CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
  self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, resultLabelHeight);
  
  CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
  
  self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
  // Make sure the text is a number
  NSString *enteredText = sender.text;
  float enteredNumber = [enteredText floatValue];
  
  if (enteredNumber == 0) {
    // The user typed 0, or something that's not a number, so clear the field
    sender.text = nil;
  }
  
}

- (void)sliderValueDidChange:(UISlider *)sender {
  
  NSNumber *sliderValue = [NSNumber numberWithFloat:sender.value];
  NSString *beersText = [NSString stringWithFormat:@"%li", [sliderValue longValue]];
  self.numberOfBeers.text = beersText;
  NSLog(@"Slider value changed to %li", [sliderValue longValue]);
  [self.beerPercentTextField resignFirstResponder];
  [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
}
  

- (void)buttonPressed:(UIButton *)sender {
  
  [self.beerPercentTextField resignFirstResponder];
  
  // first, calculate how much alcohol is in all those beers
  int numberOfBeers = self.beerCountSlider.value;
  int ouncesInOneBeerGlass = 12; // assume they are 12oz beer bottles
  float alcoholPercentageOfBeer =
    [self.beerPercentTextField.text floatValue] / 100;
  float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
  float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
  
  // now calculate the equivalent amount of wine
  
  float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
  float alcoholPercentageOfWine = 0.13; // 13% is average
  
  float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
  float numberOfWineGlassesForEquivalentAlcoholAmount =
          ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
  
  // decide whether to use "beer"/"beers" and "glass"/glasses
  
  NSString *beerText;
  
  if (numberOfBeers == 1) {
    beerText = NSLocalizedString(@"beer", @"singular beer");
  } else {
    beerText = NSLocalizedString(@"beers", "@plural of beer");
  }
  
  NSString *wineText;
  
  if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
    wineText = NSLocalizedString(@"glass", @"singular glass");
  } else {
    wineText = NSLocalizedString(@"glasses", @"plural of glass");
  }
  
  // generate the result text, and display it on the label
  NSString *resultText =
    [NSString stringWithFormat:
     NSLocalizedString(@"%d %@ contains as much alcohol as %.lf %@ of wine.", nil),
     numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount,
     wineText];
  self.resultLabel.text = resultText;
  
  self.navigationItem.title = [NSString stringWithFormat: NSLocalizedString(@"Wine: %.lf %@", nil), numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
}

//NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", myFloat];

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
  
  [self.beerPercentTextField resignFirstResponder];

}


  
  
@end
