//
//  SVParcelCalculatorControllerPrivate.m
//  Parcel Calculator
//
//  Coded by Stefan Vogt, revised Feb 23, 2010.
//  Released under a FreeBSD license variant.
//  http://www.byteproject.net
//

#import <Cocoa/Cocoa.h>
#import "SVParcelCalculatorController.h"

@implementation SVParcelCalculatorController (SVParcelCalculatorControllerPrivate)

#pragma mark Sheets

- (IBAction)orderFrontVerificationSheet:(id)sender {
	if (_height == 0 || _width == 0 || _length == 0) {
		NSAlert *verificationAlert = 
		[NSAlert alertWithMessageText:NSLocalizedString(@"Conformity test not possible!",nil)
						defaultButton:@"OK" 
					  alternateButton:nil
						  otherButton:nil 
		    informativeTextWithFormat:NSLocalizedString(@"It seems that not all variables "\
														"(height, width, length) have usable "\
														"values. Please specify the required "\
														"dimensions and try again.",nil)];
		
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

- (IBAction)orderFrontTrackingSheet:(id)sender {
	[self setValue:@"" forKey:@"trackingNumberString"];
	[NSApp beginSheet:trackingSheet
	   modalForWindow:mainWindow 
		modalDelegate:self 
	   didEndSelector:NULL 
		  contextInfo:NULL];
}

- (IBAction)orderFrontPreferencesSheet:(id)sender {
	[NSApp beginSheet:preferencesSheet
	   modalForWindow:mainWindow 
		modalDelegate:self 
	   didEndSelector:NULL 
		  contextInfo:NULL];
}

- (IBAction)orderOutVerificationSheet:(id)sender {
	[NSApp endSheet:verificationSheet]; 
    [verificationSheet orderOut:nil];
}

- (IBAction)orderOutTrackingSheet:(id)sender {
	[NSApp endSheet:trackingSheet];
	[trackingSheet orderOut:nil];
	[trackingButton setEnabled:NO];
}

- (IBAction)orderOutPreferencesSheet:(id)sender {
	[NSApp endSheet:preferencesSheet];
	[preferencesSheet orderOut:nil];
}

#pragma mark Main Menu

- (IBAction)openHomePage:(id)sender {
	NSString *appHomePage = (@"http://www.byteproject.net/?page_id=11");
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:appHomePage]];
}

- (IBAction)openSourceRepository:(id)sender {
	NSString *sourceRepository = (@"http://github.com/ByteProject/ParcelCalculator");
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:sourceRepository]];
}

- (IBAction)openIssueTracker:(id)sender {
	NSString *issueTracker = (@"http://github.com/ByteProject/ParcelCalculator/issues");
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:issueTracker]];
}


- (IBAction)setModeDHL:(id)sender {
	
	[self willChangeValueForKey:@"trackingMode"];
	_trackingMode = SVTrackingModeDHL;
	[self didChangeValueForKey:@"trackingMode"];
}

- (IBAction)setModeDPD:(id)sender {
	[self willChangeValueForKey:@"trackingMode"];
	_trackingMode = SVTrackingModeDPD;
	[self didChangeValueForKey:@"trackingMode"];
}

- (IBAction)setModeFedEx:(id)sender {
	[self willChangeValueForKey:@"trackingMode"];
	_trackingMode = SVTrackingModeFedEx;
	[self didChangeValueForKey:@"trackingMode"];
}

- (IBAction)setModeGLS:(id)sender {
	
	[self willChangeValueForKey:@"trackingMode"];
	_trackingMode = SVTrackingModeGLS;
	[self didChangeValueForKey:@"trackingMode"];
}

- (IBAction)setModeHermes:(id)sender {
	
	[self willChangeValueForKey:@"trackingMode"];
	_trackingMode = SVTrackingModeHermes;
	[self didChangeValueForKey:@"trackingMode"];
}

- (IBAction)setModeParcelForce:(id)sender {
	
	[self willChangeValueForKey:@"trackingMode"];
	_trackingMode = SVTrackingModeParcelForce;
	[self didChangeValueForKey:@"trackingMode"];
}

- (IBAction)setModeRoyalMail:(id)sender {
	
	[self willChangeValueForKey:@"trackingMode"];
	_trackingMode = SVTrackingModeRoyalMail;
	[self didChangeValueForKey:@"trackingMode"];
}

- (IBAction)setModeUPS:(id)sender {

	[self willChangeValueForKey:@"trackingMode"];
	_trackingMode = SVTrackingModeUPS;
	[self didChangeValueForKey:@"trackingMode"];
}

@end
