//
//  UpdateNoteView.m
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "UpdateNoteView.h"

@implementation UpdateNoteView

- (id)initWithFrame:(CGRect)frame andNote:(NSString *)note
{
    self = [super initWithFrame:frame];
    if (self) {
        self.note = note;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height - 216)];
        self.textView.text = self.note;
        self.textView.backgroundColor = [UIColor whiteColor];
        self.textView.font = [UIFont fontWithName:@"Hallosans" size:20];
        [self.textView becomeFirstResponder];
        [self.textView setUserInteractionEnabled:YES];
        [self addSubview:self.textView];
    }
    return self;
}

@end
