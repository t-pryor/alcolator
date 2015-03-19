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
