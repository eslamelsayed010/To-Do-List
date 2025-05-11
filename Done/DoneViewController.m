//
//  DoneViewController.m
//  To-Do List
//
//  Created by Macos on 24/04/2025.
//

#import "DoneViewController.h"
#import "TextFieldStyle.h"

@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTFF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
- (IBAction)priorityBtn:(id)sender;

@property NSMutableArray *arr;

@end

@implementation DoneViewController{
    NSUserDefaults *defaults;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    defaults = [NSUserDefaults standardUserDefaults];
    self.arr = [[defaults objectForKey:@"tasks2"] mutableCopy];
    if (!self.arr) {
        self.arr = [[NSMutableArray alloc] init];
    }
    self.filteredList = [self.arr mutableCopy];
    
    if (!self.filteredList) {
        self.filteredList = [NSMutableArray new];
    }
    
    [self.filteredList removeAllObjects];
    
    NSString *currentSearchText = self.searchTFF.text;
    BOOL hasSearchText = currentSearchText.length > 0;
    
    switch (self.priority.selectedSegmentIndex) {
        case 0:
            for (NSDictionary *task in self.arr) {
                if ([task[@"condition"] intValue] == 2) {
                    [self.filteredList addObject:task];
                }
            }
            break;
        case 1:
            for (NSDictionary *task in self.arr ) {
                if ([task[@"priority"] intValue] == 0 && [task[@"condition"] intValue] == 2) {
                    [self.filteredList addObject:task];
                }
            }
            NSLog(@"%@", self.filteredList);
            break;
            
        case 2:
            for (NSDictionary *task in self.arr) {
                if ([task[@"priority"] intValue] == 1 && [task[@"condition"] intValue] == 2) {
                    [self.filteredList addObject:task];
                }
            }
            NSLog(@"%@", self.filteredList);
            break;
            
        case 3:
            for (NSDictionary *task in self.arr) {
                if ([task[@"priority"] intValue] == 2 && [task[@"condition"] intValue] == 2) {
                    [self.filteredList addObject:task];
                }
            }
            NSLog(@"%@", self.filteredList);
            break;
        default:
            break;
    }
    
    [self.customTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TextFieldStyle new] styleTextField:self.searchTFF withPlaceholder:@"Search.."];
    [_searchTFF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField.text.length > 0) {
        [self filterTasksWithSearchText:textField.text];
    } else {
        [self priorityBtn:self.priority];
    }
}

- (void)filterTasksWithSearchText:(NSString *)searchText {
    if (!self.filteredList) {
        self.filteredList = [NSMutableArray new];
    }
    
    [self.filteredList removeAllObjects];
    
    NSArray *baseArray = self.arr;
    
    NSString *searchTextLower = [searchText lowercaseString];
    
    for (NSDictionary *task in baseArray) {
        NSString *title = [task[@"title"] lowercaseString];
        if ([title containsString:searchTextLower]) {
            [self.filteredList addObject:task];
        }
    }
    
    [self.customTableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; // Hide keyboard when return is pressed
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self priorityBtn:self.priority];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //if (self.filteredList && self.filteredList.count > 0) {
    return self.filteredList.count;
    //}
    //return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    //NSArray *dataSource = (self.filteredList && self.filteredList.count > 0) ? self.filteredList : self.arr;
    NSArray *dataSource = self.filteredList;
    
    if ([dataSource[indexPath.row][@"condition"] intValue] == 2) {
        
        cell.textLabel.text = dataSource[indexPath.row][@"title"];
        cell.detailTextLabel.text = dataSource[indexPath.row][@"date"];
        
        UIImage *image = [UIImage new];
        
        switch ([dataSource[indexPath.row][@"priority"] intValue]) {
            case 0:
                image = [UIImage imageNamed:@"red"];
                break;
            case 1:
                image = [UIImage imageNamed:@"yellow"];
                break;
            case 2:
                image = [UIImage imageNamed:@"green"];
                break;
                
            default:
                image = [UIImage imageNamed:@"green"];
                break;
        }
        
        UIImage *resizedImage = [self resizeImage:image toSize:CGSizeMake(30, 30)];
        cell.imageView.image = resizedImage;
        
        cell.imageView.layer.cornerRadius = 20;
        cell.imageView.layer.masksToBounds = YES;
        
        UIView *spacer = [[UIView alloc] initWithFrame:CGRectMake(0, 49, tableView.frame.size.width, 1)];
        spacer.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:spacer];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

- (IBAction)priorityBtn:(id)sender {
    if (!self.filteredList) {
        self.filteredList = [NSMutableArray new];
    }
    
    [self.filteredList removeAllObjects];
    
    NSString *currentSearchText = self.searchTFF.text;
    BOOL hasSearchText = currentSearchText.length > 0;
    
    switch (self.priority.selectedSegmentIndex) {
        case 0:
            for (NSDictionary *task in self.arr) {
                if ( [task[@"condition"] intValue] == 2) {
                    [self.filteredList addObject:task];
                }
            }
            break;
            
        case 1:
            for (NSDictionary *task in self.arr) {
                if ([task[@"priority"] intValue] == 0 && [task[@"condition"] intValue] == 2) {
                    [self.filteredList addObject:task];
                }
            }
            break;
        case 2:
            for (NSDictionary *task in self.arr) {
                if ([task[@"priority"] intValue] == 1 && [task[@"condition"] intValue] == 2) {
                    [self.filteredList addObject:task];
                }
            }
            break;
            
        case 3:
            for (NSDictionary *task in self.arr) {
                if ([task[@"priority"] intValue] == 2 && [task[@"condition"] intValue] == 2) {
                    [self.filteredList addObject:task];
                }
            }
            break;
        default:
            break;
    }
    
    // If there's search text, filter the results further
    if (hasSearchText) {
        NSMutableArray *searchFiltered = [NSMutableArray new];
        NSString *searchTextLower = [currentSearchText lowercaseString];
        
        for (NSDictionary *task in self.filteredList) {
            NSString *title = [task[@"title"] lowercaseString];
            if ([title containsString:searchTextLower]) {
                [searchFiltered addObject:task];
            }
        }
        
        self.filteredList = searchFiltered;
    }
    
    [self.customTableView reloadData];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete"
                                                                                 message:@"Are you sure you want to delete this item?"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Submit"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * _Nonnull action) {
            BOOL usingFilteredList = (self.filteredList && self.filteredList.count > 0);
            
            NSDictionary *taskToDelete;
            if (usingFilteredList) {
                taskToDelete = self.filteredList[indexPath.row];
                [self.filteredList removeObjectAtIndex:indexPath.row];
            } else {
                taskToDelete = self.arr[indexPath.row];
                [self.arr removeObjectAtIndex:indexPath.row];
            }
            
            
            if (usingFilteredList) {
                NSInteger mainArrayIndex = [self.arr indexOfObjectIdenticalTo:taskToDelete];
                if (mainArrayIndex != NSNotFound) {
                    [self.arr removeObjectAtIndex:mainArrayIndex];
                }
            }
            
            
            [defaults setObject:self.arr forKey:@"tasks2"];
            [defaults synchronize];
            
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
@end
