//
//  SVParcelCalculatorControllerPrivate.h
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised Jan 21, 2010.
//  Released under a FreeBSD license variant.
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
- (IBAction)openHomePage:(id)sender;
- (IBAction)openSourceRepository:(id)sender;
- (IBAction)openIssueTracker:(id)sender;
- (IBAction)setModeDPD:(id)sender;
- (IBAction)setModeUPS:(id)sender;
- (IBAction)setModeDHL:(id)sender;

@end
