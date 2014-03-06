//
//  RootViewController.h
//  noteWithSqlite
//
//  Created by Yang on 14-3-3.
//  Copyright (c) 2014年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"

#import "Note.h"
#import "dealWithNote.h"


@interface RootViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong) dealWithNote *note;

@end
