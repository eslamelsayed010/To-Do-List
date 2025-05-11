//
//  TextFieldStyle.h
//  To-Do List
//
//  Created by Macos on 26/04/2025.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFieldStyle : UIViewController
- (void)styleTextField:(UITextField *)textField withPlaceholder:(NSString *)placeholder;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END
