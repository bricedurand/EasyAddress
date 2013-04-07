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

@implementation EAAddressDetailViewController {
    NSString *initialText;
    BOOL hasChanges;
}

- (void)cancel:(id)sender
{
    [self.view endEditing:YES];
}

- (void)save:(id)sender
{
    [self.view endEditing:YES];
    if (hasChanges) {
        [self.delegate addressDetailViewController:self
                                  didUpdateAddress:self.address];
    }
}
- (void)textFieldDone:(id)sender
{
    [sender resignFirstResponder];
}

- (void) awakeFromNib {
    
    // Custom initialization
    self.fieldLabels = @[@"Street", @"ZipCode", @"Metro", @"Notes"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                             target:self
                                             action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                              target:self
                                              action:@selector(save:)];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfEditableRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
//        UILabel *label = [[UILabel alloc] initWithFrame:
//                          CGRectMake(10, 10, 75, 25)];
//        label.tag = kLabelTag;
//        label.textAlignment = NSTextAlignmentRight;
//        label.font = [UIFont boldSystemFontOfSize:14];
//        [cell.contentView addSubview:label];
//        UITextField *textField = [[UITextField alloc] initWithFrame:
//                                  CGRectMake(90, 12, 200, 25)];
//        textField.tag = kTextFieldTag;
//        textField.clearsOnBeginEditing = NO;
//        textField.delegate = self;
//        textField.returnKeyType = UIReturnKeyDone;
//        [textField addTarget:self
//                      action:@selector(textFieldDone:)
//            forControlEvents:UIControlEventEditingDidEndOnExit];
//        [cell.contentView addSubview:textField];
    }
    
    UILabel *label = (id)[cell viewWithTag:kLabelTag];
    label.text = self.fieldLabels[indexPath.row];
    
    UITextField *textField = (id)[cell viewWithTag:kTextFieldTag];
    textField.superview.tag = indexPath.row;
    switch (indexPath.row) {
        case kStreetRowIndex:
            textField.text = self.address.street;
            break;
        case kZipCodeRowIndex:
            textField.text = self.address.zipCode;
            break;
        case kMetroRowIndex:
            textField.text = self.address.metro;
            break;
        case kNotesRowIndex:
            textField.text = self.address.notes;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    initialText = textField.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![textField.text isEqualToString:initialText]) {
        hasChanges = YES;
        switch (textField.superview.tag) {
            case kStreetRowIndex:
                self.address.street = textField.text;
                break;
            case kZipCodeRowIndex:
                self.address.zipCode = textField.text;
                break;
            case kMetroRowIndex:
                self.address.metro = textField.text;
                break;
            case kNotesRowIndex:
                self.address.notes = textField.text;
                break;
            default:
                break;
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
