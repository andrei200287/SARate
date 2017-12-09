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

@interface SARateViewController ()

@property (nonatomic, strong) UIButton *star1;
@property (nonatomic, strong) UIButton *star2;
@property (nonatomic, strong) UIButton *star3;
@property (nonatomic, strong) UIButton *star4;
@property (nonatomic, strong) UIButton *star5;

@property (nonatomic, assign) int mark;

@end

@implementation SARateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mark = 0;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    
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
    
    _star1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_star1 setImage:[UIImage imageNamed:@"star-gray.png"] forState:UIControlStateNormal];
    [_star1 setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateSelected];
    [_star1 addTarget:self action:@selector(setRaiting:) forControlEvents:UIControlEventTouchUpInside];
    _star1.tag = 1;
    _star1.frame = CGRectMake(43, starY, starWeight, starHeight);
    [alertView addSubview:_star1];
    // 30 на 30
    
    
    _star2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_star2 setImage:[UIImage imageNamed:@"star-gray.png"] forState:UIControlStateNormal];
    [_star2 setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateSelected];
    [_star2 addTarget:self action:@selector(setRaiting:) forControlEvents:UIControlEventTouchUpInside];
    _star2.tag = 2;
    _star2.frame = CGRectMake(_star1.frame.origin.x+starWeight+separatorWidth, starY, starWeight, starHeight);
    [alertView addSubview:_star2];
    
    
    _star3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_star3 setImage:[UIImage imageNamed:@"star-gray.png"] forState:UIControlStateNormal];
    [_star3 setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateSelected];
    [_star3 addTarget:self action:@selector(setRaiting:) forControlEvents:UIControlEventTouchUpInside];
    _star3.tag = 3;
    _star3.frame = CGRectMake(_star2.frame.origin.x+starWeight+separatorWidth, starY, starWeight, starHeight);
    [alertView addSubview:_star3];
    
    
    _star4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_star4 setImage:[UIImage imageNamed:@"star-gray.png"] forState:UIControlStateNormal];
    [_star4 setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateSelected];
    [_star4 addTarget:self action:@selector(setRaiting:) forControlEvents:UIControlEventTouchUpInside];
    _star4.tag = 4;
    _star4.frame = CGRectMake(_star3.frame.origin.x+starWeight+separatorWidth, starY, starWeight, starHeight);
    [alertView addSubview:_star4];
    
    
    _star5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_star5 setImage:[UIImage imageNamed:@"star-gray.png"] forState:UIControlStateNormal];
    [_star5 setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateSelected];
    [_star5 addTarget:self action:@selector(setRaiting:) forControlEvents:UIControlEventTouchUpInside];
    _star5.tag = 5;
    _star5.frame = CGRectMake(_star4.frame.origin.x+starWeight+separatorWidth, starY, starWeight, starHeight);
    [alertView addSubview:_star5];
    
    
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
    [rateButton addTarget:self action:@selector(setRaiting) forControlEvents:UIControlEventTouchUpInside];
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
    [cancelButton addTarget:self action:@selector(hideRaiting) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.layer.borderWidth = 1;
    cancelButton.layer.borderColor = [[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1] CGColor];
    [alertView addSubview:cancelButton];
    
    _isShowed = YES;
    
}



- (void)setRaiting:(id)object {
    if ([object isKindOfClass:[UIButton class]]) {
        UIButton *currentButton = (UIButton *)object;
        _mark = (int) currentButton.tag;
        _star1.selected = (currentButton.tag >= _star1.tag);
        _star2.selected = (currentButton.tag >= _star2.tag);
        _star3.selected = (currentButton.tag >= _star3.tag);
        _star4.selected = (currentButton.tag >= _star4.tag);
        _star5.selected = (currentButton.tag >= _star5.tag);
    }
}


-(void)hideRaiting{
    [iRate sharedInstance].lastReminded = [NSDate date];
    _isShowed = NO;
    [self.view removeFromSuperview];
}


-(void)setRaiting{
    if (_mark == 0){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:_setRaitingAlertTitle message:_setRaitingAlertMessage delegate:nil cancelButtonTitle:_okText otherButtonTitles:nil];
        [alertView show];
        return;
    } else if (_mark >= _minAppStoreRaiting){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_appstoreRaitingAlertTitle
                                                        message:_appstoreRaitingAlertMessage
                                                       delegate:self
                                              cancelButtonTitle:_appstoreRaitingCancel
                                              otherButtonTitles:_appstoreRaitingButton, nil];
        [alert show];
        return;
        
        
    }
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:_disadvantagesAlertTitle message:_disadvantagesAlertMessage delegate:nil cancelButtonTitle:_okText otherButtonTitles:nil];
    [alertView show];
    [self sendMail];
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [iRate sharedInstance].ratedThisVersion = YES;
    if (buttonIndex != alertView.cancelButtonIndex){
        [[iRate sharedInstance] openRatingsPageInAppStore];
    }
    _isShowed = NO;
    [self.view removeFromSuperview];
    

}


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
        
        [self presentViewController:mailer animated:true completion:nil];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_emailErrorAlertTitle
                                                        message:_emailErrorAlertText
                                                       delegate:nil
                                              cancelButtonTitle:_okText
                                              otherButtonTitles: nil];
        [alert show];
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
