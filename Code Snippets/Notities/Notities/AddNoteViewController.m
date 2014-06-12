//
//  AddNoteViewController.m
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "AddNoteViewController.h"

@interface AddNoteViewController ()
@end

@implementation AddNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Notitie";
    }
    return self;
}

- (void)loadView {
    CGRect sizeofScreen = [[UIScreen mainScreen] bounds];
    self.view = [[AddNoteView alloc] initWithFrame:sizeofScreen];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNote:)];
}

-(void)saveNote:(id)sender {
    Note *note = [[Note alloc] initWithNote:self.view.textView.text andNoteID:@""];
    
    if([self.delegate respondsToSelector:@selector(addNoteViewController:didSaveNote:)]){
        [self.delegate addNoteViewController:self didSaveNote:note];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
