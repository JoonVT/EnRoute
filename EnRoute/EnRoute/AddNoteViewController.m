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
    
    UIView *btnSaveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSave.frame = CGRectMake(0, 0, 60, 30);
    btnSave.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
    btnSave.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
    [btnSave addTarget:self action:@selector(saveNote:) forControlEvents:UIControlEventTouchUpInside];
    [btnSave setTitle:@"Opslaan" forState:UIControlStateNormal];
    [btnSaveView addSubview:btnSave];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnSaveView];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"Hallosans" size:20.0f],NSFontAttributeName,
                                                          nil] forState:UIControlStateNormal];
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
