//
//  SVParcelObject.m
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised May 6, 2010.
//  Released under the FreeBSD license.
//  http://www.byteproject.net
//

#import "SVParcelObject.h"

@implementation SVParcelObject

@synthesize poTrackingNumberString, poDescription, poTrackingProvider;

- (id)init
{
    if (self = [super init])
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