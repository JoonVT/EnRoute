//
//  MainView.m
//  EnRoute
//
//  Created by Joon Van Thuyne on 28/05/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame andAssignments:(NSArray *)assignments
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.backgroundColor = [UIColor colorWithRed:0.94 green:0.93 blue:0.9 alpha:1];
        
        [self addSubview:self.scrollView];
        
        int xPos = 0;
        
        for(Assignment *assignment in assignments)
        {
            self.assignmentView = [[AssignmentView alloc] initWithFrame:CGRectMake(xPos, 0, frame.size.width, frame.size.height)];
            [self.scrollView addSubview:self.assignmentView];
            
            xPos += self.assignmentView.frame.size.width;
        }
        
        self.scrollView.contentSize = CGSizeMake(xPos, 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        self.pageControl.numberOfPages = assignments.count;
        
        CGSize sizeOfPageControl = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
        
        self.pageControl.frame = CGRectMake(0, 0, sizeOfPageControl.width, sizeOfPageControl.height);
        
        self.pageControl.center = CGPointMake(self.frame.size.width /2, self.frame.size.height - (sizeOfPageControl.height / 2));
        
        [self addSubview:self.pageControl];
    }
    return self;
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
