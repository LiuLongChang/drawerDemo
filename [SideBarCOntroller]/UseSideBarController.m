//
//  UseSideBarController.m
//  [SideBarCOntroller]
//
//  Created by 刘隆昌 on 15-1-5.
//  Copyright (c) 2015年 刘隆昌. All rights reserved.
//

#import "UseSideBarController.h"

#import "RightViewController.h"

@interface UseSideBarController ()<SideBarCtrDelegate>

@end

@implementation UseSideBarController

- (void)viewDidLoad {
    self.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(id)addContainer:(ContainType)type{
    
    switch (type) {
            
        case SideBar_Controller:{
            
            return [self.storyboard instantiateViewControllerWithIdentifier:@"sidebar"];
        
        }
            
        case Right_Controller:{
            
            RightViewController * right = [self.storyboard instantiateViewControllerWithIdentifier:@"right"];
            right.sideBarVC = self;
            return right;
            
        }
            
        default:
            break;
    }
    return nil;
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
