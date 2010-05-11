//
//  SVParcelCalculatorController.m
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised May 8, 2010.
//  Released under the FreeBSD license.
//  http://www.byteproject.net
//

#import "SVParcelCalculatorController.h"
#import "SVParcelObject.h"

#define defaultTrackingMode SVTrackingModeDHL
#define defaultMeasurement 0

@implementation SVParcelCalculatorController

@synthesize SVHasLaunchedBefore, height, width, length, trackingMode, trackingNumberString, 
			maxAllowedGirth, maxAllowedLength, lengthUnitString, volwtUnitString, mFactor,
			prefMode, prefMetrics, parcelLibraryView, parcelArray;

#pragma mark initialization

- (id)init 
{
	if (self = [super init])
	{
		[self addObserver: self
			   forKeyPath: @"prefMode"
				  options: NSKeyValueObservingOptionNew
				  context: NULL];
		
		[self addObserver: self
			   forKeyPath: @"prefMetrics"
				  options: NSKeyValueObservingOptionNew
				  context: NULL];
		
		self.parcelArray = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification 
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults boolForKey:@"SVHasLaunchedBefore"] == 0) 
	{
		[defaults setBool:1 forKey:@"SVHasLaunchedBefore"];
		[defaults setInteger:defaultMeasurement forKey:@"prefMetrics"];
		[defaults setInteger:defaultTrackingMode forKey:@"prefMode"];
		[defaults synchronize];
	}
	self.prefMetrics = [defaults integerForKey:@"prefMetrics"];
	self.prefMode = [defaults integerForKey:@"prefMode"];
	self.trackingMode = self.prefMode;
	
	[self loadParcelLibraryFromDisk];
}

#pragma mark key-value coding

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key 
{
	NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
	if ([key isEqualToString:@"girth"]) {
		[keyPaths addObject:@"height"];
		[keyPaths addObject:@"width"];
		[keyPaths addObject:@"length"];
	} 
	else if ([key isEqualToString:@"volumetricWeight"]) {
		[keyPaths addObject:@"height"];
		[keyPaths addObject:@"width"];
		[keyPaths addObject:@"length"];
		[keyPaths addObject:@"mFactor"];
	} 
	else if ([key isEqualToString:@"longGirthString"]) {
		[keyPaths addObject:@"girth"];
		[keyPaths addObject:@"lengthUnitString"];
	} 
	else if ([key isEqualToString:@"longVolumetricWeightString"]) {
		[keyPaths addObject:@"volumetricWeight"];
		[keyPaths addObject:@"volwtUnitString"];
	} 
	else if ([key isEqualToString:@"heightString"]) {
		[keyPaths addObject:@"height"];
		[keyPaths addObject:@"lengthUnitString"];
	} 
	else if ([key isEqualToString:@"widthString"]) {
		[keyPaths addObject:@"width"];
		[keyPaths addObject:@"lengthUnitString"];
	} 
	else if ([key isEqualToString:@"lengthString"]) {
		[keyPaths addObject:@"length"];
		[keyPaths addObject:@"lengthUnitString"];
	} 
	else if ([key isEqualToString:@"girthString"]) {
		[keyPaths addObject:@"girth"];
		[keyPaths addObject:@"lengthUnitString"];
	} 
	else if ([key isEqualToString:@"shipmentInfoMessage"]) {
		[keyPaths addObject:@"girth"];
		[keyPaths addObject:@"length"];
		[keyPaths addObject:@"maxAllowedGirth"];
		[keyPaths addObject:@"maxAllowedLength"];
	} 
	else if ([key isEqualToString:@"girthInfoMessage"]) {
		[keyPaths addObject:@"girth"];
		[keyPaths addObject:@"lengthUnitString"];
		[keyPaths addObject:@"maxAllowedGirth"];
	} 
	else if ([key isEqualToString:@"lengthInfoMessage"]) {
		[keyPaths addObject:@"length"];
		[keyPaths addObject:@"lengthUnitString"];
		[keyPaths addObject:@"maxAllowedLength"];
	} 
	else if ([key isEqualToString:@"userActionInfoMessage"]) {
		[keyPaths addObject:@"girth"];
		[keyPaths addObject:@"length"];
		[keyPaths addObject:@"maxAllowedGirth"];
		[keyPaths addObject:@"maxAllowedLength"];
	} 
	else if ([key isEqualToString:@"hideParcelLibMenuItems"]) {
		[keyPaths addObject:@"trackingNumberString"];
	}
	return keyPaths;
}

- (void)setNilValueForKey:(NSString *)key 
{
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
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([key isEqualToString:@"prefMode"])
    {
        [defaults setInteger:self.prefMode forKey:@"prefMode"];
    }
	else if ([key isEqualToString:@"prefMetrics"])
    {
        [defaults setInteger:self.prefMetrics forKey:@"prefMetrics"];
		if (self.prefMetrics == 1) 
		{
			self.mFactor = 166;
			self.maxAllowedGirth = 118.11;
			self.maxAllowedLength = 68.9;
			self.lengthUnitString = @"in";
			self.volwtUnitString = @"lbs";
		}
		else {
			self.mFactor = 6000;
			self.maxAllowedGirth = 300.0;
			self.maxAllowedLength = 175.0;
			self.lengthUnitString = @"cm";
			self.volwtUnitString = @"kg";
		}
	}
	else {
		[super observeValueForKeyPath:key
							 ofObject:(id)object 
							   change:(NSDictionary *)change
							  context:(void *)context];
	}
}

#pragma mark calculation

- (CGFloat)girth 
{
	return ((double)self.height * 2) + ((double)self.width * 2) + (double)self.length;
}

- (CGFloat)volumetricWeight 
{
	return (double)self.height * (double)self.width * (double)self.length / self.mFactor;
}

#pragma mark strings

- (NSString *)longGirthString 
{
	return [NSString stringWithFormat:NSLocalizedString(@"Girth: %.0lf %@",nil), 
			self.girth, self.lengthUnitString];
}

- (NSString *)longVolumetricWeightString 
{
	return [NSString stringWithFormat:NSLocalizedString
			(@"Volumetric weight: %.2lf %@",nil), self.volumetricWeight, self.volwtUnitString];
}

- (NSString *)heightString 
{
	return [NSString stringWithFormat:NSLocalizedString(@"%d %@",nil), 
			self.height, self.lengthUnitString];
}

- (NSString *)widthString 
{
	return [NSString stringWithFormat:NSLocalizedString(@"%d %@",nil), 
			self.width, self.lengthUnitString];
}

- (NSString *)lengthString 
{
	return [NSString stringWithFormat:NSLocalizedString(@"%d %@",nil), 
			self.length, self.lengthUnitString];
}

- (NSString *)girthString  
{
	return [NSString stringWithFormat:NSLocalizedString(@"%.0lf %@",nil), 
			self.girth, self.lengthUnitString];
}

- (NSString *)shipmentInfoMessage 
{
	if (self.girth > self.maxAllowedGirth || self.length > self.maxAllowedLength)
		return NSLocalizedString(@"Failed, shipment not possible.",nil);
	return NSLocalizedString(@"Values correspond to DPD guidelines.",nil);
}

- (NSString *)girthInfoMessage 
{
	if (self.girth > self.maxAllowedGirth)
		return [NSString stringWithFormat:NSLocalizedString
				(@"Max. girth exceeded with: %.0lf %@.",nil), 
				self.girth - self.maxAllowedGirth, self.lengthUnitString];
	return NSLocalizedString(@"Max. girth is not exceeded.",nil);
}

- (NSString *)lengthInfoMessage 
{
	if (self.length > self.maxAllowedLength)
		return [NSString stringWithFormat:NSLocalizedString
				(@"Max. length exceeded with: %.0lf %@.",nil), 
				self.length - self.maxAllowedLength, self.lengthUnitString];
	return NSLocalizedString(@"Max. length is not exceeded.",nil);
}

- (NSString *)userActionInfoMessage 
{
	if (self.girth > self.maxAllowedGirth || self.length > self.maxAllowedLength)
		return NSLocalizedString(@"Contact your local depot or parcel-shop.",nil);
	return NSLocalizedString(@"Shipment of this parcel is possible.",nil);
}

#pragma mark user experience

- (BOOL)hideParcelLibMenuItems
{
	return (self.trackingNumberString == nil || self.trackingNumberString.length == 0);
}
		 		 
#pragma mark actions

- (IBAction)trackParcel:(id)sender 
{
	if (self.trackingNumberString == nil || self.trackingNumberString.length == 0) {
		return;
	}
	NSString *trackingURLString = nil;
	NSString *trackLocale = nil;
	
	switch (self.trackingMode) 
	{
		case SVTrackingModeDHL: {
			trackLocale = NSLocalizedString(@"en",nil);
			trackingURLString = 
			[NSString stringWithFormat:
			@"http://nolp.dhl.de/nextt-online-public/set_identcodes.do?lang=%@&idc=%@", 
			trackLocale, self.trackingNumberString];
			break;
		}
		case SVTrackingModeDPD: {
			trackLocale = NSLocalizedString(@"en",nil);
			trackingURLString = 
			[NSString stringWithFormat:
			@"http://extranet.dpd.de/cgi-bin/delistrack?pknr=%@&typ=1&lang=%@", 
			self.trackingNumberString, trackLocale];
			break;
		}
		case SVTrackingModeFedEx: {
			trackLocale = NSLocalizedString(@"en",nil);
			trackingURLString = 
			[NSString stringWithFormat:				 
			 @"http://fedex.com/Tracking?cntry_code=%@&tracknumber_list=%@",
			 trackLocale, self.trackingNumberString];
			break;
		}
		case SVTrackingModeGLS: {
			trackLocale = NSLocalizedString(@"EN",nil);
			trackingURLString = 
			[NSString stringWithFormat:
			 @"http://www.gls-group.eu/276-I-PORTAL-WEB/content/GLS/DE03/"
			 @"%@/5004.htm?txtRefNo=%@&txtAction=71000",
			 trackLocale, self.trackingNumberString];
			break;
		}
		case SVTrackingModeHermes: {
			trackingURLString = 
			[NSString stringWithFormat:
			 @"http://tracking.hlg.de/Tracking.jsp?TrackID=%@",
			 self.trackingNumberString];
			break;
		}
		case SVTrackingModeParcelForce: {
			trackingURLString = 
			[NSString stringWithFormat:
			 @"http://www.parcelforce.com/portal/pw/track?trackNumber=%@",
			 self.trackingNumberString];
			break;
		}
		case SVTrackingModeRoyalMail: {
			trackingURLString = 
			[NSString stringWithFormat:
			 @"http://www.royalmail.com/portal/rm/track?trackNumber=%@",
			 self.trackingNumberString];
			break;
		}
		case SVTrackingModeUPS: {
			trackLocale = NSLocalizedString(@"en_US",nil);
			trackingURLString = 
			[NSString stringWithFormat:
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

- (IBAction)reset:(id)sender 
{
	self.height = 0;
	self.width = 0;
	self.length = 0;
}

- (IBAction)addParcelObject:(id)sender
{
	SVParcelObject *aParcelObject = [[SVParcelObject alloc] init];
	aParcelObject.poTrackingNumberString = self.trackingNumberString;
	aParcelObject.poTrackingProvider = self.trackingMode;
	aParcelObject.poDescription = @"";
	
	[[self mutableArrayValueForKey:@"parcelArray"] addObject:aParcelObject];
}

# pragma mark data

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
	NSInteger row = [self.parcelLibraryView selectedRow]; 
	if (row == -1) {
		return;
	} 
	SVParcelObject *selectedParcel = [self.parcelArray objectAtIndex:row];
	self.trackingNumberString = selectedParcel.poTrackingNumberString;
	self.trackingMode = selectedParcel.poTrackingProvider;
}

- (NSString *)pathForParcelLibraryFile
{
	NSFileManager *fileManager = [[NSFileManager alloc] init];
    
	NSString *folder = @"~/Library/Application Support/Parcel Calculator/";
	folder = [folder stringByExpandingTildeInPath];
	
	if ([fileManager fileExistsAtPath:folder] == NO)
	{
		[fileManager createDirectoryAtPath:folder 
			   withIntermediateDirectories:YES 
								attributes:nil 
									 error:nil];
	}
	NSString *fileName = @"ParcelCalculator.parcellib";
	return [folder stringByAppendingPathComponent:fileName];    
}

- (void)saveParcelLibraryToDisk
{
	NSString *path = self.pathForParcelLibraryFile;
	
	NSMutableDictionary *rootObject;
	rootObject = [NSMutableDictionary dictionary];
	[rootObject setValue:self.parcelArray forKey:@"parcelArray"];
	
	[NSKeyedArchiver archiveRootObject:rootObject toFile:path];
}

- (void)loadParcelLibraryFromDisk
{
	NSString *path = self.pathForParcelLibraryFile;
	
	NSDictionary *rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];    
	if ([rootObject valueForKey:@"parcelArray"] != nil) 
	{
		self.parcelArray = [rootObject valueForKey:@"parcelArray"];	
	}
}

- (IBAction)clearParcelLibrary:(id)sender
{
	for (id aParcelObject in self.parcelArray) {
		[[self mutableArrayValueForKey:@"parcelArray"] removeObject:aParcelObject];
	}
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	[self saveParcelLibraryToDisk];
}

@end
