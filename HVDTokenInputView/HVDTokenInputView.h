//
//  HVDTokenField.h
//  HVDTokenFieldDemo
//
//  Created by Bobcat on 02/05/13.
//

#import <UIKit/UIKit.h>

@interface HVDTokenInputView : UIView

- (instancetype)initWithFrame:(CGRect)frame tokens:(NSArray *)tokens editable:(BOOL)isEditable;

@property (nonatomic) NSUInteger maximumTokens;

- (NSArray *)tokens;

@end
