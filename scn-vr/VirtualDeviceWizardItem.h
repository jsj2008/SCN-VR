//
//  VirtualDeviceWizardItem.h
//  scn-vr
//
//  Created by Michael Fuller on 1/15/15.
//  Copyright (c) 2015 M-Gate Labs. All rights reserved.
//

#import "WizardItem.h"
#import "PhysicalDeviceWizardItem.h"

@interface VirtualDeviceWizardItem : WizardItem

@property (strong, nonatomic, readonly) NSMutableArray * items;

- (instancetype)initWith:(PhysicalDeviceWizardItem *) deviceWizardItem;

-(void) filterDevices;

@end