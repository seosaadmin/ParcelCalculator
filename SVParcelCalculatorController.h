//
//  SVParcelCalculatorController.h
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised Apr 25, 2010.
//  Released under a FreeBSD license variant.
//  http://www.byteproject.net
//

#import <Cocoa/Cocoa.h>

/* tracking mode */
typedef enum {
	SVTrackingModeDHL,
	SVTrackingModeDPD,
	SVTrackingModeFedEx,
	SVTrackingModeGLS,
	SVTrackingModeHermes,
	SVTrackingModeParcelForce,
	SVTrackingModeRoyalMail,
	SVTrackingModeUPS
} SVTrackingMode;

@interface SVParcelCalculatorController : NSObject {
	IBOutlet NSWindow	*mainWindow;
	IBOutlet NSPanel	*verificationSheet;
	IBOutlet NSPanel	*trackingSheet;
	IBOutlet NSPanel	*preferencesSheet;
	IBOutlet NSButton	*trackingButton;
	
	SVTrackingMode	trackingMode;
	BOOL			SVHasLaunchedBefore;
	BOOL			enableTrackingButton;
	NSInteger		height, width, length;
	NSInteger		prefMode;
	NSInteger		prefMetrics;
	NSInteger		mFactor;
	CGFloat			maxAllowedGirth;
	CGFloat			maxAllowedLength;
	NSString		*trackingNumberString;
	NSString		*lengthUnitString;
	NSString		*volwtUnitString;
}

/* integer and float values */
@property (readwrite, assign) SVTrackingMode	trackingMode;
@property (readwrite, assign) NSInteger			height;
@property (readwrite, assign) NSInteger			width;
@property (readwrite, assign) NSInteger			length;
@property (readwrite, assign) NSInteger			prefMode;
@property (readwrite, assign) NSInteger			prefMetrics;
@property (readwrite, assign) NSInteger			mFactor;
@property (readwrite, assign) CGFloat			maxAllowedGirth;
@property (readwrite, assign) CGFloat			maxAllowedLength;
@property (readonly) CGFloat					girth;
@property (readonly) CGFloat					volumetricWeight;
@property (readwrite, assign) BOOL				SVHasLaunchedBefore;
@property (readonly) BOOL						enableTrackingButton;

/* strings */
@property (readwrite, assign) NSString			*trackingNumberString;
@property (readwrite, assign) NSString			*lengthUnitString;
@property (readwrite, assign) NSString			*volwtUnitString;
@property(readonly) NSString					*widthString;
@property(readonly) NSString					*heightString;
@property(readonly) NSString					*lengthString;
@property(readonly) NSString					*girthString;

@property(readonly) NSString					*longGirthString;
@property(readonly) NSString					*longVolumetricWeightString;

@property(readonly) NSString					*shipmentInfoMessage;
@property(readonly) NSString					*girthInfoMessage;
@property(readonly) NSString					*lengthInfoMessage;
@property(readonly) NSString					*userActionInfoMessage;



/* actions */
- (IBAction)reset:(id)sender;
- (IBAction)trackParcel:(id)sender;

/* initialization */
- (void)applicationDidFinishLaunching:(NSNotification *)notification;

@end
