//
//  EAAddressViewController.h
//  EasyAddress
//
//  Created by Brice Durand on 4/5/13.
//  Copyright (c) 2013 Brice Durand. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAAddress;

@interface EAAddressDetailViewController : UITableViewController <UITextFieldDelegate>

@property (copy, nonatomic) EAAddress *address;
@property (assign, nonatomic) NSInteger row;
@property (strong, nonatomic) NSArray *fieldLabels;

@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *metroTextField;
@property (weak, nonatomic) IBOutlet UITextField *notesTextField;

- (IBAction)send:(id)sender;
- (IBAction)textFieldDone:(id)sender;


@end