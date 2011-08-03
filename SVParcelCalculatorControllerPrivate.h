//
//  SVParcelCalculatorControllerPrivate.h
//  Parcel Calculator
//
//  Copyright (c) 2010-2011, Stefan Vogt. All rights reserved.
//  http://byteproject.net
//
//  Use of this source code is governed by a MIT-style license.
//  See the file LICENSE for details.
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
