//
//  AddViewController.h
//  noteWithSqlite
//
//  Created by Yang on 14-3-3.
//  Copyright (c) 2014年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "dealWithNote.h"

@interface AddViewController : UIViewController

@property(nonatomic,strong) UITextView *text;
@property(nonatomic,strong) NSString *message;
@property(nonatomic,strong) Note *note;
@end
