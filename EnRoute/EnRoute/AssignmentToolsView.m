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
