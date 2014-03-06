//
//  AddViewController.m
//  noteWithSqlite
//
//  Created by Yang on 14-3-3.
//  Copyright (c) 2014年 Yang. All rights reserved.
//

#import "AddViewController.h"
#import "Note.h"
#import "dealWithNote.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize message;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self                                   = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //change the background of the view

    self.view.backgroundColor              = [UIColor greenColor];


    // add a textview

    self.text                              = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//self.text.backgroundColor = [UIColor redColor];
    self.text.text                         = self.message;
    [self.text setFont:[UIFont fontWithName:@"Helvetica" size:17]];

    [self.view addSubview:self.text];

    //add a barButtonItem
    UIBarButtonItem *btnAdd                = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(btnAdd)];

    //add a left buttonItem to replace the default button

    UIBarButtonItem *leftbutton            = [[UIBarButtonItem alloc] initWithTitle:@"备忘录" style:UIBarButtonItemStylePlain target:self action:@selector(btnCancle)];
    self.navigationItem.leftBarButtonItem  = leftbutton;
    self.navigationItem.rightBarButtonItem = btnAdd;
}

- (void)btnAdd
{
    dealWithNote *note                     = [dealWithNote sharedManager];
    Note *new                              = [[Note alloc] init];
    new.content                            = self.text.text;
    [note add:new];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)btnCancle
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addIt:(UITextField *)sender
{
    dealWithNote *note                     = [dealWithNote sharedManager];
    Note *newnote                          = [[Note alloc]init];
    newnote.content                        = self.text.text;
    [note add:newnote];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
