//
//  SVParcelCalculatorController.m
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised Apr 24, 2010.
//  Released under a FreeBSD license variant.
//  http://www.byteproject.net
//

#import "SVParcelCalculatorController.h"

#define defaultTrackingMode SVTrackingModeDHL

@implementation SVParcelCalculatorController

@synthesize SVHasLaunchedBefore, height, width, length, trackingMode, trackingNumberString, 
			prefMode, maxAllowedGirth, maxAllowedLength;

#pragma mark Initialization

- (id)init {
	self = [super init];
	if (self) {
		[self addObserver: self
			   forKeyPath: @"prefMode"
				  options: NSKeyValueObservingOptionNew
				  context: NULL];
		
		self.maxAllowedGirth = 300;
		self.maxAllowedLength = 175;
	}
	return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults boolForKey:@"SVHasLaunchedBefore"] == 0) {
		[defaults setBool:1 forKey:@"SVHasLaunchedBefore"];
		[defaults setInteger:defaultTrackingMode forKey:@"prefMode"];
	}
	self.prefMode = [defaults integerForKey:@"prefMode"];
	self.trackingMode = self.prefMode;
	
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

- (void)setNilValueForKey:(NSString *)key {
	if ([key isEqualToString:@"height"]) {
		self.height = 0;
	}
	else if ([key isEqualToString:@"width"]) {
		self.width = 0;
	}
	else if ([key isEqualToString:@"length"]) {
		self.length = 0;
	}
	else {
		[super setNilValueForKey:key];
	}
}

- (void)observeValueForKeyPath:(NSString *)key
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([key isEqualToString:@"prefMode"])
    {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:self.prefMode forKey:@"prefMode"];
    }
	else {
		[super observeValueForKeyPath:key
							 ofObject:(id)object 
							   change:(NSDictionary *)change
							  context:(void *)context];
	}
}

#pragma mark Calculation

- (CGFloat)girth {
	return ((double)self.height * 2) + ((double)self.width * 2) + (double)self.length;
}

- (CGFloat)volumetricWeight {
	return (double)self.height * (double)self.width * (double)self.length / 6000;
}

#pragma mark Strings

- (NSString *)longGirthString {
	return [NSString stringWithFormat:NSLocalizedString(@"Girth: %.0lf cm",nil), self.girth];
}

- (NSString *)longVolumetricWeightString {
	return [NSString stringWithFormat:NSLocalizedString
			(@"Volumetric weight: %.2lf kg",nil), self.volumetricWeight];
}

- (NSString *)heightString {
	return [NSString stringWithFormat:NSLocalizedString(@"%d cm",nil), self.height];
}

- (NSString *)widthString {
	return [NSString stringWithFormat:NSLocalizedString(@"%d cm",nil), self.width];
}

- (NSString *)lengthString {
	return [NSString stringWithFormat:NSLocalizedString(@"%d cm",nil), self.length];
}

- (NSString *)girthString  {
	return [NSString stringWithFormat:NSLocalizedString(@"%.0lf cm",nil), self.girth];
}

- (NSString *)volumetricWeightString {
	return [NSString stringWithFormat:NSLocalizedString
			(@"volumetric weight: %.2lf kg",nil), self.volumetricWeight];	
}

- (NSString *)shipmentInfoMessage {
	if (self.girth > self.maxAllowedGirth || self.length > self.maxAllowedLength)
		return NSLocalizedString(@"Failed, shipment not possible.",nil);
	return NSLocalizedString(@"Values correspond to DPD guidelines.",nil);
}

- (NSString *)girthInfoMessage {
	if (self.girth > self.maxAllowedGirth)
		return [NSString stringWithFormat:NSLocalizedString
				(@"Max. girth exceeded with: %.0lf cm.",nil), self.girth - 300];
	return NSLocalizedString(@"Max. girth is not exceeded.",nil);
}

- (NSString *)lengthInfoMessage {
	if (self.length > self.maxAllowedLength)
		return [NSString stringWithFormat:NSLocalizedString
				(@"Max. length exceeded with: %d cm.",nil), self.length - 175];
	return NSLocalizedString(@"Max. length is not exceeded.",nil);
}

- (NSString *)userActionInfoMessage {
	if (self.girth > self.maxAllowedGirth || self.length > self.maxAllowedLength)
		return NSLocalizedString(@"Contact your local depot or parcel-shop.",nil);
	return NSLocalizedString(@"Shipment of this parcel is possible.",nil);
}

#pragma mark User Experience

- (BOOL)enableTrackingButton {
	return (self.trackingNumberString != nil && self.trackingNumberString.length > 0);
}
		 		 
#pragma mark Actions

- (IBAction)trackParcel:(id)sender {
	NSString *trackingURLString = nil;
	NSString *trackLocale = nil;
	switch (self.trackingMode) {
		case SVTrackingModeDHL: {
			trackLocale = NSLocalizedString(@"en",nil);
			trackingURLString = [NSString stringWithFormat:
								 @"http://nolp.dhl.de/nextt-online-public/set_identcodes.do?lang=%@&idc=%@", 
								 trackLocale, self.trackingNumberString];
			break;
		}
		case SVTrackingModeDPD: {
			trackLocale = NSLocalizedString(@"en",nil);
			trackingURLString = [NSString stringWithFormat:
								 @"http://extranet.dpd.de/cgi-bin/delistrack?pknr=%@&typ=1&lang=%@", 
								 self.trackingNumberString, trackLocale];
			break;
		}
		case SVTrackingModeFedEx: {
			trackLocale = NSLocalizedString(@"en",nil);
			trackingURLString = [NSString stringWithFormat:
								 @"http://fedex.com/Tracking?cntry_code=%@&tracknumber_list=%@", 
								 trackLocale, self.trackingNumberString];
			break;
		}
		case SVTrackingModeGLS: {
			trackLocale = NSLocalizedString(@"EN",nil);
			trackingURLString = [NSString stringWithFormat:
								 @"http://www.gls-group.eu/276-I-PORTAL-WEB/content/GLS/DE03/"\
								 "%@/5004.htm?txtRefNo=%@&txtAction=71000", 
								 trackLocale, self.trackingNumberString];
			break;
		}
		case SVTrackingModeHermes: {
			trackingURLString = [NSString stringWithFormat:
								 @"http://tracking.hlg.de/Tracking.jsp?TrackID=%@", 
								 self.trackingNumberString];
			break;
		}
		case SVTrackingModeParcelForce: {
			trackingURLString = [NSString stringWithFormat:
								 @"http://www.parcelforce.com/portal/pw/track?trackNumber=%@", 
								 self.trackingNumberString];
			break;
		}
		case SVTrackingModeRoyalMail: {
			trackingURLString = [NSString stringWithFormat:
								 @"http://www.royalmail.com/portal/rm/track?trackNumber=%@", 
								 self.trackingNumberString];
			break;
		}
		case SVTrackingModeUPS: {
			trackLocale = NSLocalizedString(@"en_US",nil);
			trackingURLString = [NSString stringWithFormat:
						  @"http://wwwapps.ups.com/WebTracking/processInputRequest?loc=%@&tracknum=%@", 
						  trackLocale, self.trackingNumberString];
			break;
		}
		default: {
			break;
		}
	}
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:trackingURLString]];
}

- (IBAction)reset:(id)sender {
	self.height = 0;
	self.width = 0;
	self.length = 0;
}

@end
