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
        
        self.title = @"Notitie";
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
    
    UIView *btnUpdateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIButton *btnUpdate = [UIButton buttonWithType:UIButtonTypeSystem];
    btnUpdate.frame = CGRectMake(0, 0, 60, 30);
    btnUpdate.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
    btnUpdate.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
    [btnUpdate addTarget:self action:@selector(updateNote:) forControlEvents:UIControlEventTouchUpInside];
    [btnUpdate setTitle:@"Opslaan" forState:UIControlStateNormal];
    [btnUpdateView addSubview:btnUpdate];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnUpdateView];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"Hallosans" size:20.0f],NSFontAttributeName,
                                                          nil] forState:UIControlStateNormal];
}

-(void)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updateNote:(id)sender
{
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
