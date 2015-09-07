//
//  HUMMapViewController.m
//  Humon
//
//  Created by Simon Van Dyk on 2015/09/07.
//  Copyright (c) 2015 Simon van Dyk. All rights reserved.
//

#import "HUMMapViewController.h"
@import MapKit;

@interface HUMMapViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;

@end

@implementation HUMMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the title of the navigation bar
    self.title = NSLocalizedString(@"Humon", nil);
    
    // Create and add a mapView as a subview of the main view
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
