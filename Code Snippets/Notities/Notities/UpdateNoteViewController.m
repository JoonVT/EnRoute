//
//  UpdateNoteViewController.m
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "UpdateNoteViewController.h"

@interface UpdateNoteViewController ()

@end

@implementation UpdateNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil note:(NSString *)note noteid:(NSString *)noteid andIndex:(NSInteger)index
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.note = note;
        self.noteid = noteid;
        self.index = index;
    }
    return self;
}

- (void)loadView {
    
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[UpdateNoteView alloc] initWithFrame:sizeofScreen andNote:self.note];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(updateNote:)];
}

-(void)updateNote:(id)sender {
    Note *note = [[Note alloc] initWithNote:self.view.textView.text andNoteID:self.noteid];
    
    if([self.delegate respondsToSelector:@selector(updateNoteViewController:didUpdateNote:atIndex:)]){
        [self.delegate updateNoteViewController:self didUpdateNote:note atIndex:self.index];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
