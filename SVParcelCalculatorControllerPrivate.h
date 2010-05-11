//
//  SVParcelCalculatorControllerPrivate.h
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised May 9, 2010.
//  Released under the FreeBSD license.
//  http://www.byteproject.net
//

#import <Cocoa/Cocoa.h>
#import "SVParcelCalculatorController.h"

@interface SVParcelCalculatorController (SVParcelCalculatorControllerPrivate)

- (IBAction)orderFrontVerificationSheet:(id)sender;
- (IBAction)orderFrontTrackingSheet:(id)sender;
- (IBAction)orderFrontPreferencesSheet:(id)sender;
- (IBAction)orderOutVerificationSheet:(id)sender;
- (IBAction)orderOutTrackingSheet:(id)sender;
- (IBAction)orderOutPreferencesSheet:(id)sender;
- (IBAction)showParcelLibClearAlert:(id)sender;
- (IBAction)openHomePage:(id)sender;
- (IBAction)openSourceRepository:(id)sender;
- (IBAction)openIssueTracker:(id)sender;
- (IBAction)setModeDHL:(id)sender;
- (IBAction)setModeDPD:(id)sender;
- (IBAction)setModeFedEx:(id)sender;
- (IBAction)setModeGLS:(id)sender;
- (IBAction)setModeHermes:(id)sender;
- (IBAction)setModeParcelForce:(id)sender;
- (IBAction)setModeRoyalMail:(id)sender;
- (IBAction)setModeUPS:(id)sender;

@end
