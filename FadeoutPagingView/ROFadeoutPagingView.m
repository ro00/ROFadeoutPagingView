//
//  ROFadeoutPagingView.m
//  FadeoutPagingView
//
//  Created by Jack on 13-7-18.
//  Copyright (c) 2013年 iamro00. All rights reserved.
//

#import "ROFadeoutPagingView.h"

@implementation ROFadeoutPagingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithImages:(NSArray*)imgs frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        pagingsImageViews = [[NSMutableArray alloc] init];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(paning:)];
        [self addGestureRecognizer:pan];
        [imgs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIImage *img = obj;
            UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
            imgV.contentMode = UIViewContentModeScaleAspectFit;
            imgV.center = CGPointMake(self.bounds.size.width/2.+idx*self.bounds.size.width, self.bounds.size.height/2.);
            imgV.frame = self.frame;
            [self addSubview:imgV];
            imgV.clipsToBounds = YES;
            [pagingsImageViews addObject:imgV];
            [self sendSubviewToBack:imgV];
        }];
    }
    
    if(slideShowEnabled)timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(slideShow) userInfo:nil repeats:YES];
    [self updatePagesWithPercentage:0 andCurrentPage:currentPageIndex withAnimate:NO];
    return self;
}

static bool down;

-(void)slideShow{
    if(!down)currentPageIndex++;
    else currentPageIndex--;
    if (currentPageIndex>=[pagingsImageViews count]-1||currentPageIndex==0) {
        down=!down;
    }
    [self updatePagesWithPercentage:0 andCurrentPage:currentPageIndex withAnimate:YES];
}

-(void)paning:(UIPanGestureRecognizer*)gest{
    CGPoint p = [gest translationInView:self];
    CGFloat percentage = .0f;
    if (gest.state == UIGestureRecognizerStateBegan) {
        
    }else if (gest.state == UIGestureRecognizerStateChanged) {
        currentPaningWidth-=p.x;
        percentage = currentPaningWidth/(CGFloat)kPaningPerPageWidth;
        if(percentage>=1&&currentPageIndex<[pagingsImageViews count]-1){
            currentPaningWidth = 0;
            currentPageIndex++;
        }else if(percentage<=-1&&currentPageIndex>0){
            currentPaningWidth = 0;
            currentPageIndex--;
        }
        NSLog(@"percentage = %f, current page is %d",percentage,currentPageIndex);
        [self updatePagesWithPercentage:percentage andCurrentPage:currentPageIndex withAnimate:NO];
    }else if (gest.state == UIGestureRecognizerStateEnded||gest.state ==UIGestureRecognizerStateFailed||gest.state ==UIGestureRecognizerStateCancelled) {
        currentPaningWidth = 0;
        if (percentage>0.5) {
            currentPageIndex++;
        }
        [self updatePagesWithPercentage:percentage andCurrentPage:currentPageIndex withAnimate:YES];
    }
    [gest setTranslation:CGPointZero inView:self];
}

-(void)updatePagesWithPercentage:(CGFloat)p andCurrentPage:(int)page withAnimate:(BOOL)animate{
    [pagingsImageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imgView = obj;
        if (idx == page) {
            void(^block)(void) = ^{
                if (p<0) {
                    imgView.center = CGPointMake(self.bounds.size.width/2.-p*imgView.bounds.size.width, self.bounds.size.height/2.);
                }
                else{
                    imgView.center = CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.);
                    imgView.alpha = 1-p;
                    imgView.transform = CGAffineTransformMakeScale(1+p, 1+p);
                }
            };
            if (animate) {
                [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    block();
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                block();
            }
        }else{
            CGFloat ap = fabsf(p);
            void(^block)(void) = ^{
                int dis = idx - page;
                if (dis<0) {
                    if (dis==-1) {
                        if (p<0) {
                            imgView.alpha = 0+ap;
                            imgView.transform = CGAffineTransformMakeScale(2-ap, 2-ap);
                            imgView.center = CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.);
                        }else{
                            imgView.alpha = 0;
                            imgView.transform = CGAffineTransformMakeScale(2, 2);
                            imgView.center = CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.);
                        }
                    }else{
                        imgView.alpha = 0;
                        imgView.transform = CGAffineTransformMakeScale(2, 2);
                        imgView.center = CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.);
                    }
                }else{
                    imgView.alpha = 1;
                    imgView.transform = CGAffineTransformMakeScale(1, 1);
                    imgView.center = CGPointMake(self.bounds.size.width/2.+dis*self.bounds.size.width-p*imgView.bounds.size.width, self.bounds.size.height/2.);
                }
            };
            if (animate) {
                [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    block();
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                block();
            }
        }
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
