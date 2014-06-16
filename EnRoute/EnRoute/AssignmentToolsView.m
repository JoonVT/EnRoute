//
//  AssignmentToolsView.m
//  En Route
//
//  Created by Joon Van Thuyne on 10/06/14.
//  Copyright (c) 2014 JoonVT. All rights reserved.
//

#import "AssignmentToolsView.h"

@implementation AssignmentToolsView

- (id)initWithAssignment:(Assignment *)assignment andFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *expanation1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"explanation1"]];
        expanation1.frame = CGRectMake(15, 100, 60, 60);
        UIImageView *expanation2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"explanation2"]];
        expanation2.frame = CGRectMake(frame.size.width-75, 200, 60, 60);
        UIImageView *expanation3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"explanation3"]];
        expanation3.frame = CGRectMake(15, 300, 60, 60);
        
        NSAttributedString *txtExplanation1 = [[NSAttributedString alloc] initWithString:assignment.explanation1 attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans" size:18], NSForegroundColorAttributeName : [UIColor blackColor], NSKernAttributeName : @(0.5f)}];
        
        NSAttributedString *txtExplanation2 = [[NSAttributedString alloc] initWithString:assignment.explanation2 attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans" size:18], NSForegroundColorAttributeName : [UIColor blackColor], NSKernAttributeName : @(0.5f)}];
        
        NSAttributedString *txtExplanation3 = [[NSAttributedString alloc] initWithString:assignment.explanation3 attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans" size:18], NSForegroundColorAttributeName : [UIColor blackColor], NSKernAttributeName : @(0.5f)}];
        
        self.lblExplanation1 = [[UILabel alloc] initWithFrame:CGRectMake(90, 80, frame.size.width-105, 100)];
        self.lblExplanation1.attributedText = txtExplanation1;
        self.lblExplanation1.numberOfLines = 0;
        
        self.lblExplanation2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 180, frame.size.width-105, 100)];
        self.lblExplanation2.attributedText = txtExplanation2;
        self.lblExplanation2.numberOfLines = 0;
        
        self.lblExplanation3 = [[UILabel alloc] initWithFrame:CGRectMake(90, 280, frame.size.width-105, 100)];
        self.lblExplanation3.attributedText = txtExplanation3;
        self.lblExplanation3.numberOfLines = 0;
        
        if (assignment.identifier == 3)
        {
            NSAttributedString *txtStart = [[NSAttributedString alloc] initWithString:@"START" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Hallosans-Black" size:22], NSForegroundColorAttributeName : [UIColor colorWithRed:0.76 green:0.62 blue:0.18 alpha:1], NSKernAttributeName : @(1.0f)}];
            
            self.btnMultipeer = [UIButton buttonWithType:UIButtonTypeSystem];
            self.btnMultipeer.frame = CGRectMake(100, 410, frame.size.width - 200, 45);
            [self.btnMultipeer setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
            [self.btnMultipeer setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
            [self.btnMultipeer setAttributedTitle:txtStart forState:UIControlStateNormal];
            
            [self addSubview:self.btnMultipeer];
        }
        
        self.btnNotes = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnNotes.frame = CGRectMake(0, frame.size.height - 81, 80, 81);
        [self.btnNotes setBackgroundImage:[UIImage imageNamed:@"button_notes"] forState:UIControlStateNormal];
        [self.btnNotes setBackgroundImage:[UIImage imageNamed:@"button_notes_pressed"] forState:UIControlStateHighlighted];
        
        self.btnFlash = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnFlash.frame = CGRectMake(self.btnNotes.frame.origin.x + self.btnNotes.frame.size.width, frame.size.height - 81, 80, 81);
        [self.btnFlash setBackgroundImage:[UIImage imageNamed:@"button_flash"] forState:UIControlStateNormal];
        [self.btnFlash setBackgroundImage:[UIImage imageNamed:@"button_flash_pressed"] forState:UIControlStateHighlighted];
        
        self.btnMicrophone = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnMicrophone.frame = CGRectMake(self.btnFlash.frame.origin.x + self.btnFlash.frame.size.width, frame.size.height - 81, 80, 81);
        [self.btnMicrophone setBackgroundImage:[UIImage imageNamed:@"button_microphone"] forState:UIControlStateNormal];
        [self.btnMicrophone setBackgroundImage:[UIImage imageNamed:@"button_microphone_pressed"] forState:UIControlStateHighlighted];
        
        self.btnCamera = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnCamera.frame = CGRectMake(self.btnMicrophone.frame.origin.x + self.btnMicrophone.frame.size.width, frame.size.height - 81, 80, 81);
        [self.btnCamera setBackgroundImage:[UIImage imageNamed:@"button_camera"] forState:UIControlStateNormal];
        [self.btnCamera setBackgroundImage:[UIImage imageNamed:@"button_camera_pressed"] forState:UIControlStateHighlighted];
        
        [self addSubview:expanation1];
        [self addSubview:expanation2];
        [self addSubview:expanation3];
        [self addSubview:self.lblExplanation1];
        [self addSubview:self.lblExplanation2];
        [self addSubview:self.lblExplanation3];
        [self addSubview:self.btnNotes];
        [self addSubview:self.btnFlash];
        [self addSubview:self.btnMicrophone];
        [self addSubview:self.btnCamera];
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
