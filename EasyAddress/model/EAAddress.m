//
//  EAAddress.m
//  EasyAddress
//
//  Created by Brice Durand on 4/5/13.
//  Copyright (c) 2013 Brice Durand. All rights reserved.
//

#import "EAAddress.h"

static NSString * const kAddressStreet = @"Street";
static NSString * const kAddressZipCode = @"ZipCode";
static NSString * const kAddressMetro = @"Metro";
static NSString * const kAddressNotes = @"Notes";

@implementation EAAddress

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [coder encodeObject:self.street forKey:kAddressStreet];
    [coder encodeObject:self.zipCode forKey:kAddressZipCode];
    [coder encodeObject:self.metro forKey:kAddressMetro];
    [coder encodeObject:self.notes forKey:kAddressNotes];
}

￼- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.street = [coder decodeObjectForKey:kAddressStreet];
        self.zipCode = [coder decodeObjectForKey:kAddressZipCode];
        self.metro = [coder decodeObjectForKey:kAddressMetro];
        self.notes = [coder decodeObjectForKey:kAddressNotes];
    }
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone;
{
    EAAddress *copy = [[EAAddress alloc] init];
    copy.street = self.street;
    copy.zipCode = self.zipCode;
    copy.metro = self.metro;
    copy.notes = self.notes;
    return copy;
}
@end
