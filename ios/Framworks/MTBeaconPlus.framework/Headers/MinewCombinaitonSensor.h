//
//  MinewCombinaitonSensor.h
//  MTBeaconPlus
//
//  Created by jelonCai on 2025/10/17.
//  Copyright © 2025 MinewTech. All rights reserved.
//

#import <MTBeaconPlus/MTBeaconPlus.h>

NS_ASSUME_NONNULL_BEGIN

@interface MinewCombinaitonSensor : MinewFrame

@property (nonatomic, copy) NSString *mac;

@property (nonatomic, assign) NSInteger voltage_mV;

@property (nonatomic, assign) CGFloat humidity;
@property (nonatomic, assign) CGFloat temperature_C;

@end

NS_ASSUME_NONNULL_END
