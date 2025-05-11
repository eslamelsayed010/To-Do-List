//
//  DoneViewController.h
//  To-Do List
//
//  Created by Macos on 24/04/2025.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>
@property NSMutableArray *filteredList;

@end

NS_ASSUME_NONNULL_END
