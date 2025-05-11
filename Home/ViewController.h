//
//  ViewController.h
//  To-Do List
//
//  Created by Macos on 23/04/2025.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>
@property NSMutableArray *filteredList;

@end

