//
//  DetailViewController.h
//  Sparrow
//
//  Created by Geoff Shapiro on 7/17/11.
//  Copyright 2011 iFish Productions LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"
#define kOAuthConsumerKey        @"rtLPXBISQcocBShmBsIUrw"         //REPLACE With Twitter App OAuth Key
#define kOAuthConsumerSecret    @"hbVfDyY8xGCiIyl0BQItvxibAsibNrPG0csboIg0"     //REPLACE With Twitter App OAuth Secret

@class RootViewController;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, NSXMLParserDelegate, SA_OAuthTwitterControllerDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;

    NSManagedObject *detailItem;
	SA_OAuthTwitterEngine *engine;
    RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) NSManagedObject *detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, assign) IBOutlet RootViewController *rootViewController;

- (IBAction)insertNewObject:(id)sender;

@end
