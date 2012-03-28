//
//  DetailViewController.m
//  Sparrow
//
//  Created by Geoff Shapiro on 7/17/11.
//  Copyright 2011 iFish Productions LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "SPCategoryTableView.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end



@implementation DetailViewController

@synthesize toolbar, popoverController, detailItem, detailDescriptionLabel, rootViewController;


#pragma mark -
#pragma mark Object insertion

- (IBAction)insertNewObject:(id)sender {
//	[self.rootViewController insertNewObject:sender];	
}


#pragma mark -
#pragma mark Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setDetailItem:(NSManagedObject *)managedObject {
    
	if (detailItem != managedObject) {
		[detailItem release];
		detailItem = [managedObject retain];
		
        // Update the view.
        [self configureView];
	}
    
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }		
}


- (void)configureView {
    // Update the user interface for the detail item.
    detailDescriptionLabel.text = [[detailItem valueForKey:@"timeStamp"] description];
}


#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController*)pc {

//	CGFloat height = ((RootViewController *)[((UINavigationController *)aViewController).viewControllers objectAtIndex:0]).tableView.visibleCells.count;
	[pc setPopoverContentSize:CGSizeMake(320, 170)];

    barButtonItem.title = @"Account";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
//	[pc setPopoverContentSize:CGSizeMake(320, 20)];
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
}


#pragma mark -
#pragma mark View lifecycle


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self performSelectorInBackground:@selector(createColumns:) withObject:nil];
	engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
	engine.consumerKey = kOAuthConsumerKey;
	engine.consumerSecret = kOAuthConsumerSecret;
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:engine delegate:self];
	NSLog(@"0.0 %@ %@", engine, controller);
	controller.modalInPopover = YES;
	[self presentModalViewController:controller animated:YES];
	
}

- (void)viewWillAppear:(BOOL)animated {

}

- (void)createColumns:(id)create {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	SPCategoryTableView *timeline = [[SPCategoryTableView alloc] initWithStyle:UITableViewStylePlain andFrame:CGRectMake(0, 44, 350, 1028)];
	[self.view addSubview:timeline.view];
	NSArray *ifish = [[NSArray alloc] initWithObjects:@"iFish", @"iFish1", @"iFish2", nil];
	[timeline setData:ifish];
	[timeline.tableView reloadData];
	UIImageView *shadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 768, 20)];
	[shadow setImage:[UIImage imageNamed:@"shadow"]];
	[self.view addSubview:shadow];
	

	[pool drain];
}
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	
}

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	
}
- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	
}
- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	
}


/*
- (void)viewWillAppear:(BOOL)animated {i
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.popoverController = nil;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	
    [popoverController release];
    [toolbar release];
	
	[detailItem release];
	[detailDescriptionLabel release];
    
	[super dealloc];
}	


@end
