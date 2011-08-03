//
//  SVParcelObject.m
//  Parcel Calculator
//
//  Copyright (c) 2010-2011, Stefan Vogt. All rights reserved.
//  http://byteproject.net
//
//  Use of this source code is governed by a MIT-style license.
//  See the file LICENSE for details.
//

#import "SVParcelObject.h"

@implementation SVParcelObject

@synthesize poTrackingNumberString, poDescription, poTrackingProvider;

- (id)init
{
    if (self = [super init]) {}
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
	if (self = [super init])
	{
		self.poTrackingNumberString = [decoder decodeObjectForKey:@"poTrackingNumberString"];
		self.poDescription = [decoder decodeObjectForKey:@"poDescription"];
		self.poTrackingProvider = [decoder decodeIntForKey:@"poTrackingProvider"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder 
{
	[encoder encodeObject:poTrackingNumberString forKey:@"poTrackingNumberString"];
	[encoder encodeObject:poDescription forKey:@"poDescription"];
    [encoder encodeInt:poTrackingProvider forKey:@"poTrackingProvider"];
}

@end