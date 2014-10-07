# SARate
======

SARate is a library to get positive app reviews on the AppStore.  SARate is a subclass of  [iRate](https://github.com/nicklockwood/iRate).



## Screens
![SARate screen](http://solovjev.com/libs/SARate/SARate1.png "SARate screen")
![SARate screen](http://solovjev.com/libs/SARate/SARate2.png "SARate screen")



## Youtube video
[![SARate youtube](http://solovjev.com/libs/SARate/SARate3.png "Youtube demo")](http://youtu.be/A0K6BaOipW4)  



## Requirements

- iOS 5+,
- ARC.

## Installation

1. Drop `SARate` files into your project.
2. Add `QuartzCore.framework`, `MessageUI.framework` to your project.


## Example Usage

``` objective-c
#import "SARate.h"

+ (void)initialize
{
    //configure
    [SARate sharedInstance].daysUntilPrompt = 5;
    [SARate sharedInstance].usesUntilPrompt = 5;
    [SARate sharedInstance].remindPeriod = 30;
    [SARate sharedInstance].email = @"andrei@solovjev.com";
}
```

## Customization


``` objective-c
#import "SARate.h"

+ (void)initialize
{
    //configure
    [SARite sharedInstance].daysUntilPrompt = 5;
    [SARite sharedInstance].usesUntilPrompt = 5;
    [SARite sharedInstance].remindPeriod = 30;
    [SARite sharedInstance].promptForNewVersionIfUserRated = YES;
    //enable preview mode
    [SARite sharedInstance].previewMode = YES;
    
    [SARite sharedInstance].email = @"andrei@solovjev.com";
    [SARite sharedInstance].emailSubject = @"App";
    [SARite sharedInstance].emailText = @"Disadvantages: ";
    [SARite sharedInstance].headerLabelText = @"Like app?";
    [SARite sharedInstance].descriptionLabelText = @"Touch the star to rate.";
    [SARite sharedInstance].rateButtonLabelText = @"Rate";
    [SARite sharedInstance].cancelButtonLabelText = @"Not Now";
    [SARite sharedInstance].setRaitingAlertTitle = @"Rate";
    [SARite sharedInstance].setRaitingAlertMessage = @"Touch the star to rate.";
    [SARite sharedInstance].appstoreRaitingAlertTitle = @"Write a review on the AppStore";
    [SARite sharedInstance].appstoreRaitingAlertMessage = @"Would you mind taking a moment to rate it on the AppStore? It won’t take more than a minute. Thanks for your support!";
    [SARite sharedInstance].appstoreRaitingCancel = @"Cancel";
    [SARite sharedInstance].appstoreRaitingButton = @"Rate It Now";
    [SARite sharedInstance].disadvantagesAlertTitle = @"Disadvantages";
    [SARite sharedInstance].disadvantagesAlertMessage = @"Please specify the deficiencies in the application. We will try to fix it!";
}
```

## Contact

Andrei Solovjev

- https://github.com/andrei200287
- andrei@solovjev.com
- http://solovjev.com

## License
SARate is available under the MIT license. See the LICENSE file for more info.
