//
//  SideBarController.m
//  [SideBarCOntroller]
//
//  Created by 刘隆昌 on 15-1-5.
//  Copyright (c) 2015年 刘隆昌. All rights reserved.
//

#import "SideBarController.h"

@interface SideBarController ()


@property CGPoint startPoint;
@property(nonatomic)CGFloat maxOffSet;
@property(nonatomic)CGFloat maxStartRangeX;
@property(nonatomic)CGFloat currentOffSetX;
@property(nonatomic)BOOL isRight;
@property(nonatomic)CGFloat swiptSpeedX;
@property(nonatomic)BOOL isShow;



@end

@implementation SideBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentOffSetX = 0.0;
    _maxOffSet = 250;
    _maxStartRangeX = 80;
    _swiptSpeedX = 700;
    
    
    if ([self.delegate respondsToSelector:@selector(addContainer:)]) {
        
        sideBarView = [self.delegate addContainer:SideBar_Controller];
        if (sideBarView) {
            
            [self.view addSubview:sideBarView.view];
            sideBarView.view.bounds = self.view.bounds;
            
        }
        rightView = [self.delegate addContainer:Right_Controller];
        if (rightView) {
            [self.view addSubview:rightView.view];
            rightView.view.bounds = self.view.bounds;
        }
        [self.view bringSubviewToFront:rightView.view];
    }
    
    
    
    
    if ([self.delegate respondsToSelector:@selector(MaxStartRangeX)]) {
        [self setMaxStartRangeX:[self.delegate MaxStartRangeX]];
    }
    
    if ([self.delegate respondsToSelector:@selector(MaxOffSet)]) {
        [self setMaxOffSet:[self.delegate MaxOffSet]];
    }
    
    if ([self.delegate respondsToSelector:@selector(SwiptSpeedX)]) {
        [self setSwiptSpeedX:[self.delegate SwiptSpeedX]];
    }
    
    
    
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:panGesture];
    
    
    
}


-(void)panGesture:(UIPanGestureRecognizer*)panGestureRecognize{
    
    
    if (panGestureRecognize.state == UIGestureRecognizerStateBegan) {
        CGPoint recogPoint = [panGestureRecognize locationInView:self.view];
        _startPoint = recogPoint;
        //加阴影
        CALayer * layer = [rightView.view layer];
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOffset = CGSizeMake(1,1);
        layer.shadowOpacity = 1;
        layer.shadowRadius = 2.5;
    }
    
    if (panGestureRecognize.state == UIGestureRecognizerStateChanged) {
        

        CGPoint point = [panGestureRecognize translationInView:self.view];
        if (_startPoint.x>0 && _startPoint.x<_maxStartRangeX) {
            
            if (point.x >= 0) {
                [rightView.view setFrame:CGRectMake(point.x,rightView.view.frame.origin.y, rightView.view.frame.size.width, rightView.view.frame.size.height)];
                
                _currentOffSetX = point.x;
                _isRight = YES;
            }
            
        }
        
        
        
        if (_startPoint.x >= _maxOffSet-10 && _startPoint.x<self.view.frame.size.width && rightView.view.frame.origin.x>0) {
            
            if (point.x < 0 && ABS(point.x) <= _maxOffSet) {
                
                [rightView.view setFrame:CGRectMake(_maxOffSet+point.x,rightView.view.frame.origin.y,rightView.view.frame.size.width,rightView.view.frame.size.height)];
                
                _currentOffSetX = _maxOffSet+point.x;
                _isRight = NO;
                
            }
            
            if (point.x >0) {
                
                [rightView.view setFrame:CGRectMake(_maxOffSet+point.x, rightView.view.frame.origin.y, rightView.view.frame.size.width,rightView.view.frame.size.height)];
                _currentOffSetX = _maxOffSet + point.x;
                _isRight = YES;
                
            }
            
        }
        
    }
    
    if (panGestureRecognize.state == UIGestureRecognizerStateEnded) {
        
        CGFloat speed = ABS([panGestureRecognize velocityInView:self.view].x);
        if (_isRight) {
            
            if (_currentOffSetX >= self.view.frame.size.width/2-60||speed>=_swiptSpeedX) {
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:ABS(speed*0.000004+0.2)];
                [rightView.view setFrame:CGRectMake(_maxOffSet,rightView.view.frame.origin.y,rightView.view.frame.size.width,rightView.view.frame.size.height)];
                [UIView commitAnimations];
                _currentOffSetX = _maxOffSet;
                _isShow = YES;
                
            }else{
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:ABS(speed*0.000004+0.2)];
                [rightView.view setFrame:CGRectMake(0, rightView.view.frame.origin.y, rightView.view.frame.size.width,rightView.view.frame.size.height)];
                [UIView commitAnimations];
                _currentOffSetX = 0;
                _isShow = NO;
                
            }
            
            
        }else{
            
            
            if (_currentOffSetX<=self.view.frame.size.width/2-15 || ABS(speed >= _swiptSpeedX)) {
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:ABS(speed*0.000004+0.2)];
                [rightView.view setFrame:CGRectMake(0, rightView.view.frame.origin.y, rightView.view.frame.size.width,rightView.view.frame.size.height)];
                [UIView commitAnimations];
                _currentOffSetX = 0;
                _isShow = NO;
            }else{
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:ABS(speed*0.000004+0.2)];
                [rightView.view setFrame:CGRectMake(_maxOffSet, rightView.view.frame.origin.y,rightView.view.frame.size.width,rightView.view.frame.size.height)];
                [UIView commitAnimations];
                
                _currentOffSetX = _maxOffSet;
                _isShow = YES;
                
            }
            
        }
     
        
    }
    
    
    
    
    
}


-(CGFloat)getMaxStartPoint{
    return _maxStartRangeX;
}

-(CGFloat)getMaxOffSet{
    return _maxOffSet;
}

-(CGFloat)getSwiptSpeedX{
    
    return _swiptSpeedX;
}

-(void)setMaxStartRangeX:(CGFloat)point{
     _maxStartRangeX = point;
}

-(void)setMaxOffSet:(CGFloat)maxOffSet{
    _maxOffSet = maxOffSet;
}

-(void)setSwiptSpeedX:(CGFloat)speed{
    _swiptSpeedX = speed;
}

-(void)showSideBar{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.28];
    [rightView.view setFrame:CGRectMake(_maxOffSet,rightView.view.frame.origin.y,rightView.view.frame.size.width,rightView.view.frame.size.height)];
    [UIView commitAnimations];
    _currentOffSetX = _maxOffSet;
    _isShow = YES;
    
    CALayer * layer = [rightView.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 2.5;
    
    
}

-(void)hideSideBar{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.28];
    [rightView.view setFrame:CGRectMake(0, rightView.view.frame.origin.y,rightView.view.frame.size.width,rightView.view.frame.size.height)];
    [UIView commitAnimations];
    _currentOffSetX = _maxOffSet;
    _isShow = NO;
    
}


-(BOOL)flipStatus{
    
    if (_isShow) {
        [self hideSideBar];
    }else{
        [self showSideBar];
    }
    return _isShow;
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
