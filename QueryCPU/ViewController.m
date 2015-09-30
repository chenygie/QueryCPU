//
//  ViewController.m
//  QueryCPU
//
//  Created by William Powers on 9/30/15.
//  Copyright © 2015 Gyrocade. All rights reserved.
//

#import "ViewController.h"
#import <sys/utsname.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>


@interface ViewController ()

@end

@implementation ViewController

NSString *machineModel()
{
    int mib[] = {CTL_HW, HW_MACHINE};
    size_t len = 0;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    char *machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}

NSString *AACPlatform()
{
    int mib[] = {CTL_HW, HW_MODEL};
    size_t len = 0;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    char *machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Model: %@\n", machineModel());
    NSString *model = machineModel();
    NSLog(@"Model: %@", model);
    
    if ([model isEqualToString:@"iPhone8,1"] || [model isEqualToString:@"iPhone8,2"])
    {
        NSString *strProcessorType = AACPlatform();
        if ([strProcessorType isEqualToString:@"N71AP"]) {
            printf("Manufacturer: Samsung");
            self.resultLabel.text = @"You are using a Samsung A9 processor.";
        } else {
            printf("Manufactorer: TSMC");
            self.resultLabel.text = @"You are using a TSMC A9 processor.";
        }
    }
    else
    {
        self.resultLabel.text = @"You must have an iPhone 6s to perform this test.";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
