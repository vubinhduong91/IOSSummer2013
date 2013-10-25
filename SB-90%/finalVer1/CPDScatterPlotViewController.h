//
//  CPDScatterPlotViewController.h
//  CorePlotDemo
//
//  Created by Fahim Farook on 19/5/12.
//  Copyright 2012 RookSoft Pte. Ltd. All rights reserved.
//
#import "CorePlot-CocoaTouch.h"
#import "CPDConstants.h"
#import "CPDSleepingBeauty.h"


@interface CPDScatterPlotViewController : UIViewController <CPTPlotDataSource>

@property (nonatomic, strong) CPTGraphHostingView *hostView;

@end
