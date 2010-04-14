//
//  SVParcelCalculatorController.h
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised Mar 26, 2010.
//  Released under a FreeBSD license variant.
//  http://www.byteproject.net
//

#import <Cocoa/Cocoa.h>

/* Tracking Mode */
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
	
	BOOL enableTrackingButton;
	NSInteger height, width, length;
	SVTrackingMode trackingMode;
	NSString *trackingNumberString;
	NSMutableArray *trackingList;
}

@property (readwrite, assign) SVTrackingMode	trackingMode;
@property (readwrite, assign) NSString			*trackingNumberString;
@property (readwrite, assign) NSInteger			height;
@property (readwrite, assign) NSInteger			width;
@property (readwrite, assign) NSInteger			length;
@property (readonly) CGFloat					girth;
@property (readonly) CGFloat					volumetricWeight;
@property (readonly) BOOL						enableTrackingButton;

/* Strings */
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

/* Actions */
- (IBAction)reset:(id)sender;
- (IBAction)trackParcel:(id)sender;

/* Initialization */
- (void)applicationDidFinishLaunching:(NSNotification *)notification;

@end
