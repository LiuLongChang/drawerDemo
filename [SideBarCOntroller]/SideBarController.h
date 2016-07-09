//
//  SideBarController.h
//  [SideBarCOntroller]
//
//  Created by 刘隆昌 on 15-1-5.
//  Copyright (c) 2015年 刘隆昌. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    SideBar_Controller,
    Right_Controller
}ContainType;


@protocol SideBarCtrDelegate <NSObject>

@required
-(id)addContainer:(ContainType)type;
@optional
-(CGFloat)MaxStartRangeX;
-(CGFloat)MaxOffSet;
-(CGFloat)SwiptSpeedX;

@end




@interface SideBarController : UIViewController
{
    
    UIViewController * sideBarView;
    UIViewController * rightView;
    
}

@property(nonatomic,weak)id<SideBarCtrDelegate>delegate;

-(CGFloat)getMaxStartPoint;
-(CGFloat)getMaxOffSet;
-(CGFloat)getSwiptSpeedX;


-(void)showSideBar;
-(void)hideSideBar;
-(BOOL)flipStatus;


@end
