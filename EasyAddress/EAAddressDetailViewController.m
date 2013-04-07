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
#define kStreetRowIndex               0
#define kZipCodeRowIndex              1
#define kMetroRowIndex                2
#define kNotesRowIndex                3

#define kLabelTag                     2048
#define kTextFieldTag                 4094

#define ARCHIVE_FILE_NAME             @"address"

@implementation EAAddressDetailViewController {
    EAAddress *initialAddress;
    BOOL hasChanges;
}

- (void)send:(id)sender
{
    
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
    
    
}

- (NSString *) getFilePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:ARCHIVE_FILE_NAME];
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    [super setEditing:flag animated:animated];
    if (self.editing) {
        self.navigationItem.leftBarButtonItem.title = @"Save";
        self.streetTextField.enabled = YES;
        self.zipCodeTextField.enabled = YES;
        self.metroTextField.enabled = YES;
        self.notesTextField.enabled = YES;
    } else {
        self.streetTextField.enabled = NO;
        self.zipCodeTextField.enabled = NO;
        self.metroTextField.enabled = NO;
        self.notesTextField.enabled = NO;
        
        self.address.street = self.streetTextField.text;
        self.address.zipCode = self.zipCodeTextField.text;
        self.address.metro = self.metroTextField.text;
        self.address.notes = self.notesTextField.text;
        
        if (![self.address isEqual:initialAddress]) {
            [NSKeyedArchiver archiveRootObject:self.address toFile:[self getFilePath]];
        }

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    hasChanges = NO;
    
    // Load address
    self.address = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
    if (self.address == nil) {
        self.address = [EAAddress new];
    }
    
    initialAddress = [self.address copy];
    self.streetTextField.text = self.address.street;
    self.zipCodeTextField.text = self.address.zipCode;
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


@end
