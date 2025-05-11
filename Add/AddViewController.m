//
//  AddViewController.m
//  To-Do List
//
//  Created by Macos on 23/04/2025.
//

#import "AddViewController.h"
#import "TextFieldStyle.h"

@interface AddViewController ()
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *labelTFF;
@property (weak, nonatomic) IBOutlet UITextField *descTFF;
- (IBAction)saveBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[TextFieldStyle new] styleTextField:self.labelTFF withPlaceholder:@"Enter title"];
    [[TextFieldStyle new] styleTextField:self.descTFF withPlaceholder:@"Enter description"];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.97 alpha:1.0];
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveBtn:(id)sender {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setObject:self.labelTFF.text forKey:@"title"];
    [dict setObject:self.descTFF.text forKey:@"disc"];
    [dict setObject:@(self.priority.selectedSegmentIndex) forKey:@"priority"];
    [dict setObject:[self getFormattedData] forKey:@"date"];
    [dict setObject:@"0" forKey:@"condition"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *arr = [[defaults objectForKey:@"tasks2"] mutableCopy];
    if (arr == nil) {
        arr = [NSMutableArray new];
    }
    
    [arr addObject:dict];
    
    [defaults setObject:arr forKey:@"tasks2"];
    [defaults synchronize];

    NSLog(@"%@", dict);
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString*) getFormattedData{
    NSDate *selectedDate = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *formattedDate = [formatter stringFromDate:selectedDate];
    return formattedDate;
}

@end
