//
//  SVParcelCalculatorController.m
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised Feb 23, 2010.
//  Released under a FreeBSD license variant.
//  http://www.byteproject.net
//

#import "SVParcelCalculatorController.h"

#define MAX_ALLOWED_GIRTH 300
#define MAX_ALLOWED_LENGTH 175

@implementation SVParcelCalculatorController

@synthesize height=_height, width=_width, length=_length, trackingMode=_trackingMode, trackingNumberString=_trackingNumberString;

#pragma mark Initialization

- (id)init {
	self = [super init];
	if (self) {
		[self willChangeValueForKey:@"trackingMode"];
		_trackingMode = SVTrackingModeDHL;
		[self didChangeValueForKey:@"trackingMode"];
	}
	return self;
}

#pragma mark Key-Value Coding

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
	if ([key isEqualToString:@"girth"]) {
		[keyPaths addObject:@"height"];
		[keyPaths addObject:@"width"];
		[keyPaths addObject:@"length"];
	} else if ([key isEqualToString:@"volumetricWeight"]) {
		[keyPaths addObject:@"height"];
		[keyPaths addObject:@"width"];
		[keyPaths addObject:@"length"];
	} else if ([key isEqualToString:@"longGirthString"]) {
		[keyPaths addObject:@"girth"];
	} else if ([key isEqualToString:@"longVolumetricWeightString"]) {
		[keyPaths addObject:@"volumetricWeight"];
	} else if ([key isEqualToString:@"heightString"]) {
		[keyPaths addObject:@"height"];
	} else if ([key isEqualToString:@"widthString"]) {
		[keyPaths addObject:@"width"];
	} else if ([key isEqualToString:@"lengthString"]) {
		[keyPaths addObject:@"length"];
	} else if ([key isEqualToString:@"girthString"]) {
		[keyPaths addObject:@"girth"];
	} else if ([key isEqualToString:@"shipmentInfoMessage"]) {
		[keyPaths addObject:@"girth"];
		[keyPaths addObject:@"length"];
	} else if ([key isEqualToString:@"girthInfoMessage"]) {
		[keyPaths addObject:@"girth"];
	} else if ([key isEqualToString:@"lengthInfoMessage"]) {
		[keyPaths addObject:@"length"];
	} else if ([key isEqualToString:@"userActionInfoMessage"]) {
		[keyPaths addObject:@"girth"];
		[keyPaths addObject:@"length"];
	} else if ([key isEqualToString:@"enableTrackingButton"]) {
		[keyPaths addObject:@"trackingNumberString"];
	} 
	return keyPaths;
}

- (void)setNilValueForKey:(NSString *)key
{
	if ([key isEqualToString:@"height"]) {
		[self setValue:[NSNumber numberWithInt:0] forKey:@"height"];
	}
	else if ([key isEqualToString:@"width"]) {
		[self setValue:[NSNumber numberWithInt:0] forKey:@"width"];
	}
	else if ([key isEqualToString:@"length"]) {
		[self setValue:[NSNumber numberWithInt:0] forKey:@"length"];
	}
	else {
		[super setNilValueForKey:key];
	}
}

#pragma mark Calculation

- (CGFloat)girth {
	return ((double)_height * 2) + ((double)_width * 2) + (double)_length;
}

- (CGFloat)volumetricWeight {
	return (double)_height * (double)_width * (double)_length / 6000;
}

#pragma mark Strings

- (NSString *)longGirthString {
	return [NSString stringWithFormat:NSLocalizedString(@"Girth: %.0lf cm",nil), [self girth]];
}

- (NSString *)longVolumetricWeightString {
	return [NSString stringWithFormat:NSLocalizedString(@"Volumetric weight: %.2lf kg",nil), [self volumetricWeight]];
}

- (NSString *)heightString {
	return [NSString stringWithFormat:NSLocalizedString(@"%d cm",nil), _height];
}

- (NSString *)widthString {
	return [NSString stringWithFormat:NSLocalizedString(@"%d cm",nil), _width];
}

- (NSString *)lengthString {
	return [NSString stringWithFormat:NSLocalizedString(@"%d cm",nil), _length];
}

- (NSString *)girthString  {
	return [NSString stringWithFormat:NSLocalizedString(@"%.0lf cm",nil), [self girth]];
}

- (NSString *)volumetricWeightString {
	return [NSString stringWithFormat:NSLocalizedString(@"volumetric weight: %.2lf kg",nil), [self volumetricWeight]];	
}

- (NSString *)shipmentInfoMessage {
	if ([self girth] > MAX_ALLOWED_GIRTH || _length > MAX_ALLOWED_LENGTH)
		return NSLocalizedString(@"Failed, shipment not possible.",nil);
	return NSLocalizedString(@"Values correspond to DPD guidelines.",nil);
}

- (NSString *)girthInfoMessage {
	if ([self girth] > MAX_ALLOWED_GIRTH)
		return [NSString stringWithFormat:NSLocalizedString(@"Max. girth exceeded with: %.0lf cm.",nil), [self girth] - 300];
	return NSLocalizedString(@"Max. girth is not exceeded.",nil);
}

- (NSString *)lengthInfoMessage {
	if ([self length] > MAX_ALLOWED_LENGTH)
		return [NSString stringWithFormat:NSLocalizedString(@"Max. length exceeded with: %d cm.",nil), _length - 175];
	return NSLocalizedString(@"Max. length is not exceeded.",nil);
}

- (NSString *)userActionInfoMessage {
	if ([self girth] > MAX_ALLOWED_GIRTH || _length > MAX_ALLOWED_LENGTH)
		return NSLocalizedString(@"Contact your local depot or parcel-shop.",nil);
	return NSLocalizedString(@"Shipment of this parcel is possible.",nil);
}

#pragma mark User Experience

- (BOOL)enableTrackingButton {
	return (_trackingNumberString != nil && [_trackingNumberString length] > 0);
}
		 		 
#pragma mark Actions

- (IBAction)trackParcel:(id)sender {
	NSString *trackingURLString = nil;
	NSString *trackLocale = nil;
	switch (_trackingMode) {
		case SVTrackingModeDHL: {
			trackLocale = NSLocalizedString(@"en",nil);
			trackingURLString = [NSString stringWithFormat:
								 @"http://nolp.dhl.de/nextt-online-public/set_identcodes.do?lang=%@&idc=%@", 
								 trackLocale, _trackingNumberString];
			break;
		}
		case SVTrackingModeDPD: {
			trackLocale = NSLocalizedString(@"en",nil);
			trackingURLString = [NSString stringWithFormat:
								 @"http://extranet.dpd.de/cgi-bin/delistrack?pknr=%@&typ=1&lang=%@", 
								 _trackingNumberString, trackLocale];
			break;
		}
		case SVTrackingModeFedEx: {
			trackLocale = NSLocalizedString(@"en",nil);
			trackingURLString = [NSString stringWithFormat:
								 @"http://fedex.com/Tracking?cntry_code=%@&tracknumber_list=%@", 
								 trackLocale, _trackingNumberString];
			break;
		}
		case SVTrackingModeGLS: {
			trackLocale = NSLocalizedString(@"EN",nil);
			trackingURLString = [NSString stringWithFormat:
								 @"http://www.gls-group.eu/276-I-PORTAL-WEB/content/GLS/DE03/"\
								 "%@/5004.htm?txtRefNo=%@&txtAction=71000", 
								 trackLocale, _trackingNumberString];
			break;
		}
		case SVTrackingModeHermes: {
			trackingURLString = [NSString stringWithFormat:
								 @"http://tracking.hlg.de/Tracking.jsp?TrackID=%@", _trackingNumberString];
			break;
		}
		case SVTrackingModeParcelForce: {
			trackingURLString = [NSString stringWithFormat:
								 @"http://www.parcelforce.com/portal/pw/track?trackNumber=%@", _trackingNumberString];
			break;
		}
		case SVTrackingModeRoyalMail: {
			trackingURLString = [NSString stringWithFormat:
								 @"http://www.royalmail.com/portal/rm/track?trackNumber=%@", _trackingNumberString];
			break;
		}
		case SVTrackingModeUPS: {
			trackLocale = NSLocalizedString(@"en_US",nil);
			trackingURLString = [NSString stringWithFormat:
						  @"http://wwwapps.ups.com/WebTracking/processInputRequest?loc=%@&tracknum=%@", 
						  trackLocale, _trackingNumberString];
			break;
		}
		default: {
			break;
		}
	}
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:trackingURLString]];
}

- (IBAction)reset:(id)sender {
	[self setValue:[NSNumber numberWithInt:0] forKey:@"height"];
	[self setValue:[NSNumber numberWithInt:0] forKey:@"width"];
	[self setValue:[NSNumber numberWithInt:0] forKey:@"length"];
}

@end
