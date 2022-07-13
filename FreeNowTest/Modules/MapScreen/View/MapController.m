//
//  MapController.m
//  FreeNowTest
//
//  Created by Shibanee Mishra on 11/07/22.
//

#import "MapController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "FreeNowTest-Swift.h"
@import GoogleMapsUtils;

@interface MapController () <GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@end

@implementation MapController
{
    GMSMapView *mapView;
    GMUClusterManager *_clusterManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpMapView];
    [self setUpCluster];
    [self setUpButtonForNavigation];
}

-(void) setUpButtonForNavigation{
    UIButton *but= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [but addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [but setFrame:CGRectMake(10, 20, 40, 40)];
    [but setImage: [UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [but setExclusiveTouch:YES];
    [mapView addSubview:but];
}

-(void)setUpCluster {
    id<GMUClusterAlgorithm> algorithm = [[GMUNonHierarchicalDistanceBasedAlgorithm alloc] init];
    id<GMUClusterIconGenerator> iconGenerator = [[GMUDefaultClusterIconGenerator alloc] init];
    id<GMUClusterRenderer> renderer =
    [[GMUDefaultClusterRenderer alloc] initWithMapView:mapView
                                  clusterIconGenerator:iconGenerator];
    _clusterManager =
    [[GMUClusterManager alloc] initWithMap:mapView algorithm:algorithm renderer:renderer];
    [_clusterManager setMapDelegate:self];
    [self generateClusterItems:_arrVachile];
    [_clusterManager cluster];
}

- (void)generateClusterItems:(NSMutableArray *)vehicleData {
    for (int i = 1; i < vehicleData.count; i++) {
        double lat = [vehicleData[i][@"latitude"] doubleValue];
        double lng = [vehicleData[i][@"longitude"] doubleValue];
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lng);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.title = [NSString stringWithFormat:@"%@",vehicleData[i][@"type"]];
        marker.snippet = [NSString stringWithFormat:@"%@",vehicleData[i][@"id"]];
        
        [_clusterManager addItem:marker];
    }
}

-(void)setUpMapView{
    
    CLLocationCoordinate2D coor;
    coor.latitude=[_arrVachile[0][@"latitude"] doubleValue];
    coor.longitude=[_arrVachile[0][@"longitude"] doubleValue];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: [_arrVachile[0][@"latitude"] doubleValue] longitude: [_arrVachile[0][@"longitude"] doubleValue] zoom:10];
    mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.myLocationEnabled = YES;
    [self.viewContainer addSubview:mapView];
}

-(void) buttonClicked:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    // center the map on tapped marker
    [mapView animateToLocation:marker.position];
    // check if a cluster icon was tapped
    if ([marker.userData conformsToProtocol:@protocol(GMUCluster)]) {
        // zoom in on tapped cluster
        [mapView animateToZoom:mapView.camera.zoom + 1];
        return YES;
    }
    return NO;
}

- (void)mapView:(GMSMapView *)mapView
idleAtCameraPosition:(GMSCameraPosition *)cameraPosition {
    // show current map view bound
    GMSVisibleRegion visibleRegion = [mapView.projection visibleRegion];
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc]initWithRegion:visibleRegion];
    CLLocationCoordinate2D northWest = CLLocationCoordinate2DMake(bounds.northEast.latitude, bounds.southWest.longitude);
    CLLocationCoordinate2D southEast = CLLocationCoordinate2DMake(bounds.southWest.latitude, bounds.northEast.longitude);
    
    // get vehicleList with live location
    VehicleListViewModel * viewModel = [[VehicleListViewModel alloc] init];
    [viewModel fetchVehicleDetailsWithLatitude1:[NSString stringWithFormat:@"%f",northWest.latitude] longitude1:[NSString stringWithFormat:@"%f",northWest.longitude] latitude2:[NSString stringWithFormat:@"%f",southEast.latitude] longitude2:[NSString stringWithFormat:@"%f",southEast.longitude] isFromMapController: YES ];
    
}

// callback from api calling
-(void)VehicleList:(NSMutableArray *)arrVehicle
{
    _arrVachile = [[NSMutableArray alloc] init];
    [_arrVachile addObjectsFromArray:arrVehicle];
    [mapView clear]; // clear the map
    [self setUpMapView];
    [self setUpCluster];
    
}



@end
