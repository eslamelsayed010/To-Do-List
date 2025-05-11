//
//  TextFieldStyle.m
//  To-Do List
//
//  Created by Macos on 26/04/2025.
//

#import "TextFieldStyle.h"

@interface TextFieldStyle ()

@end

@implementation TextFieldStyle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)styleTextField:(UITextField *)textField withPlaceholder:(NSString *)placeholder {
    textField.borderStyle = UITextBorderStyleNone;
    
    textField.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
    textField.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    
    UIColor *placeholderColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    NSDictionary *placeholderAttributes = @{
        NSForegroundColorAttributeName: placeholderColor,
        NSFontAttributeName: [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular]
    };
    
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:placeholderAttributes];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, textField.frame.size.height)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.layer.cornerRadius = 12.0;
    textField.layer.masksToBounds = NO;
    
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.layer.shadowColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.8 alpha:0.5].CGColor;
    textField.layer.shadowOffset = CGSizeMake(0, 2);
    textField.layer.shadowOpacity = 0.5;
    textField.layer.shadowRadius = 3.0;
    
    textField.layer.borderWidth = 1.0;
    textField.layer.borderColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardAppearance = UIKeyboardAppearanceLight;
    
    [textField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    
    [textField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        textField.layer.borderColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:0.8].CGColor;
        textField.layer.borderWidth = 1.5;
        textField.backgroundColor = [UIColor colorWithRed:0.95 green:0.98 blue:1.0 alpha:1.0];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        textField.layer.borderColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
        textField.layer.borderWidth = 1.0;
        textField.backgroundColor = [UIColor whiteColor];
    }];
}

@end
