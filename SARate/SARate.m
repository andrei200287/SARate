//
//  SARate.m
//
//
// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2014 Andrei Solovjev - andrei@solovjev.com, http://solovjev.com/
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//

#import "SARate.h"
#import "SARateViewController.h"

@interface SARate()

@property (nonatomic, strong) SARateViewController *mySARateViewController;

@end


@interface SARate (Private)

- (NSString *)SARate_localizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString;

@end

#define SALocalizedString(key, comment) [self SARate_localizedStringForKey:key withDefault:key]


@implementation SARate


- (void)promptForRating
{
	
    if (_mySARateViewController != nil && _mySARateViewController.isShowed){
        return;
    }
    _mySARateViewController = [[SARateViewController alloc] init];
    _mySARateViewController.headerLabelText = self.headerLabelText;
    _mySARateViewController.descriptionLabelText = self.descriptionLabelText;
    _mySARateViewController.rateButtonLabelText = self.rateButtonLabelText;
    _mySARateViewController.cancelButtonLabelText = self.cancelButtonLabelText;
    _mySARateViewController.setRaitingAlertTitle = self.setRaitingAlertTitle;
    _mySARateViewController.setRaitingAlertMessage = self.setRaitingAlertMessage;
    _mySARateViewController.appstoreRaitingAlertTitle = self.appstoreRaitingAlertTitle;
    _mySARateViewController.appstoreRaitingAlertMessage = self.appstoreRaitingAlertMessage;
    _mySARateViewController.appstoreRaitingCancel = self.appstoreRaitingCancel;
    _mySARateViewController.appstoreRaitingButton = self.appstoreRaitingButton;
    _mySARateViewController.disadvantagesAlertTitle = self.disadvantagesAlertTitle;
    _mySARateViewController.disadvantagesAlertMessage = self.disadvantagesAlertMessage;
    _mySARateViewController.email = self.email;
    _mySARateViewController.emailSubject = self.emailSubject;
    _mySARateViewController.emailText = self.emailText;
    _mySARateViewController.emailErrorAlertText = self.emailErrorAlertText;
    _mySARateViewController.okText = self.okText;
    _mySARateViewController.minAppStoreRaiting = self.minAppStoreRaiting;
	_mySARateViewController.notSelectedStarImage = self.notSelectedStarImage;
	_mySARateViewController.selectedStarImage = self.selectedStarImage;
	
    [_mySARateViewController.view setFrame:[[UIScreen mainScreen] bounds]];
    
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_mySARateViewController.view];
    
    //inform about prompt
    if ([self.delegate respondsToSelector:@selector(iRateDidPromptForRating)]) {
        [self.delegate iRateDidPromptForRating];
    }
    
}


+ (SARate *)sharedInstance
{
    static SARate *sharedInstance = nil;
    if (sharedInstance == nil)
    {
        sharedInstance = [[SARate alloc] init];
    }
    return sharedInstance;
}


-(NSString *)headerLabelText{
    if (_headerLabelText == nil){
        _headerLabelText = [NSString stringWithFormat:SALocalizedString(@"Like %@?", @""), self.applicationName];
    }
    return _headerLabelText;
}


-(NSString *)descriptionLabelText{
    if (_descriptionLabelText == nil){
        _descriptionLabelText = SALocalizedString(@"Touch the star to rate.", @"");
    }
    return _descriptionLabelText;
}


-(NSString *)rateButtonLabelText{
    if (_rateButtonLabelText == nil){
        _rateButtonLabelText = SALocalizedString(@"Rate", @"");
    }
    return _rateButtonLabelText;
}


-(NSString *)cancelButtonLabelText{
    if (_cancelButtonLabelText == nil){
        _cancelButtonLabelText = SALocalizedString(@"Not Now", @"");
    }
    return _cancelButtonLabelText;
}


-(NSString *)setRaitingAlertTitle{
    if (_setRaitingAlertTitle == nil){
        _setRaitingAlertTitle = SALocalizedString(@"Rate", @"");
    }
    return _setRaitingAlertTitle;
}


-(NSString *)setRaitingAlertMessage{
    if (_setRaitingAlertMessage == nil){
        _setRaitingAlertMessage = SALocalizedString(@"Touch the star to rate.", @"");
    }
    return _setRaitingAlertMessage;
}


-(NSString *)appstoreRaitingAlertTitle{
    if (_appstoreRaitingAlertTitle == nil){
        _appstoreRaitingAlertTitle = SALocalizedString(@"Write a review on the AppStore", @"");
    }
    return _appstoreRaitingAlertTitle;
}


-(NSString *)appstoreRaitingAlertMessage{
    if (_appstoreRaitingAlertMessage == nil){
        _appstoreRaitingAlertMessage = SALocalizedString(@"Would you mind taking a moment to rate it on the AppStore? It won’t take more than a minute. Thanks for your support!", @"");
    }
    return _appstoreRaitingAlertMessage;
}


-(NSString *)appstoreRaitingCancel{
    if (_appstoreRaitingCancel == nil){
        _appstoreRaitingCancel = SALocalizedString(@"Cancel", @"");
    }
    return _appstoreRaitingCancel;
}


-(NSString *)appstoreRaitingButton{
    if (_appstoreRaitingButton == nil){
        _appstoreRaitingButton = SALocalizedString(@"Rate It Now", @"");
    }
    return _appstoreRaitingButton;
}


-(NSString *)disadvantagesAlertTitle{
    if (_disadvantagesAlertTitle == nil){
        _disadvantagesAlertTitle = SALocalizedString(@"Disadvantages", @"");
    }
    return _disadvantagesAlertTitle;
}


-(NSString *)disadvantagesAlertMessage{
    if (_disadvantagesAlertMessage == nil){
        _disadvantagesAlertMessage = SALocalizedString(@"Please specify the deficiencies in the application. We will try to fix it!", @"");
    }
    return _disadvantagesAlertMessage;
}


-(NSString *)email{
    if (_email == nil){
        _email = @"";
    }
    return _email;
}


-(NSString *)emailSubject{
    if (_emailSubject == nil){
        _emailSubject = self.applicationName;
    }
    return _emailSubject;
}


-(NSString *)emailText{
    if (_emailText == nil){
        _emailText = @"";
    }
    return _emailText;
}


-(NSString *)emailErrorAlertTitle{
    if (_emailErrorAlertTitle == nil){
        _emailErrorAlertTitle = SALocalizedString(@"Error", @"");
    }
    return _emailErrorAlertTitle;
}


-(NSString *)emailErrorAlertText{
    if (_emailErrorAlertText == nil){
        _emailErrorAlertText = SALocalizedString(@"Sending error", @"");
    }
    return _emailErrorAlertText;
}



-(NSString *)okText{
    if (_okText == nil){
        _okText = SALocalizedString(@"OK", @"");
    }
    return _okText;
}


-(int)minAppStoreRaiting{
    if (_minAppStoreRaiting == 0){
        _minAppStoreRaiting = 5;
    }
    return _minAppStoreRaiting;
}


- (UIImage *)notSelectedStarImage
{
	if (!_notSelectedStarImage)
	{
		_notSelectedStarImage = [UIImage imageNamed:@"SARate_star-gray"];
	}
	return _notSelectedStarImage;
}

- (UIImage *)selectedStarImage
{
	if (!_selectedStarImage)
	{
		_selectedStarImage = [UIImage imageNamed:@"SARate_star"];
	}
	return _selectedStarImage;
}


@end


@implementation SARate (Private)

- (NSString *)SARate_localizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString
{
	static NSBundle *bundle = nil;
	if (bundle == nil)
	{
		NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"SARate" ofType:@"bundle"];
		if (self.useAllAvailableLanguages)
		{
			bundle = [NSBundle bundleWithPath:bundlePath];
			NSString *language = [[NSLocale preferredLanguages] count]? [NSLocale preferredLanguages][0]: @"en";
			if (![[bundle localizations] containsObject:language])
			{
				language = [language componentsSeparatedByString:@"-"][0];
			}
			if ([[bundle localizations] containsObject:language])
			{
				bundlePath = [bundle pathForResource:language ofType:@"lproj"];
			}
		}
		bundle = [NSBundle bundleWithPath:bundlePath] ?: [NSBundle mainBundle];
	}
	defaultString = [bundle localizedStringForKey:key value:defaultString table:nil];
	return [[NSBundle mainBundle] localizedStringForKey:key value:defaultString table:nil];
}

@end
