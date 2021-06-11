//
//  ViewController.m
//  ScreenTool
//
//  Created by boli on 2021/5/30.
//

#import "ViewController.h"
#import <ReplayKit/ReplayKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RPSystemBroadcastPickerView * _broadPickerView = [[RPSystemBroadcastPickerView alloc] initWithFrame:CGRectMake(50, 280, 80, 80)];
    _broadPickerView.preferredExtension = @"com.BpeerEI.CarBot.ScreenTool.Recoder";
    [self.view addSubview:_broadPickerView];
}


@end
