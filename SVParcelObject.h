//
//  SVParcelObject.h
//  Parcel Calculator
//
//  Copyright (c) 2010-2011, Stefan Vogt. All rights reserved.
//  http://byteproject.net
//
//  Use of this source code is governed by a MIT-style license.
//  See the file LICENSE for details.
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
