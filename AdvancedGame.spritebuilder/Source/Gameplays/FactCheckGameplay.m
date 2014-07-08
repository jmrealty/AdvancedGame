//
//  FactCheckGameplay.m
//  AdvancedGame
//
//  Created by Benjamin Encz on 07/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "FactCheckGameplay.h"

@implementation FactCheckGameplay {
    CCLabelTTF *_factLabel;
    CCLabelTTF *_answerLabel;
    NSArray *_statements;
    
    NSString *_selectedStatement;
    BOOL _selectedStatementTruth;
}

- (void)didLoadFromCCB {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Statements" ofType:@"plist"];
    _statements = [NSArray arrayWithContentsOfFile:path];
    
    [self chooseStatement];
}

#pragma mark - Number Chooser Delegate

- (void)numberChooser:(NumberChooser *)numberChooser guessedCorrectly:(BOOL)guess {
    [self.animationManager runAnimationsForSequenceNamed:@"ShowAnswer"];

    _answerLabel.string = guess ? @"TRUE" : @"FALSE";
    
    if (guess == _selectedStatementTruth) {
        _factLabel.string = @"You got this right!";
    } else {
        _factLabel.string = @"No! This is wrong";
    }
    
    [self.animationManager setCompletedAnimationCallbackBlock:^(id sender) {
        [self chooseStatement];
    }];
}

#pragma mark - Statement Choosing

- (void)chooseStatement {
    NSInteger entries = [_statements count];
    NSInteger randonNumber = arc4random_uniform(entries);
    
    _selectedStatement= _statements[randonNumber][@"Statement"];
    _selectedStatementTruth = [_statements[randonNumber][@"True"] boolValue];
    
    _factLabel.string = _selectedStatement;
}

@end
