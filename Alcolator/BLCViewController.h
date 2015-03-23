//
//  BLCViewController.h
//  Alcolator
//
//  Created by Tim on 2015-03-16.
//  Copyright (c) 2015 Tim Pryor. All rights reserved.
//



/* NOTES
 
 .h file contains only interface code
 Interface code describes how one class communicates with another class
 Outlets represent a connection to another class, so they belong here
 
in order to let outsiders(including subclasses) make use of these secret methods
and /or properties, a class must make them public by announcing them in the .h file
 
*/


#import <UIKit/UIKit.h>

@interface BLCViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;

- (void)buttonPressed:(UIButton *) sender;

@end

