//
//  HVDTokenField.m
//  HVDTokenFieldDemo
//
//  Created by Harshad on 02/05/13.
//

#import "HVDTokenInputView.h"
#import <QuartzCore/QuartzCore.h>

@interface HVDTokenInputView() <UITextFieldDelegate>

- (void)textEditingChanged:(UITextField *)aTextField;
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer;
- (void)textFieldDidEndOnExit:(UITextField *)aTextField;
- (UILabel *)tokenLabelWithtoken:(NSString *)token;
- (void)addTokenLabelFromTextField:(UITextField *)aTextField;
- (void)addTokenLabelsFortokens:(NSArray *)tokens;

@property (weak, nonatomic) UITextField *activeTextField;
@property (strong, nonatomic) NSMutableArray *tokenLabels;
@property (strong, nonatomic) NSArray *existingtokens;
@property (nonatomic, getter = isParsingInput) BOOL parsingInput;

@end

@implementation HVDTokenInputView

- (instancetype)initWithFrame:(CGRect)frame tokens:(NSArray *)tokens editable:(BOOL)isEditable {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self setClipsToBounds:YES];
        
        UITextField *aTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 7, self.bounds.size.width - 5, 30)];
        [aTextField setDelegate:self];
        [self addSubview:aTextField];
        [aTextField setFont:[UIFont systemFontOfSize:15.0f]];
        [aTextField setReturnKeyType:UIReturnKeyDone];
        [self setActiveTextField:aTextField];
        [aTextField addTarget:self action:@selector(textEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [aTextField addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [aTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [aTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [aTextField setUserInteractionEnabled:isEditable];
        [aTextField setAccessibilityLabel:@"Token Input View Text Field"];
        
        [self setTokenLabels:[@[] mutableCopy]];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:gestureRecognizer];
        
        [self setExistingtokens:tokens];

        [self setMaximumTokens:4];

        [self addTokenLabelsFortokens:self.existingtokens];

    }
    
    return self;

}

#pragma mark - Public methods

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    [self addTokenLabelsFortokens:self.existingtokens];
}

- (NSArray *)tokens {
    NSMutableArray *anArray = [@[] mutableCopy];
    for (UILabel *aLabel in self.tokenLabels) {
        
        [anArray addObject:aLabel.text];
    }
    
    return anArray;
}

#pragma mark - Private methods

- (void)addTokenLabelsFortokens:(NSArray *)tokens {
    
    [self.tokenLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tokenLabels removeAllObjects];
    [self.activeTextField setFrame:CGRectMake(5, 7, self.bounds.size.width - 5, 30)];
    [self.activeTextField setText:@" "];
    
    for (NSString *atoken in tokens) {
        
        NSString *trimmedtoken = [atoken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \","]];
        if (trimmedtoken.length > 0) {
            UILabel *tokenLabel = [self tokenLabelWithtoken:trimmedtoken];
            
            CGRect tokenTargetFrame = CGRectMake(self.activeTextField.frame.origin.x, self.activeTextField.frame.origin.y, tokenLabel.frame.size.width + 5, tokenLabel.frame.size.height);
            
            if (tokenTargetFrame.origin.x + tokenTargetFrame.size.width > self.bounds.size.width) {
                if (tokenTargetFrame.origin.x == 5) {
                    tokenTargetFrame = CGRectMake(5, tokenTargetFrame.origin.y, tokenTargetFrame.size.width - 5, tokenTargetFrame.size.height);
                } else if (tokenTargetFrame.size.width <= self.bounds.size.width - 5) {
                    tokenTargetFrame = CGRectMake(5, tokenTargetFrame.origin.y + tokenTargetFrame.size.height + 5, tokenTargetFrame.size.width, tokenTargetFrame.size.height);
                } else {
                    tokenTargetFrame = CGRectMake(5, tokenTargetFrame.origin.y + tokenTargetFrame.size.height + 5, self.bounds.size.width - 5, tokenTargetFrame.size.height);
                }
            }
            
            if ((tokenTargetFrame.origin.y + tokenTargetFrame.size.height + 5) > self.bounds.size.height) {
                [self.activeTextField setText:@" "];
                return;
            }
            
            [tokenLabel setFrame:tokenTargetFrame];
            [self addSubview:tokenLabel];
            
            [self.tokenLabels addObject:tokenLabel];
            
            [self.activeTextField setText:@" "];
            
            if (self.bounds.size.width - tokenTargetFrame.origin.x - tokenTargetFrame.size.width <= 20) {
                [self.activeTextField setFrame:CGRectMake(5, tokenLabel.frame.origin.y + 5 + tokenTargetFrame.size.height, self.bounds.size.width - 5, 20)];
            } else {
                [self.activeTextField setFrame:CGRectMake(tokenLabel.frame.origin.x + tokenLabel.frame.size.width + 5, tokenLabel.frame.origin.y, self.bounds.size.width - tokenLabel.frame.origin.x - tokenLabel.frame.size.width - 5, 20)];
            }
   
        }
    }
}

- (UILabel *)tokenLabelWithtoken:(NSString *)token {

    UILabel *tokenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [tokenLabel setBackgroundColor:[UIColor colorWithRed:0.00f green:0.59f blue:1.00f alpha:0.20f]];
    [tokenLabel setTextColor:[UIColor colorWithRed:0.26f green:0.26f blue:0.26f alpha:1.00f]];
    [tokenLabel setFont:self.activeTextField.font];
    [tokenLabel setText:token];
    [tokenLabel sizeToFit];
    [tokenLabel.layer setCornerRadius:tokenLabel.bounds.size.height/ 2.5];
    [tokenLabel.layer setBorderColor:[UIColor colorWithRed:0.00f green:0.59f blue:1.00f alpha:0.90f].CGColor];
    [tokenLabel.layer setBorderWidth:1.0f];
    [tokenLabel setTextAlignment:NSTextAlignmentCenter];
    [tokenLabel setAccessibilityLabel:[NSString stringWithFormat:@"Token Input View Label %@", token]];
    
    return tokenLabel;
}

- (void)addTokenLabelFromTextField:(UITextField *)aTextField {
    [self setParsingInput:YES];
    NSString *token = [aTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \","]];
    
    if (token.length > 0) {
        BOOL tokenIsDuplicate = NO;
        
        for (UILabel *aLabel in self.tokenLabels) {
            if ([aLabel.text caseInsensitiveCompare:token] == NSOrderedSame) {
                tokenIsDuplicate = YES;
                break;
            }
        }
        
        if (!tokenIsDuplicate && self.tokenLabels.count < self.maximumTokens) {
            UILabel *tokenLabel;
            
            tokenLabel = [self tokenLabelWithtoken:token];
            
            CGRect tokenTargetFrame = CGRectMake(aTextField.frame.origin.x, aTextField.frame.origin.y, tokenLabel.frame.size.width + 5, tokenLabel.frame.size.height);
            
            if (tokenTargetFrame.origin.x + tokenTargetFrame.size.width > self.bounds.size.width) {
                if (tokenTargetFrame.origin.x == 5) {
                    tokenTargetFrame = CGRectMake(5, tokenTargetFrame.origin.y, tokenTargetFrame.size.width - 5, tokenTargetFrame.size.height);
                } else if (tokenTargetFrame.size.width <= self.bounds.size.width - 5) {
                    tokenTargetFrame = CGRectMake(5, tokenTargetFrame.origin.y + tokenTargetFrame.size.height + 5, tokenTargetFrame.size.width, tokenTargetFrame.size.height);
                } else {
                    tokenTargetFrame = CGRectMake(5, tokenTargetFrame.origin.y + tokenTargetFrame.size.height + 5, self.bounds.size.width - 5, tokenTargetFrame.size.height);
                }
            }
            
            if ((tokenTargetFrame.origin.y + tokenTargetFrame.size.height + 5) > self.bounds.size.height) {
                [aTextField setText:@" "];
                [self setParsingInput:NO];
                return;
            }
            
            [tokenLabel setFrame:tokenTargetFrame];
            [self addSubview:tokenLabel];
            
            [self.tokenLabels addObject:tokenLabel];
            
            [aTextField setText:@" "];
            
            if (self.bounds.size.width - tokenTargetFrame.origin.x - tokenTargetFrame.size.width <= 20) {
                [aTextField setFrame:CGRectMake(5, tokenLabel.frame.origin.y + 5 + tokenTargetFrame.size.height, self.bounds.size.width - 5, 20)];
            } else {
                [aTextField setFrame:CGRectMake(tokenLabel.frame.origin.x + tokenLabel.frame.size.width + 5, tokenLabel.frame.origin.y, self.bounds.size.width - tokenLabel.frame.origin.x - tokenLabel.frame.size.width - 5, 20)];
            }
            
        } else {
            
            [aTextField setText:@" "];
            
            if (self.tokenLabels.count >= self.maximumTokens) {

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Maximum %d tokens allowed", self.maximumTokens] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        
    } else {
        [aTextField setText:@" "];
    }
    
    [self setParsingInput:NO];
}

#pragma mark - Actions

- (void)textEditingChanged:(UITextField *)aTextField {
    
    if ([self isParsingInput]) {
        return;
    }
    if (([aTextField.text rangeOfString:@" "].location != NSNotFound || [aTextField.text rangeOfString:@","].location != NSNotFound) && ([aTextField.text characterAtIndex:(aTextField.text.length - 1)] == ' ' || [aTextField.text characterAtIndex:(aTextField.text.length - 1)] == ',')) {
        
        if (aTextField.text.length >= 2 && [aTextField.text characterAtIndex:1] == '"') {
            if (!(aTextField.text.length >= 3 && [aTextField.text characterAtIndex:aTextField.text.length - 2] == '"') && [aTextField.text rangeOfString:@","].location == NSNotFound) {
                return;
            }
        }
        

        [self addTokenLabelFromTextField:aTextField];
    
    } else if (aTextField.text.length == 0) {
        
        if (self.tokenLabels.count > 0) {
            
            UILabel *tokenLabel = [self.tokenLabels lastObject];
            
            [aTextField setFrame:CGRectMake(tokenLabel.frame.origin.x, tokenLabel.frame.origin.y, self.bounds.size.width - tokenLabel.frame.origin.x - tokenLabel.frame.size.width, 20)];
            [tokenLabel removeFromSuperview];
            [self.tokenLabels removeObject:tokenLabel];
            
        }
        
        [aTextField setText:@" "];
        
    } else if (aTextField.text.length > 0 && [aTextField.text characterAtIndex:0] != ' ') {
        
        [aTextField setText:[NSString stringWithFormat:@" %@", aTextField.text]];
    }
               
}

- (void)textFieldDidEndOnExit:(UITextField *)aTextField {
    
    [aTextField resignFirstResponder];
    
    [self addTokenLabelFromTextField:aTextField];
    
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    
    [self.activeTextField becomeFirstResponder];
}


@end
