//
//  ROFadeoutPagingView.h
//  FadeoutPagingView
//
//  Created by Jack on 13-7-18.
//  Copyright (c) 2013年 iamro00. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPaningPerPageWidth 200

@interface ROFadeoutPagingView : UIView{
    NSMutableArray *pagingsImageViews;
    CGFloat currentPaningWidth;
    int currentPageIndex;
    BOOL slideShowEnabled;
    NSTimer* timer;
}

-(id)initWithImages:(NSArray*)imgs frame:(CGRect)frame;

@end
