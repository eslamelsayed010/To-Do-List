//
//  EditViewController.m
//  To-Do List
//
//  Created by Macos on 23/04/2025.
//

#import "EditViewController.h"
#import "TextFieldStyle.h"

@interface EditViewController ()
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *titleTFF;
@property (weak, nonatomic) IBOutlet UITextField *descTFF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *condition;
- (IBAction)doneBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;

@end

@implementation EditViewController

- (void)viewWillAppear:(BOOL)animated{
    self.titleTFF.text = self.dict[@"title"];
    self.descTFF.text = self.dict[@"disc"];
    self.date.text = self.dict[@"date"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TextFieldStyle new] styleTextField:self.titleTFF withPlaceholder:@"Enter title"];
    [[TextFieldStyle new] styleTextField:self.descTFF withPlaceholder:@"Enter description"];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.97 alpha:1.0];
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)doneBtn:(id)sender {
    NSMutableDictionary *updatedDict = [NSMutableDictionary dictionaryWithDictionary:self.dict];
    
    [updatedDict setObject:self.titleTFF.text forKey:@"title"];
    [updatedDict setObject:self.descTFF.text forKey:@"disc"];
    [updatedDict setObject:@(self.condition.selectedSegmentIndex) forKey:@"condition"];
    [updatedDict setObject:@(self.priority.selectedSegmentIndex) forKey:@"priority"];
    // [updatedDict setObject:[self getFormattedData] forKey:@"date"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tasksArray = [[defaults objectForKey:@"tasks2"] mutableCopy];
    
    if (tasksArray != nil) {
        if (self.index < [tasksArray count]) {
            [tasksArray replaceObjectAtIndex:self.index withObject:updatedDict];
            
            [defaults setObject:tasksArray forKey:@"tasks2"];
            [defaults synchronize];
            
            NSLog(@"Task updated: %@", updatedDict);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
