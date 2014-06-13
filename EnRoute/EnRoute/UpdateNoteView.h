//
//  UpdateNoteView.h
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateNoteView : UIView

@property (nonatomic, strong) NSString *note;
@property (nonatomic,strong) UITextView *textView;

-(id)initWithFrame:(CGRect)frame andNote:(NSString *)note;

@end
