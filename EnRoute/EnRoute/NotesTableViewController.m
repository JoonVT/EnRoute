//
//  OverviewTableViewController.m
//  Notities
//
//  Created by Niels Boey on 10/06/14.
//  Copyright (c) 2014 devine. All rights reserved.
//

#import "NotesTableViewController.h"

@interface NotesTableViewController ()

@end

@implementation NotesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = @"Notities";
        
        self.view.backgroundColor = [UIColor colorWithRed:0.58 green:0.86 blue:0.8 alpha:1];
        
        UIView *btnDoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        UIView *btnAddView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        
        UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
        btnDone.frame = CGRectMake(0, 0, 50, 30);
        btnDone.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
        btnDone.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
        [btnDone addTarget:self action:@selector(backTapped:) forControlEvents:UIControlEventTouchUpInside];
        [btnDone setTitle:@"Klaar" forState:UIControlStateNormal];
        [btnDoneView addSubview:btnDone];
        
        UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeSystem];
        btnAdd.frame = CGRectMake(0, 0, 50, 30);
        btnAdd.titleLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
        btnAdd.titleLabel.font = [UIFont fontWithName:@"Hallosans" size:20.0f];
        [btnAdd addTarget:self action:@selector(addNote:) forControlEvents:UIControlEventTouchUpInside];
        [btnAdd setTitle:@"Nieuw" forState:UIControlStateNormal];
        [btnAddView addSubview:btnAdd];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnDoneView];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btnAddView];
        
        self.notes = [[NSMutableArray alloc] init];
        
        NSString *path = [self notesArchivePath];
        self.notes = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if(!self.notes)
        {
            self.notes = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void)backTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (NSString *)notesArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"notes.archive"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[ColorCell class] forCellReuseIdentifier:@"colorCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)save
{
    NSString *path = [self notesArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.notes toFile:path];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString static *identifier = @"colorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    Note *note = [self.notes objectAtIndex:indexPath.row];
    
    NSInteger assignmentID;

    NSInteger num = indexPath.row;
    if (num & 1){
        cell.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
        assignmentID = 1;
    }else {
        cell.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
        assignmentID = 2;
    }
    
    NSString *circleImage = [NSString stringWithFormat:@"circle%ld",(long)assignmentID];
    
    UIImage *dot = [UIImage imageNamed:circleImage];
    cell.textLabel.text = note.note;
    cell.imageView.image = dot;
    cell.imageView.frame = CGRectMake(15, cell.imageView.frame.origin.y, cell.imageView.frame.size.width, cell.imageView.frame.size.height);
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

/* ADD */
-(void)addNote:(id)sender
{
    self.addNoteVC = [[AddNoteViewController alloc] initWithNibName:nil bundle:nil];
    self.addNoteVC.delegate = self;
    [self.navigationController pushViewController:self.addNoteVC animated:YES];
}

-(void)addNoteViewController:(AddNoteViewController *)viewController didSaveNote:(Note *)note
{
    NSString *onlineURL = @"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/notes";
    NSString *notetext = note.note;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"note": notetext, @"groupid": @"1", @"assignmentid": @"1"};
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:onlineURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSString *noteID = [responseObject objectForKey:@"id"];
        
        note.noteid = noteID;
        
        [self.notes addObject:note];
        [self save];
        [self.tableView reloadData];
        
        [self.navigationController popViewControllerAnimated:viewController];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error: %@", error);
#warning add ERROR when not online/can't be uploaded
    }];
}


/* UPDATE */
-(void)updateNoteViewController:(UpdateNoteViewController *)viewController didUpdateNote:(Note *)note atIndex:(NSInteger)index {
    
    NSString *noteid = note.noteid;
    NSString *onlineURL = [NSString stringWithFormat:@"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/notes/%@",noteid];
    NSString *notetext = note.note;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"note": notetext};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:onlineURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.notes replaceObjectAtIndex:index withObject:note];
        [self save];
        [self.tableView reloadData];
        
        [self.navigationController popViewControllerAnimated:viewController];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
#warning add ERROR when not online/can't update
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Note *note = [self.notes objectAtIndex:indexPath.row];
    
    self.updateNoteVC = [[UpdateNoteViewController alloc] initWithNibName:nil bundle:nil note:note.note noteid:note.noteid andIndex:indexPath.row];
    self.updateNoteVC.delegate = self;
    [self.navigationController pushViewController:self.updateNoteVC animated:YES];
}

/* DELETE */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Note *note = [self.notes objectAtIndex:indexPath.row];
        
        NSString *noteid = note.noteid;
        NSString *onlineURL = [NSString stringWithFormat:@"http://student.howest.be/niels.boey/20132014/MAIV/ENROUTE/api/notes/%@",noteid];
        
       AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager DELETE:onlineURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [self.notes removeObjectAtIndex:indexPath.row];
            [self save];
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
#warning add ERROR when not online/can't be deleted
        }];
    }
}

@end
