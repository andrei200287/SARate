//
//  SARate.h
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

#import "iRate.h"

@interface SARate : iRate

+ (SARate *)sharedInstance;

@property (nonatomic, strong) NSString *headerLabelText;
@property (nonatomic, strong) NSString *descriptionLabelText;
@property (nonatomic, strong) NSString *rateButtonLabelText;
@property (nonatomic, strong) NSString *cancelButtonLabelText;
@property (nonatomic, strong) NSString *setRaitingAlertTitle;
@property (nonatomic, strong) NSString *setRaitingAlertMessage;
@property (nonatomic, strong) NSString *appstoreRaitingAlertTitle;
@property (nonatomic, strong) NSString *appstoreRaitingAlertMessage;
@property (nonatomic, strong) NSString *appstoreRaitingCancel;
@property (nonatomic, strong) NSString *appstoreRaitingButton;
@property (nonatomic, strong) NSString *disadvantagesAlertTitle;
@property (nonatomic, strong) NSString *disadvantagesAlertMessage;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *emailSubject;
@property (nonatomic, strong) NSString *emailText;
@property (nonatomic, strong) NSString *emailErrorAlertTitle;
@property (nonatomic, strong) NSString *emailErrorAlertText;
@property (nonatomic, strong) NSString *okText;
@property (nonatomic, assign) int minAppStoreRaiting;

@end
