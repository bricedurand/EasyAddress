//
//  EAAddressViewController.h
//  EasyAddress
//
//  Created by Brice Durand on 4/5/13.
//  Copyright (c) 2013 Brice Durand. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAAddress;
@protocol EAAddressDetailViewControllerDelegate;

@interface EAAddressDetailViewController : UITableViewController <UITextFieldDelegate>

@property (copy, nonatomic) EAAddress *address;
@property (weak, nonatomic) id<EAAddressDetailViewControllerDelegate> delegate;
@property (assign, nonatomic) NSInteger row;
@property (strong, nonatomic) NSArray *fieldLabels;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)textFieldDone:(id)sender;

@end


@protocol EAAddressDetailViewControllerDelegate <NSObject>
- (void)addressDetailViewController:(EAAddressDetailViewController *)controller
                   didUpdateAddress:(EAAddress *)address;
@end