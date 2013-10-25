//
//  CPDScatterPlotViewController.m
//  CorePlotDemo
//
//  Created by Fahim Farook on 19/5/12.
//  Copyright 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import "CPDScatterPlotViewController.h"
@interface CPDScatterPlotViewController()
@property BOOL graphDidLoad;

// 3 CPTScatterPlot.type 1->Time -1-> Duration.

@property (weak, nonatomic) CPTScatterPlot *sleepPlot;
@property (weak, nonatomic) CPTScatterPlot *wakePlot;
@property (weak, nonatomic) CPTScatterPlot *lengthPlot;
@property (nonatomic) int type;
@property (retain, nonatomic) UILabel *stateLabel;
@end


@implementation CPDScatterPlotViewController

@synthesize hostView = hostView_;
@synthesize graphDidLoad;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UIViewController lifecycle methods
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(!graphDidLoad)
    {
        //set type here is Time , switch to change to Duration type.
    self.type = 1;
    [self initPlot];
    self.lengthPlot.hidden = YES;
    }
    graphDidLoad = YES;
}

#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
    [self CreateBackButton];
    [self CreateSwitchButtonsAndStateLabel];
}

-(void)configureHost {
    
	self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
	self.hostView.allowPinchScaling = YES;    
	[self.view addSubview:self.hostView];
    
}

-(void)configureGraph {
	// 1 - Create the graph
	CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
	[graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    
    //configure the graph;
    graph.paddingTop = 30.0f;
    graph.paddingLeft = 0.0f;
    graph.paddingRight = 0.0f;
    graph.paddingBottom = 0.0f;
    
	self.hostView.hostedGraph = graph;

//	// 2 - Set graph title
//	NSString *title = @"Your Graph";
//	graph.title = title;  
//	// 3 - Create and set text style
//	CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
//	titleStyle.color = [CPTColor whiteColor];
//	titleStyle.fontName = @"Helvetica-Bold";
//	titleStyle.fontSize = 16.0f;
//	graph.titleTextStyle = titleStyle;
//	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
//	graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
	// 4 - Set padding for plot area
	[graph.plotAreaFrame setPaddingLeft:0.0f];
	[graph.plotAreaFrame setPaddingBottom:10.0f];
	// 5 - Enable user interactions for plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = YES;
}

-(void)configurePlots { 
	// 1 - Get graph and plot space
	CPTGraph *graph = self.hostView.hostedGraph;
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	// 2 - Create the three plots
    //sleep.
	self.sleepPlot = [[CPTScatterPlot alloc] init];
	self.sleepPlot.dataSource = self;
	self.sleepPlot.identifier = CPDSleep;
	CPTColor *sleepColor = [CPTColor blueColor];
	[graph addPlot:self.sleepPlot toPlotSpace:plotSpace];
    //wake.
	self.wakePlot = [[CPTScatterPlot alloc] init];
	self.wakePlot.dataSource = self;
	self.wakePlot.identifier = CPDWake;
	CPTColor *wakeColor = [CPTColor greenColor];
	[graph addPlot:self.wakePlot toPlotSpace:plotSpace];
    //length.
	self.lengthPlot = [[CPTScatterPlot alloc] init];
	self.lengthPlot.dataSource = self;
	self.lengthPlot.identifier = CPDLength;
	CPTColor *lengthColor = [CPTColor redColor];
	[graph addPlot:self.lengthPlot toPlotSpace:plotSpace];
	// 3 - Set up plot space
	[plotSpace scaleToFitPlots:[NSArray arrayWithObjects:self.sleepPlot, self.wakePlot, self.lengthPlot, nil]];
	CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
	[xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];        
	plotSpace.xRange = xRange;
	CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
	[yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
	plotSpace.yRange = yRange;    
	// 4 - Create styles and symbols
    //sleep.
	CPTMutableLineStyle *sleepLineStyle = [self.sleepPlot.dataLineStyle mutableCopy];
	sleepLineStyle.lineWidth = 2.5;
	sleepLineStyle.lineColor = sleepColor;
	self.sleepPlot.dataLineStyle = sleepLineStyle;
	CPTMutableLineStyle *sleepSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	sleepSymbolLineStyle.lineColor = sleepColor;
	CPTPlotSymbol *sleepSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	sleepSymbol.fill = [CPTFill fillWithColor:sleepColor];
	sleepSymbol.lineStyle = sleepSymbolLineStyle;
	sleepSymbol.size = CGSizeMake(4.0f, 4.0f);
	self.sleepPlot.plotSymbol = sleepSymbol;
    //wake.
	CPTMutableLineStyle *wakeLineStyle = [self.wakePlot.dataLineStyle mutableCopy];
	wakeLineStyle.lineWidth = 1.0;
	wakeLineStyle.lineColor = wakeColor;
	self.wakePlot.dataLineStyle = wakeLineStyle;
	CPTMutableLineStyle *wakeSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	wakeSymbolLineStyle.lineColor = wakeColor;
	CPTPlotSymbol *wakeSymbol = [CPTPlotSymbol starPlotSymbol];
	wakeSymbol.fill = [CPTFill fillWithColor:wakeColor];
	wakeSymbol.lineStyle = wakeSymbolLineStyle;
	wakeSymbol.size = CGSizeMake(4.0f, 4.0f);
	self.wakePlot.plotSymbol = wakeSymbol;
    //length
	CPTMutableLineStyle *lengthLineStyle = [self.lengthPlot.dataLineStyle mutableCopy];
	lengthLineStyle.lineWidth = 1.0;
	lengthLineStyle.lineColor = lengthColor;
	self.lengthPlot.dataLineStyle = lengthLineStyle;  
	CPTMutableLineStyle *lengthSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	lengthSymbolLineStyle.lineColor = lengthColor;
	CPTPlotSymbol *lengthSymbol = [CPTPlotSymbol diamondPlotSymbol];
	lengthSymbol.fill = [CPTFill fillWithColor:lengthColor];
	lengthSymbol.lineStyle = lengthSymbolLineStyle;
	lengthSymbol.size = CGSizeMake(4.0f, 4.0f);
	self.lengthPlot.plotSymbol = lengthSymbol;      
}

-(void)configureAxes {
	// 1 - Create styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor whiteColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 20.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 1.0f;
	axisLineStyle.lineColor = [CPTColor whiteColor];
	CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
	axisTextStyle.color = [CPTColor whiteColor];
	axisTextStyle.fontName = @"Helvetica";    
	axisTextStyle.fontSize = 11.0f;
	CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor whiteColor];
	tickLineStyle.lineWidth = 2.0f;
	CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor blackColor];
	tickLineStyle.lineWidth = 1.0f;
	// 2 - Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
	// 3 - Configure x-axis
	CPTAxis *x = axisSet.xAxis;
	x.title = @"Dates"; 
	x.titleTextStyle = axisTitleStyle;    
	x.titleOffset = 30.0f;
	x.axisLineStyle = axisLineStyle;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	x.labelTextStyle = axisTextStyle;    
	x.majorTickLineStyle = axisLineStyle;
	x.majorTickLength = 4.0f;
	x.tickDirection = CPTSignNegative;
	CGFloat dateCount = [[[CPDSleepingBeauty shareInstance] dates] count];
	NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
	NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount]; 
	NSInteger i = 0;
	for (NSString *date in [[CPDSleepingBeauty shareInstance] dates]) {
		CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
		CGFloat location = i++;
		label.tickLocation = CPTDecimalFromCGFloat(location);
		label.offset = x.majorTickLength;
		if (label) {
			[xLabels addObject:label];
			[xLocations addObject:[NSNumber numberWithFloat:location]];                        
		}
	}
	x.axisLabels = xLabels;    
	x.majorTickLocations = xLocations;
    
    
	// 4 - Configure y-axis
	CPTAxis *y = axisSet.yAxis;
    NSString *temp;
    if(self.type == 1)
    {
        temp = @"Time|O'Clock";
    }
    else
    {
        temp = @"Duration|Hours";
    }
	y.title = temp;
	y.titleTextStyle = axisTitleStyle;
	y.titleOffset = -45.0f;
	y.axisLineStyle = axisLineStyle;
	y.majorGridLineStyle = gridLineStyle;
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
	y.labelTextStyle = axisTextStyle;    
	y.labelOffset = 10.0f;
	y.majorTickLineStyle = axisLineStyle;
	y.majorTickLength = 4.0f;
	y.minorTickLength = 2.0f;    
	y.tickDirection = CPTSignPositive;
	NSInteger majorIncrement = 1;
	CGFloat yMax = 24;
    CGFloat yDurationMax = 12;// should determine dynamically based on max time
	NSMutableSet *yLabels = [NSMutableSet set];
	NSMutableSet *yMajorLocations = [NSMutableSet set];
	if(self.type == 1)
    {
        for (NSInteger j = 0; j <= yMax; j += majorIncrement) {
            NSString *temp;
            if(j >= 0 && j <=2)
            {
                temp = [NSString stringWithFormat:@"%d", j+21];
            }
            else
            {
                temp = [NSString stringWithFormat:@"%d", j-3];
            }
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:temp textStyle:y.labelTextStyle];
			NSDecimal location = CPTDecimalFromInteger(j);
			label.tickLocation = location;
			label.offset = -y.majorTickLength - y.labelOffset;
			if (label) {
				[yLabels addObject:label];
            }
			[yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
            
        }
        y.axisLabels = yLabels;
        y.majorTickLocations = yMajorLocations;
    }
    else
    {
        for (NSInteger j = 0; j <= yDurationMax; j += majorIncrement) {
            NSString *temp;
         temp = [NSString stringWithFormat:@"%d", j];
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:temp textStyle:y.labelTextStyle];
			NSDecimal location = CPTDecimalFromInteger(j);
			label.tickLocation = location;
			label.offset = -y.majorTickLength - y.labelOffset;
			if (label) {
				[yLabels addObject:label];
            }
			[yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
            
        }
        y.axisLabels = yLabels;
        y.majorTickLocations = yMajorLocations;
    }
}

#pragma mark - Rotation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
	return [[[CPDSleepingBeauty shareInstance] dates] count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
	NSInteger valueCount = [[[CPDSleepingBeauty shareInstance] dates] count];
	switch (fieldEnum) {
		case CPTScatterPlotFieldX:
			if (index < valueCount) {
				return [NSNumber numberWithUnsignedInteger:index];
			}
			break;
			
		case CPTScatterPlotFieldY:
			if ([plot.identifier isEqual:CPDSleep] == YES) {
				return [[[CPDSleepingBeauty shareInstance] monthlyData:CPDSleep] objectAtIndex:index];
			} else if ([plot.identifier isEqual:CPDWake] == YES) {
				return [[[CPDSleepingBeauty shareInstance] monthlyData:CPDWake] objectAtIndex:index];
			} else if ([plot.identifier isEqual:CPDLength] == YES) {
				return [[[CPDSleepingBeauty shareInstance] monthlyData:CPDLength] objectAtIndex:index];
			}
			break;
	}
	return [NSDecimalNumber zero];
}

//Create a back button;
-(void)CreateBackButton
{
    UIImage *image = [UIImage imageNamed:@"backButton.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat xBackButton = 5.0f;
    CGFloat yBackButton = 1.0f;
    backButton.frame = CGRectMake( xBackButton, yBackButton, 28, 28);
     [backButton setBackgroundImage:image forState:UIControlStateNormal];
    // add target and actions
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    [self.view addSubview:backButton];
}

- (void) backButtonClicked: (id)sender
{
    NSLog(@"Tap");
    [self.navigationController popViewControllerAnimated:YES];
}

//Create 3 switch button.

-(void)CreateSwitchButtonsAndStateLabel
{
    // create type = 1 for default.
    self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(170.0f, 1.5f, 100, 27)];
    self.stateLabel.backgroundColor = [UIColor blackColor];
    self.stateLabel.textColor = [UIColor greenColor];
    self.stateLabel.text = @"Time";
    [self.view addSubview:self.stateLabel];
    
    UISwitch *Switch = [[UISwitch alloc] initWithFrame:CGRectMake(270.0f, 1.5f , 77, 27)];
    [Switch addTarget: self action: @selector(SwitchFlip:) forControlEvents:UIControlEventValueChanged];
    Switch.on = YES;
    [self.view addSubview:Switch];
    
    
    
}

-(IBAction)SwitchFlip:(id)sender
{
    
    UISwitch *onoff = (UISwitch *)sender;
    self.type = -self.type;
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
    if(!onoff.on)
    {
        self.stateLabel.text = @"Duration";
        self.wakePlot.hidden = YES;
        self.sleepPlot.hidden = YES;
        self.lengthPlot.hidden = NO;
    }
    else
    {
        self.stateLabel.text = @"Time";
        self.wakePlot.hidden = NO;
        self.sleepPlot.hidden = NO;
        self.lengthPlot.hidden = YES;
        
    }
   
}



@end
