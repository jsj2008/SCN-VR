//
//  MobileDeviceManager.m
//  SCN-VR
//
//  Created by Michael Fuller on 12/19/14.
//  Copyright (c) 2014 M-Gate Labs. All rights reserved.
//

#import "MobileDeviceManager.h"

@implementation MobileDeviceManager

+ (id)sharedManager {
    static MobileDeviceManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _devices = [[NSMutableArray alloc] initWithCapacity:10];
        
        // iPhone4S              640×960   326 ppi
        [self addDevice:@"iPhone 4S" identifier:@"iphone4s" widthPx:960 heightPx:640 dpi:326 tablet:NO].internal = YES;
        
        // iPhone5               640×1136  326 ppi
        // iPhone5C              640×1136  326 ppi
        // iPhone5S              640×1136  326 ppi
        [self addDevice:@"iPhone 5" identifier:@"iphone5" widthPx:1136 heightPx:640 dpi:326 tablet:NO].internal = YES;
        
        // iPhone6               750×1334  326 ppi
        [self addDevice:@"iPhone 6" identifier:@"iphone6" widthPx:1334 heightPx:750 dpi:326 tablet:NO].internal = YES;
        
        // iPhone6Plus           1080×1920 401 ppi
        [self addDevice:@"iPhone 6+" identifier:@"iphone6plus" widthPx:2208 heightPx:1242 dpi:326 tablet:NO].internal = YES;
        
        //iPad2                 1024x768  132 ppi
        [self addDevice:@"iPad 2" identifier:@"ipad2" widthPx:1024 heightPx:768 dpi:132 tablet:YES].internal = YES;
        
        //iPad (3gen)           2048x1536 264 ppi
        //iPad (4gen)           2048x1536 264 ppi
        //iPad Air              2048x1536 264 ppi
        [self addDevice:@"iPad" identifier:@"ipad" widthPx:2048 heightPx:1536 dpi:264 tablet:YES].internal = YES;
        
        //iPad mini             1024x768  163 ppi
        [self addDevice:@"iPad (Mini)" identifier:@"ipadmini" widthPx:1024 heightPx:768 dpi:163 tablet:YES].internal = YES;
        
        //iPad mini (retina)    2048x1536 326 ppi
        [self addDevice:@"iPad (Mini Retina)" identifier:@"ipadmini2" widthPx:2048 heightPx:1536 dpi:326 tablet:YES].internal = YES;
        
    }
    return self;
}

-(void) trimDevicesForCurrentDeviceWidth:(int) widthPx heightPx:(int) heightPx tablet:(BOOL) tablet {
    
    for (int i = (int)_devices.count - 1; i >= 0; i--) {
        MobileDeviceConfiguration * test = [_devices objectAtIndex:i];
        // Different screen sizes or types will lead to it being discarded
        if (test.widthPx != widthPx || test.heightPx != heightPx || test.tablet != tablet) {
            [_devices removeObjectAtIndex:i];
        }
    }
    
    _device = [_devices objectAtIndex:0];
}

-(MobileDeviceConfiguration *) addDevice:(NSString *) name identifier:(NSString *) identifier widthPx:(int) widthPx heightPx:(int) heightPx dpi:(float) dpi  tablet:(BOOL) tablet{
    
    MobileDeviceConfiguration * device = [[MobileDeviceConfiguration alloc] initAs:name identifier:identifier widthPx:widthPx heightPx:heightPx dpi:dpi tablet:tablet];
    
    [_devices addObject:device];
    
    return device;
}

-(BOOL) removeDeviceWithIndex:(int) index {
    if (index >= 0 && index < _devices.count) {
        MobileDeviceConfiguration * device = [_devices objectAtIndex:index];
        if (device.internal) {
            return NO;
        }
        [_devices removeObjectAtIndex:index];
        return YES;
    }
    return NO;
}

@end
