//
//  EAAddress.m
//  EasyAddress
//
//  Created by Brice Durand on 4/7/13.
//  Copyright (c) 2013 Brice Durand. All rights reserved.
//

#import "EAAddress.h"

static NSString * const kAddressStreet = @"Street";
static NSString * const kAddressCity = @"City";
static NSString * const kAddressMetro = @"Metro";
static NSString * const kAddressNotes = @"Notes";


@implementation EAAddress

- (NSString *)description
{
     return [NSString stringWithFormat:@"%@, %@. %@. %@", self.street,self.city,self.metro,self.notes];
}

- (BOOL) isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }
    EAAddress *otherAddress = (EAAddress *) other;
    
    return [self.street isEqual:otherAddress.street] && [self.city isEqual:otherAddress.city] && [self.metro isEqual:otherAddress.metro] && [self.notes isEqual:otherAddress.notes];
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.street forKey:kAddressStreet];
    [encoder encodeObject:self.city forKey:kAddressCity];
    [encoder encodeObject:self.metro forKey:kAddressMetro];
    [encoder encodeObject:self.notes forKey:kAddressNotes];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.street = [decoder decodeObjectForKey:kAddressStreet];
        self.city = [decoder decodeObjectForKey:kAddressCity];
        self.metro = [decoder decodeObjectForKey:kAddressMetro];
        self.notes = [decoder decodeObjectForKey:kAddressNotes];
    }
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone;
{
    EAAddress *copy = [[EAAddress alloc] init];
    copy.street = self.street;
    copy.city = self.city;
    copy.metro = self.metro;
    copy.notes = self.notes;
    return copy;
}
@end