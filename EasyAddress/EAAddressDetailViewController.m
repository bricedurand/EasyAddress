//
//  EAAddressViewController.m
//  EasyAddress
//
//  Created by Brice Durand on 4/5/13.
//  Copyright (c) 2013 Brice Durand. All rights reserved.
//

#import "EAAddressDetailViewController.h"
#import "EAAddress.h"

#define kNumberOfEditableRows         4

#define kLabelTag                     2048
#define kTextFieldTag                 4094

#define ARCHIVE_FILE_NAME             @"address"

@implementation EAAddressDetailViewController {
    EAAddress *initialAddress;
    BOOL hasChanges;
}

- (void)textFieldDone:(id)sender
{
    [sender resignFirstResponder];
}

- (void) awakeFromNib {
    
    // Custom initialization
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(send:)];
    self.streetTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (NSString *) getFilePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:ARCHIVE_FILE_NAME];
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    [super setEditing:flag animated:animated];
    
    self.streetTextField.enabled = self.editing;
    self.cityTextField.enabled = self.editing;
    self.metroTextField.enabled = self.editing;
    self.notesTextField.enabled = self.editing;
    
    if (self.editing) {
        self.navigationItem.leftBarButtonItem.title = @"Save";
        [self.streetTextField becomeFirstResponder];
    } else {
        self.address.street = self.streetTextField.text;
        self.address.city = self.cityTextField.text;
        self.address.metro = self.metroTextField.text;
        self.address.notes = self.notesTextField.text;
        
        if (![self.address isEqual:initialAddress]) {
            [NSKeyedArchiver archiveRootObject:self.address toFile:[self getFilePath]];
        }
        
        [self.view endEditing:YES];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    
    // Load address
    self.address = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
    if (self.address == nil) {
        self.address = [EAAddress new];
    }
    
    initialAddress = [self.address copy];
    self.streetTextField.text = self.address.street;
    self.cityTextField.text = self.address.city;
    self.metroTextField.text = self.address.metro;
    self.notesTextField.text = self.address.notes;
}

#pragma mark - Table view data source



/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/



#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

#pragma mark - Messaging

- (void)send:(id)sender
{
    //    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    //    picker.peoplePickerDelegate = self;
    //    // Display only a person's phone, email, and birthdate
    //    NSArray *displayedItems = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    //
    //
    //    picker.displayedProperties = displayedItems;
    // Show the picker
    //    [self presentModalViewController:picker animated:YES];
    
    
    
    MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = [self getMessageBody];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
	}
    
    controller.delegate = self;
}

- (NSString *) getMessageBody
{
    NSString *body = [self.address description];
    NSString *mapsLink = [NSString stringWithFormat:@"https://maps.google.com/?q=%@+%@", self.address.street, self.address.city];
    [mapsLink stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    return [NSString stringWithFormat:@"%@. %@ %@",body, mapsLink, @"Sent via Easy Address app"];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"Unknown Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            //			[alert show];
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}



@end
