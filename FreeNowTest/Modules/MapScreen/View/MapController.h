//
//  MapController.h
//  FreeNowTest
//
//  Created by Shibanee Mishra on 11/07/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapController : UIViewController
@property NSMutableArray * arrVachile;
@property NSString*str;

typedef void (^CompleteCallback)(void);
-(void)VehicleList:(NSMutableArray *)arrVehicle;


@end

NS_ASSUME_NONNULL_END




