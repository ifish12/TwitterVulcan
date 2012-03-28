//
//  SPCategoryTableView.h
//  Sparrow
//
//  Created by Geoff Shapiro on 7/17/11.
//  Copyright 2011 iFish Productions LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCellInfoPopOverController.h"

@interface SPCategoryTableView : UITableViewController {
	NSArray *feed;
	SPCellInfoPopOverController *infoPopOver;
}
- (id)initWithStyle:(UITableViewStyle)style andFrame:(CGRect)frame;
- (void)setData:(NSArray *)data;
@end
