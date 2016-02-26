//
//  SARateViewController.m
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

#import "SARateViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "iRate.h"

#define NUMBER_OF_STARS (5)

//http://stackoverflow.com/questions/2622017/suppressing-deprecated-warnings-in-xcode
#define SILENCE_DEPRECATION(expr)                                   \
do {                                                                \
_Pragma("clang diagnostic push")                                    \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")   \
expr;                                                               \
_Pragma("clang diagnostic pop")                                     \
} while(0)


@interface SARateViewController ()

@property (nonatomic, strong) NSMutableArray<UIControl*>* starButtons;

/*@property (nonatomic, strong) UIButton *star1;
@property (nonatomic, strong) UIButton *star2;
@property (nonatomic, strong) UIButton *star3;
@property (nonatomic, strong) UIButton *star4;
@property (nonatomic, strong) UIButton *star5;*/

@property (nonatomic, assign) int mark;

- (void)cancelRaiting:(id)sender;
- (void)applyRaiting:(id)sender;
- (void)setRaiting:(id)object;

@end


@interface SARateViewController (Private)

- (UIControl*)_createStartButtonWithTag:(NSInteger)tag frame:(CGRect)frame;
- (UIButton*)_createStarButton;

- (void)_displayOkAlertWithTitle:(NSString*)title message:(NSString*)message completition:(void(^)(void))completition;
- (BOOL)_canUseAlertController;

@end


@implementation SARateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mark = 0;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
	
	
	_starButtons = [[NSMutableArray<UIControl*> alloc] initWithCapacity:NUMBER_OF_STARS];
	
    float width = 260.0;
    float height = 190.0;
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(width/2), (self.view.frame.size.height/2)-(height/2), width, height)];
    alertView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1];
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 10.0;
    [self.view addSubview:alertView];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, width-10, 30)];
    headerLabel.numberOfLines = 1;
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.text = _headerLabelText;
    headerLabel.font = [UIFont boldSystemFontOfSize:16];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:headerLabel];
    
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, width-10, 60)];
    descriptionLabel.numberOfLines = 2;
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.text = _descriptionLabelText;
    descriptionLabel.font = [UIFont systemFontOfSize:14];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:descriptionLabel];
    

    float starWeight = 30.0;
    float starHeight = 30.0;
    float starY = 85.0;
    float separatorWidth = 5.0;
	
	for (NSInteger i = 0; i < NUMBER_OF_STARS; i++)
	{
		CGRect frame = CGRectMake(i * (separatorWidth + starWeight) + 43, starY, starWeight, starHeight);
		UIControl* starButton = [self _createStartButtonWithTag:i frame:frame];
		[alertView addSubview:starButton];
		[self.starButtons addObject:starButton];
	}
	
    UIButton *rateButton;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        rateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    } else {
        rateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    rateButton.frame = CGRectMake(width-(width/2)+1, height-44+1, width/2, 44.0);
    [rateButton setTitle:_rateButtonLabelText forState:UIControlStateNormal];
    rateButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    rateButton.titleLabel.textColor = [UIColor colorWithRed:26.0/255.0 green:134.0/255.0 blue:252.0/255.0 alpha:1];
    [rateButton addTarget:self action:@selector(applyRaiting:) forControlEvents:UIControlEventTouchUpInside];
    rateButton.layer.borderWidth = 1;
    rateButton.layer.borderColor = [[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1] CGColor];
    [alertView addSubview:rateButton];
    
    UIButton *cancelButton;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    } else {
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    cancelButton.frame = CGRectMake(-1, height-44+1, width/2+3, 44.0);
    [cancelButton setTitle:_cancelButtonLabelText forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    cancelButton.titleLabel.textColor = [UIColor colorWithRed:26.0/255.0 green:134.0/255.0 blue:252.0/255.0 alpha:1];
    [cancelButton addTarget:self action:@selector(cancelRaiting:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.layer.borderWidth = 1;
    cancelButton.layer.borderColor = [[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1] CGColor];
    [alertView addSubview:cancelButton];
    
    _isShowed = YES;
    
}


#pragma mark Actions
- (void)setRaiting:(id)object {
	if ([object isKindOfClass:[UIView class]]) {
		UIView *currentButton = (UIView *)object;
		_mark = (int) currentButton.tag;
		[self.starButtons enumerateObjectsUsingBlock:^(UIControl * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			obj.selected = (_mark >= obj.tag);
		}];
	}
}


- (void)cancelRaiting:(id)sender{
	[iRate sharedInstance].lastReminded = [NSDate date];
	_isShowed = NO;
	[self.view removeFromSuperview];
}


- (void)applyRaiting:(id)sender{
	if (_mark == 0)
	{
		[self _displayOkAlertWithTitle:_setRaitingAlertTitle
													 message:_setRaitingAlertMessage
											completition:nil];
	} else if (_mark >= _minAppStoreRaiting)
	{
		if ([self _canUseAlertController])
		{
			UIAlertController* alert = [UIAlertController alertControllerWithTitle:_appstoreRaitingAlertTitle message:_appstoreRaitingAlertMessage preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:_appstoreRaitingCancel
																												 style:UIAlertActionStyleCancel
																											 handler:^(UIAlertAction * _Nonnull action) {
																												 [iRate sharedInstance].ratedThisVersion = YES;
																												 _isShowed = NO;
																												 [self.view removeFromSuperview];
																											 }];
			[alert addAction:cancelAction];
			UIAlertAction* rateAction = [UIAlertAction actionWithTitle:_appstoreRaitingButton
																													 style:UIAlertActionStyleDefault
																												 handler:^(UIAlertAction * _Nonnull action) {
																													 [iRate sharedInstance].ratedThisVersion = YES;
																														[[iRate sharedInstance] openRatingsPageInAppStore];
																													 _isShowed = NO;
																													 [self.view removeFromSuperview];
																												 }];
			[alert addAction:rateAction];
			[self presentViewController:alert animated:YES completion:nil];
		}
		else
		{
_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_appstoreRaitingAlertTitle
																											message:_appstoreRaitingAlertMessage
																										 delegate:self
																						cancelButtonTitle:_appstoreRaitingCancel
																						otherButtonTitles:_appstoreRaitingButton, nil];
			[alert show];
_Pragma("clang diagnostic pop")
		}
	}
	else
	{
		[self _displayOkAlertWithTitle:_disadvantagesAlertTitle message:_disadvantagesAlertMessage completition:^{
			[self sendMail];
		}];
	}
}


#pragma mark UIAlerViewDelegate
_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [iRate sharedInstance].ratedThisVersion = YES;
    if (buttonIndex != alertView.cancelButtonIndex){
        [[iRate sharedInstance] openRatingsPageInAppStore];
    }
    _isShowed = NO;
    [self.view removeFromSuperview];
}
_Pragma("clang diagnostic pop")


#pragma mark - Mail

- (void)sendMail{
    if ([MFMailComposeViewController canSendMail])
    {
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:_email, nil];
        [mailer setToRecipients:toRecipients];
        [mailer setSubject:_emailSubject];
        NSString *emailBody = _emailText;
        [mailer setMessageBody:emailBody isHTML:YES];
        mailer.mailComposeDelegate = self;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        }
			
			if ([self respondsToSelector:@selector(presentViewController:animated:completion:)])
			{
				[self presentViewController:mailer
													 animated:YES
												 completion:nil];
			}
			else
			{
				SILENCE_DEPRECATION([self presentModalViewController:mailer animated:YES];);
			}
    } else {
			
			[self _displayOkAlertWithTitle:_emailErrorAlertTitle message:_emailErrorAlertText completition:nil];
    }
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [controller dismissViewControllerAnimated:YES completion:^{
        [iRate sharedInstance].ratedThisVersion = YES;
        _isShowed = NO;
        [self.view removeFromSuperview];
    }];
    
}

@end


#pragma mark -
@implementation SARateViewController (Private)

- (UIControl*)_createStartButtonWithTag:(NSInteger)tag frame:(CGRect)frame
{
	UIButton* starButton = [self _createStarButton];
	starButton.tag = tag;
	starButton.frame = frame;
	
	return starButton;
}


- (UIButton*)_createStarButton
{
	UIButton* starButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[starButton setImage:[UIImage imageNamed:@"SARate_star-gray.png"] forState:UIControlStateNormal];
	[starButton setImage:[UIImage imageNamed:@"SARate_star.png"] forState:UIControlStateSelected];
	[starButton addTarget:self action:@selector(setRaiting:) forControlEvents:UIControlEventTouchUpInside];
	
	return starButton;
}


- (void)_displayOkAlertWithTitle:(NSString*)title message:(NSString*)message completition:(void(^)(void))completition
{
	if ([self _canUseAlertController])
	{
		UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title
																																						 message:message
																																			preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* okAction = [UIAlertAction actionWithTitle:_okText
																											 style:UIAlertActionStyleCancel
																										 handler:^(UIAlertAction * _Nonnull action) {
																										 }];
		[alertController addAction:okAction];
		[self presentViewController:alertController animated:YES completion:completition];
	}
	else
	{
		SILENCE_DEPRECATION(UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
																																				message:message
																																			 delegate:nil
																															cancelButtonTitle:_okText
																															otherButtonTitles: nil];
												[alert show];
												);
		if (completition)
		{
			completition();
		}
	}
}


- (BOOL)_canUseAlertController
{
	BOOL can = NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1;
	return can;
}

@end
