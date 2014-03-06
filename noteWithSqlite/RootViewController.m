//
//  RootViewController.m
//  noteWithSqlite
//
//  Created by Yang on 14-3-3.
//  Copyright (c) 2014年 Yang. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()

@end

@implementation RootViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //set the title of navigationItem
    
    self.navigationItem.title = @"备忘录";
    
    //add a leftbarbuttonItem
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //init the tableview
   self.note = [dealWithNote sharedManager];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(10, 30,300 , [UIScreen mainScreen].bounds.size.height)];
    [self.tableview setDataSource: self];
    [self.tableview setDelegate:self];
    [self.view addSubview:self.tableview];
    
    // add a right buttonItem to join the Edit model
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(editModel)];
    self.navigationItem.leftBarButtonItem = barItem;
    
    //设置隐藏tableview的滚动条
    
    self.tableview.showsVerticalScrollIndicator = NO;
    
    //设置分割栏样式
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

}
- (void)editModel
{
    if (self.tableview.editing == NO) {
    
        [self.tableview setEditing:YES animated:YES];
    }else{
        [self.tableview setEditing:NO animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableview reloadData];
}

- (void)btnClicked
{
    AddViewController *avc = [[AddViewController alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//add a action for click the cell

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddViewController *avc = [[AddViewController alloc] init];
    UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    avc.message = cell.textLabel.text;
    
    [self.navigationController pushViewController:avc animated:YES];

}

#pragma mark- implement the protocal



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.note show];
    
    return [self.note.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifer];
    }
    NSInteger row = [indexPath row];
    Note *out  = [self.note.show objectAtIndex:row];
    cell.textLabel.text = (NSString *)out.content;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",out.iid];
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//    
//}
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (! self.tableview.editing) {
        return UITableViewCellEditingStyleNone;
    }else {
            return UITableViewCellEditingStyleDelete;
        }

}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Note *mynote = [[Note alloc] init];
    NSLog(@"string");
    UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    mynote.iid = (NSNumber *)cell.detailTextLabel.text;
    NSLog(@"%@",mynote.iid);
    mynote.content = cell.textLabel.text;
    [self.note deleteNote:mynote];
    [self.tableview reloadData];
   
}


@end

