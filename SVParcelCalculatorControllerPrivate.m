//
//  SVParcelCalculatorControllerPrivate.m
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

@implementation SVParcelCalculatorController (SVParcelCalculatorControllerPrivate)

#pragma mark sheets and panels

- (IBAction)orderFrontVerificationSheet:(id)sender 
{
	if (self.height == 0 || self.width == 0 || self.length == 0) 
	{
		NSAlert *verificationAlert = 
		[NSAlert alertWithMessageText:NSLocalizedString(@"Conformity test not possible!",nil)
						defaultButton:@"OK" 
					  alternateButton:nil
						  otherButton:nil 
		    informativeTextWithFormat:NSLocalizedString(@"It seems that not all variables "
														@"(height, width, length) have usable "
														@"values. Please specify the required "
														@"dimensions and try again.",nil)];
		
		[verificationAlert setAlertStyle:NSCriticalAlertStyle];
		[verificationAlert beginSheetModalForWindow:mainWindow
						  modalDelegate:self
						 didEndSelector:NULL
							contextInfo:NULL];
		
		return;
	}
	[NSApp beginSheet:verificationSheet
	   modalForWindow:mainWindow
		modalDelegate:self 
	   didEndSelector:NULL 
		  contextInfo:NULL];
}

- (IBAction)orderFrontTrackingSheet:(id)sender 
{
	self.trackingNumberString = @"";
	[NSApp beginSheet:trackingSheet
	   modalForWindow:mainWindow 
		modalDelegate:self 
	   didEndSelector:NULL 
		  contextInfo:NULL];
}

- (IBAction)orderFrontPreferencesSheet:(id)sender 
{
	[NSApp beginSheet:preferencesSheet
	   modalForWindow:mainWindow 
		modalDelegate:self 
	   didEndSelector:NULL 
		  contextInfo:NULL];
}

- (IBAction)orderOutVerificationSheet:(id)sender 
{
	[NSApp endSheet:verificationSheet]; 
    [verificationSheet orderOut:nil];
}

- (IBAction)orderOutTrackingSheet:(id)sender 
{
	[NSApp endSheet:trackingSheet];
	[trackingSheet orderOut:nil];
}

- (IBAction)orderOutPreferencesSheet:(id)sender 
{
	[NSApp endSheet:preferencesSheet];
	[preferencesSheet orderOut:nil];
}

- (IBAction)showParcelLibClearAlert:(id)sender
{
	NSRunCriticalAlertPanel(NSLocalizedString(@"Careful", nil), 
							NSLocalizedString(@"Pressing this button erases all data in your "
											  @"parcel library. In case this is what you want, "
											  @"please proceed.", nil),
											  @"OK", nil, nil);
}

#pragma mark main menu

- (IBAction)openHomePage:(id)sender 
{
	NSString *appHomePage = (@"http://byteproject.net/parcelcalculator");
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:appHomePage]];
}

- (IBAction)openSourceRepository:(id)sender 
{
	NSString *sourceRepository = (@"http://github.com/ByteProject/ParcelCalculator");
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:sourceRepository]];
}

- (IBAction)openIssueTracker:(id)sender 
{
	NSString *issueTracker = (@"http://github.com/ByteProject/ParcelCalculator/issues");
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:issueTracker]];
}

- (IBAction)setModeDHL:(id)sender 
{
	self.trackingMode = SVTrackingModeDHL;
}

- (IBAction)setModeDPD:(id)sender 
{
	self.trackingMode = SVTrackingModeDPD;
}

- (IBAction)setModeFedEx:(id)sender 
{
	self.trackingMode = SVTrackingModeFedEx;
}

- (IBAction)setModeGLS:(id)sender 
{
	self.trackingMode = SVTrackingModeGLS;
}

- (IBAction)setModeHermes:(id)sender
{
	self.trackingMode = SVTrackingModeHermes;
}

- (IBAction)setModeParcelForce:(id)sender 
{
	self.trackingMode = SVTrackingModeParcelForce;
}

- (IBAction)setModeRoyalMail:(id)sender 
{
	self.trackingMode = SVTrackingModeRoyalMail;
}

- (IBAction)setModeUPS:(id)sender
{
	self.trackingMode = SVTrackingModeUPS;
}

@end
