//
//  BLCWhiskeyViewController.m
//  Alcolator
//
//  Created by Tim on 2015-03-17.
//  Copyright (c) 2015 Tim Pryor. All rights reserved.
//

#import "BLCWhiskeyViewController.h"

@interface BLCWhiskeyViewController ()

@end

@implementation BLCWhiskeyViewController


- (instancetype) init {
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Whiskey", nil);
  }
  // self.view.backgroundColor = [UIColor colorWithRed:0.192 green:0.192 blue:0.988 alpha:1];

  NSLog(@"IN init");
  
  return self;
}

- (void) viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithRed:0.992 green:0.992 blue:0.588 alpha:1];
  NSLog(@"IN viewDidLoad");
}

// override buttonPressed
- (void)buttonPressed:(UIButton *)sender {
  [self.beerPercentTextField resignFirstResponder];
  
  int numberOfBeers = self.beerCountSlider.value;
  int ouncesInOneBeerGlass = 12;  // assume they are 12oz beer bottles
  
  float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
  float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
  float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
  
  float ouncesInOneWhiskeyGlass = 1; // a 1oz shot
  float alcoholPercentageOfWhiskey = 0.4;  // 40% is average
  
  float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
  float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
  
  NSString *beerText;
  
  if (numberOfBeers == 1) {
    beerText = NSLocalizedString(@"beer", @"singular beer");
  } else {
    beerText = NSLocalizedString(@"beers", @"plural of beer");
  }
  
  NSString *whiskeyText;
  
  if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
    whiskeyText = NSLocalizedString(@"shot", @"singular shot");
  } else {
    whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
  }
  
  NSString *resultText = [NSString stringWithFormat:
                          NSLocalizedString(@"%d %@ contains as much alcohol as %.lf %@ of whiskey.", nil),
                          numberOfBeers, beerText,
                          numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
                                        
  self.resultLabel.text = resultText;
  
  self.navigationItem.title = [NSString stringWithFormat: NSLocalizedString(@"Whiskey: %.lf %@", nil), numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
}


@end
