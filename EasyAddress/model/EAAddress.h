//
//  EAAddress.h
//  EasyAddress
//
//  Created by Brice Durand on 4/5/13.
//  Copyright (c) 2013 Brice Durand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAAddress : NSObject <NSCoding, NSCopying>

@property (copy, nonatomic) NSString *street;
@property (copy, nonatomic) NSString *zipCode;
@property (copy, nonatomic) NSString *metro;
@property (copy, nonatomic) NSString *notes;

@end
