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
            self.assignmentView = [[AssignmentView alloc] initWithFrame:CGRectMake(xPos, 0, frame.size.width, frame.size.height) andAssignment:assignment];
            
            CGFloat topRed = [[assignment.topColor objectForKey:@"red"] floatValue];
            CGFloat topGreen = [[assignment.topColor objectForKey:@"green"] floatValue];
            CGFloat topBlue = [[assignment.topColor objectForKey:@"blue"] floatValue];
            CGFloat topAlpha = [[assignment.topColor objectForKey:@"alpha"] floatValue];
            
            CGFloat bottomRed = [[assignment.bottomColor objectForKey:@"red"] floatValue];
            CGFloat bottomGreen = [[assignment.bottomColor objectForKey:@"green"] floatValue];
            CGFloat bottomBlue = [[assignment.bottomColor objectForKey:@"blue"] floatValue];
            CGFloat bottomAlpha = [[assignment.bottomColor objectForKey:@"alpha"] floatValue];
            
            UIColor *topColor = [UIColor colorWithRed:topRed green:topGreen blue:topBlue alpha:topAlpha];
            UIColor *bottomColor = [UIColor colorWithRed:bottomRed green:bottomGreen blue:bottomBlue alpha:bottomAlpha];
            
            CAGradientLayer *gradient = [CAGradientLayer layer];
            gradient.frame = frame;
            gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
            [self.assignmentView.layer insertSublayer:gradient atIndex:0];
            
            [self.assignmentView.btnPrevious addTarget:self action:@selector(previousTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.assignmentView.btnNext addTarget:self action:@selector(nextTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:self.assignmentView];
            
            xPos += self.assignmentView.frame.size.width;
        }
        
        self.scrollView.contentSize = CGSizeMake(xPos, 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        self.pageControl.numberOfPages = assignments.count;
        self.pageControl.hidden = YES;
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:.75];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:.75];
        
        CGSize sizeOfPageControl = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
        
        self.pageControl.frame = CGRectMake(0, 0, sizeOfPageControl.width, sizeOfPageControl.height);
        
        self.pageControl.center = CGPointMake(self.frame.size.width /2, self.frame.size.height - (sizeOfPageControl.height / 2));
        
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)previousTapped:(id)sender
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x - self.scrollView.frame.size.width, 0) animated:YES];
}

- (void)nextTapped:(id)sender
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width, 0) animated:YES];
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
