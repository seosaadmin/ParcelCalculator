//
//  SVParcelCalculatorController.h
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised Apr 24, 2010.
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
	IBOutlet NSWindow *mainWindow;
	IBOutlet NSPanel *verificationSheet;
	IBOutlet NSPanel *trackingSheet;
	IBOutlet NSPanel *preferencesSheet;
	IBOutlet NSButton *trackingButton;
	
	BOOL SVHasLaunchedBefore;
	BOOL enableTrackingButton;
	NSInteger height, width, length;
	NSInteger maxAllowedGirth;
	NSInteger maxAllowedLength;
	NSInteger prefMode;
	NSString *trackingNumberString;
	SVTrackingMode trackingMode;
}

/* integer and float values */
@property (readwrite, assign) SVTrackingMode	trackingMode;
@property (readwrite, assign) NSInteger			height;
@property (readwrite, assign) NSInteger			width;
@property (readwrite, assign) NSInteger			length;
@property (readwrite, assign) NSInteger			maxAllowedGirth;
@property (readwrite, assign) NSInteger			maxAllowedLength;
@property (readwrite, assign) NSInteger			prefMode;
@property (readonly) CGFloat					girth;
@property (readonly) CGFloat					volumetricWeight;
@property (readwrite, assign) BOOL				SVHasLaunchedBefore;
@property (readonly) BOOL						enableTrackingButton;

/* strings */
@property (readwrite, assign) NSString			*trackingNumberString;
@property(readonly) NSString					*widthString;
@property(readonly) NSString					*heightString;
@property(readonly) NSString					*lengthString;
@property(readonly) NSString					*girthString;
@property(readonly) NSString					*volumetricWeightString;

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
