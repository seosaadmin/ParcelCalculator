//
//  SVParcelObject.h
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised May 6, 2010.
//  Released under the FreeBSD license.
//  http://www.byteproject.net
//

#import <Foundation/Foundation.h>

@interface SVParcelObject : NSObject <NSCoding> {
	NSString	*poTrackingNumberString;
	NSString	*poDescription;
	NSInteger	poTrackingProvider;
}

@property (readwrite, assign) NSString	*poTrackingNumberString;
@property (readwrite, assign) NSString	*poDescription;
@property (readwrite, assign) NSInteger	poTrackingProvider;	

@end
