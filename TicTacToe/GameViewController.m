//
//  ViewController.m
//  TicTacToe
//
//  Created by Andrew  Nguyen on 7/16/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UILabel *labelNine;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property BOOL nextPlayer;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property int count;
@property NSTimer *t;
@property (weak, nonatomic) IBOutlet UILabel *xoLabel;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //initialize game
    self.count = 10;
    self.timerLabel.text = @"10";
    self.nextPlayer = YES;
    self.whichPlayerLabel.text = @"X";
    self.whichPlayerLabel.textColor = [UIColor blueColor];
    self.whichPlayerLabel.textAlignment = NSTextAlignmentCenter;

    NSArray *labels = @[self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine];
    for (UILabel *label in labels) {
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.layer.borderWidth = 3.0;
        label.text = @"";
    }

    self.t = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(decrementTimer) userInfo:nil repeats:YES];
    //[[NSRunLoop mainRunLoop] addTimer:self.t forMode:NSRunLoopCommonModes];

}

#pragma mark - Timer Methods
-(void)decrementTimer {
    self.count--;
    if (self.count < 0) {
        self.timerLabel.text = @"0";
    }
    else {
        self.timerLabel.text = [NSString stringWithFormat:@"%i", self.count];
        if (self.count == 0) {
            [self.t invalidate];
            self.t = nil;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Out of time!" message:@"You have run out of time." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.count = 10;
                self.timerLabel.text = @"10";
                [self computerTurn];
            }];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
                [self restartTimer];
            }];
        }
    }
}

-(void)restartTimer {
    self.t = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(decrementTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.t forMode:NSRunLoopCommonModes];
}


#pragma mark - Helper Methods
- (IBAction)onHelpButtonTapped:(UIButton *)sender {
    [self.t invalidate];
    self.t = nil;
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue
{
    self.t = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(decrementTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.t forMode:NSRunLoopCommonModes];

}


-(UILabel *)findLabelUsingPoint:(CGPoint)point {
    if (CGRectContainsPoint(self.labelOne.frame, point)) {
        return self.labelOne;
    }
    else if (CGRectContainsPoint(self.labelTwo.frame, point)) {
        return self.labelTwo;
    }
    else if (CGRectContainsPoint(self.labelThree.frame, point)) {
        return self.labelThree;
    }
    else if (CGRectContainsPoint(self.labelFour.frame, point)) {
        return self.labelFour;
    }
    else if (CGRectContainsPoint(self.labelFive.frame, point)) {
        return self.labelFive;
    }
    else if (CGRectContainsPoint(self.labelSix.frame, point)) {
        return self.labelSix;
    }
    else if (CGRectContainsPoint(self.labelSeven.frame, point)) {
        return self.labelSeven;
    }
    else if (CGRectContainsPoint(self.labelEight.frame, point)) {
        return self.labelEight;
    }
    else if (CGRectContainsPoint(self.labelNine.frame, point)) {
        return self.labelNine;
    }
    else {
    return nil;
    }
}


-(NSString*)whoWon {
    if ([self.labelOne.text  isEqual: @"X"] &&
        [self.labelTwo.text  isEqual: @"X"] &&
        [self.labelThree.text  isEqual: @"X"]) {
        return @"X";
    }
    else if ([self.labelOne.text  isEqual: @"O"] &&
             [self.labelTwo.text  isEqual: @"O"] &&
             [self.labelThree.text  isEqual: @"O"]) {
        return @"O";
    }
    else if ([self.labelFour.text  isEqual: @"X"] &&
             [self.labelFive.text  isEqual: @"X"] &&
             [self.labelSix.text  isEqual: @"X"]) {
        return @"X";
    }
    else if ([self.labelFour.text  isEqual: @"O"] &&
             [self.labelFive.text  isEqual: @"O"] &&
             [self.labelSix.text  isEqual: @"O"]) {
        return @"O";
    }
    else if ([self.labelSeven.text  isEqual: @"X"] &&
             [self.labelEight.text  isEqual: @"X"] &&
             [self.labelNine.text  isEqual: @"X"]) {
        return @"X";
    }
    else if ([self.labelSeven.text  isEqual: @"O"] &&
             [self.labelEight.text  isEqual: @"O"] &&
             [self.labelNine.text  isEqual: @"O"]) {
        return @"O";
    }
    else if ([self.labelOne.text  isEqual: @"X"] &&
             [self.labelFour.text  isEqual: @"X"] &&
             [self.labelSeven.text  isEqual: @"X"]) {
        return @"X";
    }
    else if ([self.labelOne.text  isEqual: @"O"] &&
             [self.labelFour.text  isEqual: @"O"] &&
             [self.labelSeven.text  isEqual: @"O"]) {
        return @"O";
    }
    else if ([self.labelTwo.text  isEqual: @"X"] &&
             [self.labelFive.text  isEqual: @"X"] &&
             [self.labelEight.text  isEqual: @"X"]) {
        return @"X";
    }
    else if ([self.labelTwo.text  isEqual: @"O"] &&
             [self.labelFive.text  isEqual: @"O"] &&
             [self.labelEight.text  isEqual: @"O"]) {
        return @"O";
    }
    else if ([self.labelThree.text  isEqual: @"X"] &&
             [self.labelSix.text  isEqual: @"X"] &&
             [self.labelNine.text  isEqual: @"X"]) {
        return @"X";
    }
    else if ([self.labelThree.text  isEqual: @"O"] &&
             [self.labelSix.text  isEqual: @"O"] &&
             [self.labelNine.text  isEqual: @"O"]) {
        return @"O";
    }
    else if ([self.labelOne.text  isEqual: @"X"] &&
             [self.labelFive.text  isEqual: @"X"] &&
             [self.labelNine.text  isEqual: @"X"]) {
        return @"X";
    }
    else if ([self.labelOne.text  isEqual: @"O"] &&
             [self.labelFive.text  isEqual: @"O"] &&
             [self.labelNine.text  isEqual: @"O"]) {
        return @"O";
    }
    else if ([self.labelThree.text  isEqual: @"X"] &&
             [self.labelFive.text  isEqual: @"X"] &&
             [self.labelSeven.text  isEqual: @"X"]) {
        return @"X";
    }
    else if ([self.labelThree.text  isEqual: @"O"] &&
             [self.labelFive.text  isEqual: @"O"] &&
             [self.labelSeven.text  isEqual: @"O"]) {
        return @"O";
    }
    else if (self.labelOne.text.length != 0  &&
             self.labelTwo.text.length != 0 &&
             self.labelThree.text.length != 0 &&
             self.labelFour.text.length != 0 &&
             self.labelFive.text.length != 0 &&
             self.labelSix.text.length != 0 &&
             self.labelSeven.text.length != 0 &&
             self.labelEight.text.length != 0 &&
             self.labelNine.text.length != 0) {
            return @"Tie";
    }
    else {
        return nil;
    }
}

#pragma mark - GestureRecognizer Methods
- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.view];
    UILabel *label = [self findLabelUsingPoint:point];
    if (label) {
        if (self.nextPlayer) {
            label.text = @"X";
            label.textColor = [UIColor blueColor];
            label.textAlignment = NSTextAlignmentCenter;
            self.nextPlayer = NO;
//            self.whichPlayerLabel.text = @"O";
//            self.whichPlayerLabel.textColor = [UIColor redColor];
            NSString *winner = [self whoWon];
            NSString *message;
            if (winner) {
                if ([winner isEqualToString:@"Tie"]) {
                    message = @"Tie";
                }
                else {
                    message = [NSString stringWithFormat:@"%@ Won", winner];
                }
                [self.t invalidate];
                self.t = nil;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *restartAction = [UIAlertAction actionWithTitle:@"Start A New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self viewDidLoad];
                }];
                [alert addAction:restartAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            if (![winner isEqualToString:@"Tie"]) {
                [self computerTurn];
            }
        }



        else {
            label.text = @"O";
            label.textColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            self.nextPlayer = YES;
            self.whichPlayerLabel.text = @"X";
            self.whichPlayerLabel.textColor = [UIColor blueColor];
            NSString *winner = [self whoWon];
            NSString *message;
            if (winner) {
                if ([winner isEqualToString:@"Tie"]) {
                    message = @"Tie";
                }
                else {
                    message = [NSString stringWithFormat:@"%@ Won", winner];
                }
                [self.t invalidate];
                self.t = nil;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *restartAction = [UIAlertAction actionWithTitle:@"Start A New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self viewDidLoad];
                }];
                [alert addAction:restartAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        self.count = 10;
        self.timerLabel.text = @"10";
    }
}

- (IBAction)onLabelDragged:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    sender.view.center = CGPointMake(sender.view.center.x + translation.x,
                                         sender.view.center.y + translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];

}

-(void)computerTurn {
    BOOL won = [self canWin];

    if(!won) {
        [self checkBlock];
        if (self.labelFive.text.length == 0) {
            [self computerFive];
        }
        else if ([self.labelFive.text isEqualToString:@"O"] && self.labelOne.text.length == 0) {
            if ([self.labelSix.text isEqualToString:@"X"]) {
                [self computerNine];
            }
            else {
                if (self.labelNine.text.length == 0) {
                    [self computerOne];
                }
            }
        }
        else if ([self.labelFive.text isEqualToString:@"X"]) {
            [self computerOne];
            if ([self.labelNine.text isEqualToString:@"X"]) {
                [self computerThree];
            }
        }
        else if ([self.labelFour.text isEqualToString:@"X"] && [self.labelSix.text isEqualToString:@"X"]) {
            if (![self.labelEight.text isEqualToString:@"O"]) {
                if (![self.labelSeven.text isEqualToString:@"O"]) {
                    [self computerTwo];
                }
            }
        }
        else if ([self.labelFour.text isEqualToString:@"X"] && [self.labelTwo.text isEqualToString:@"X"]) {
            [self computerOne];
            if ([self.labelNine.text isEqualToString:@"X"]) {
                [self computerEight];
                if ([self.labelSeven.text isEqualToString:@"X"]) {
                    if (!self.labelSix.text.length == 0) {
                        [self computerThree];
                    }
                }
            }
        }
        else if ([self.labelFour.text isEqualToString:@"X"] && [self.labelEight.text isEqualToString:@"X"] && self.labelOne.text.length == 0) {
            if (![self.labelNine.text isEqualToString:@"X"]) {
                [self computerOne];
            }
        }
        else if ([self.labelOne.text isEqualToString:@"X"]) {
            if ([self.labelTwo.text isEqualToString:@"O"]) {
                if (![self.labelThree.text isEqualToString:@"X"]) {
                    [self computerFour];
                }
                else if ([self.labelEight.text isEqualToString:@"X"]) {
                    [self computerSeven];
                    if ([self.labelFour.text isEqualToString:@"X"]) {
                        [self computerSix];
                    }
                }
            }
            else if ([self.labelSix.text isEqualToString:@"X"] || [self.labelNine.text isEqualToString:@"X"]) {
                if (![self.labelTwo.text isEqualToString:@"X"]) {
                    [self computerTwo];
                }
                else {
                    [self computerNine];
                }
            }
            else if ([self.labelEight.text isEqualToString:@"X"]) {
                if (![self.labelThree.text isEqualToString:@"X"]) {
                    [self computerFour];
                }
                else {
                    [self computerNine];
                }
            }
        }
        else if ([self.labelThree.text isEqualToString:@"X"]) {
            if ([self.labelFour.text isEqualToString:@"X"] || [self.labelSeven.text isEqualToString:@"X"]) {
                if (![self.labelOne.text isEqualToString:@"O"]) {
                    [self computerTwo];
                }
            }
            else if ([self.labelEight.text isEqualToString:@"X"]) {
                if (![self.labelSix.text isEqualToString:@"O"]) {
                    [self computerFour];
                }
            }
            else if ([self.labelTwo.text isEqualToString:@"X"]) {
                if (![self.labelOne.text isEqualToString:@"O"]) {
                    [self computerSeven];
                }
            }
        }
        else if ([self.labelEight.text isEqualToString:@"X"]) {
            if ([self.labelSix.text isEqualToString:@"X"] || [self.labelFour.text isEqualToString:@"X"]) {
                if (self.labelNine.text.length == 0) {
                    [self computerNine];
                }
            }
            else if ([self.labelTwo.text isEqualToString:@"X"]) {
                [self computerFour];
            }
        }
        else if ([self.labelTwo.text isEqualToString:@"X"]) {
            if ([self.labelSix.text isEqualToString:@"X"] || [self.labelFour.text isEqualToString:@"X"]) {
                if (![self.labelThree.text isEqualToString:@"O"]) {
                    [self computerOne];
                }
            }
            else if ([self.labelSeven.text isEqualToString:@"X"]) {
                [self computerFour];
            }
        }
        else if ([self.labelSeven.text isEqualToString:@"X"]) {
            if ([self.labelNine.text isEqualToString:@"X"]) {
                if (![self.labelEight.text isEqualToString:@"O"]) {
                    [self computerTwo];
                }
            }
        }
    }

    self.nextPlayer = YES;
}

-(BOOL)canWin {
    if ([self.labelOne.text isEqualToString:@"O"]) {
        if ([self.labelTwo.text isEqualToString:@"O"] && self.labelThree.text.length == 0) {
            [self computerThree];
            [self computerWin];
            return true;
        }
        else if ([self.labelThree.text isEqualToString:@"O"] && self.labelTwo.text.length == 0) {
            [self computerTwo];
            [self computerWin];
            return true;
        }
        else if ([self.labelFour.text isEqualToString:@"O"] && self.labelSeven.text.length == 0) {
            [self computerSeven];
            [self computerWin];
            return true;
        }
        else if ([self.labelSeven.text isEqualToString:@"O"] && self.labelFour.text.length == 0) {
            [self computerFour];
            [self computerWin];
            return true;
        }
        else if ([self.labelFive.text isEqualToString:@"O"] && self.labelNine.text.length == 0) {
            [self computerNine];
            [self computerWin];
            return true;
        }
        else if ([self.labelNine.text isEqualToString:@"O"] && self.labelFive.text.length == 0) {
            [self computerFive];
            [self computerWin];
            return true;
        }
    }
    if ([self.labelTwo.text isEqualToString:@"O"]) {
        if ([self.labelOne.text isEqualToString:@"O"] && self.labelThree.text.length == 0) {
            [self computerThree];
            [self computerWin];
            return true;
        }
        else if ([self.labelThree.text isEqualToString:@"O"] && self.labelOne.text.length == 0) {
            [self computerOne];
            [self computerWin];
            return true;
        }
        else if ([self.labelFive.text isEqualToString:@"O"] && self.labelEight.text.length == 0) {
            [self computerEight];
            [self computerWin];
            return true;
        }
        else if ([self.labelEight.text isEqualToString:@"O"] && self.labelFive.text.length == 0) {
            [self computerFive];
            [self computerWin];
            return true;
        }
    }
    if ([self.labelThree.text isEqualToString:@"O"]) {
        if ([self.labelOne.text isEqualToString:@"O"] && self.labelTwo.text.length == 0) {
            [self computerTwo];
            [self computerWin];
            return true;
        }
        else if ([self.labelTwo.text isEqualToString:@"O"] && self.labelOne.text.length == 0) {
            [self computerOne];
            [self computerWin];
            return true;
        }
        else if ([self.labelSix.text isEqualToString:@"O"] && self.labelNine.text.length == 0) {
            [self computerNine];
            [self computerWin];
            return true;
        }
        else if ([self.labelNine.text isEqualToString:@"O"] && self.labelSix.text.length == 0) {
            [self computerSix];
            [self computerWin];
            return true;
        }
        else if ([self.labelFive.text isEqualToString:@"O"] && self.labelSeven.text.length == 0) {
            [self computerSeven];
            [self computerWin];
            return true;
        }
        else if ([self.labelSeven.text isEqualToString:@"O"] && self.labelFive.text.length == 0) {
            [self computerFive];
            [self computerWin];
            return true;
        }
    }
    if ([self.labelFour.text isEqualToString:@"O"]) {
        if ([self.labelFive.text isEqualToString:@"O"] && self.labelSix.text.length == 0) {
            [self computerSix];
            [self computerWin];
            return true;
        }
        else if ([self.labelSix.text isEqualToString:@"O"] && self.labelFive.text.length == 0) {
            [self computerFive];
            [self computerWin];
            return true;
        }
        else if ([self.labelOne.text isEqualToString:@"O"] && self.labelSeven.text.length == 0) {
            [self computerSeven];
            [self computerWin];
            return true;
        }
        else if ([self.labelSeven.text isEqualToString:@"O"] && self.labelOne.text.length == 0) {
            [self computerOne];
            [self computerWin];
            return true;
        }
    }
    if ([self.labelFive.text isEqualToString:@"O"]) {
        if ([self.labelOne.text isEqualToString:@"O"] && self.labelNine.text.length == 0) {
            [self computerNine];
            [self computerWin];
            return true;
        }
        else if ([self.labelNine.text isEqualToString:@"O"] && self.labelOne.text.length == 0) {
            [self computerOne];
            [self computerWin];
            return true;
        }
        else if ([self.labelTwo.text isEqualToString:@"O"] && self.labelEight.text.length == 0) {
            [self computerEight];
            [self computerWin];
            return true;
        }
        else if ([self.labelEight.text isEqualToString:@"O"] && self.labelTwo.text.length == 0) {
            [self computerTwo];
            [self computerWin];
            return true;
        }
        else if ([self.labelThree.text isEqualToString:@"O"] && self.labelSeven.text.length == 0) {
            [self computerSeven];
            [self computerWin];
            return true;
        }
        else if ([self.labelSeven.text isEqualToString:@"O"] && self.labelThree.text.length == 0) {
            [self computerThree];
            [self computerWin];
            return true;
        }
        else if ([self.labelFour.text isEqualToString:@"O"] && self.labelSix.text.length == 0) {
            [self computerSix];
            [self computerWin];
            return true;
        }
        else if ([self.labelSix.text isEqualToString:@"O"] && self.labelFour.text.length == 0) {
            [self computerFour];
            [self computerWin];
            return true;
        }
    }
    if ([self.labelSix.text isEqualToString:@"O"]) {
        if ([self.labelFive.text isEqualToString:@"O"] && self.labelFour.text.length == 0) {
            [self computerFour];
            [self computerWin];
            return true;
        }
        else if ([self.labelFour.text isEqualToString:@"O"] && self.labelFive.text.length == 0) {
            [self computerFive];
            [self computerWin];
            return true;
        }
        else if ([self.labelThree.text isEqualToString:@"O"] && self.labelNine.text.length == 0) {
            [self computerNine];
            [self computerWin];
            return true;
        }
        else if ([self.labelNine.text isEqualToString:@"O"] && self.labelThree.text.length == 0) {
            [self computerThree];
            [self computerWin];
            return true;
        }
    }
    if ([self.labelSeven.text isEqualToString:@"O"]) {
        if ([self.labelOne.text isEqualToString:@"O"] && self.labelFour.text.length == 0) {
            [self computerFour];
            [self computerWin];
            return true;
        }
        else if ([self.labelFour.text isEqualToString:@"O"] && self.labelOne.text.length == 0) {
            [self computerOne];
            [self computerWin];
            return true;
        }
        else if ([self.labelFive.text isEqualToString:@"O"] && self.labelThree.text.length == 0) {
            [self computerThree];
            [self computerWin];
            return true;
        }
        else if ([self.labelThree.text isEqualToString:@"O"] && self.labelFive.text.length == 0) {
            [self computerFive];
            [self computerWin];
            return true;
        }
        else if ([self.labelEight.text isEqualToString:@"O"] && self.labelNine.text.length == 0) {
            [self computerNine];
            [self computerWin];
            return true;
        }
        else if ([self.labelNine.text isEqualToString:@"O"] && self.labelEight.text.length == 0) {
            [self computerEight];
            [self computerWin];
            return true;
        }
    }
    if ([self.labelEight.text isEqualToString:@"O"]) {
        if ([self.labelFive.text isEqualToString:@"O"] && self.labelTwo.text.length == 0) {
            [self computerTwo];
            [self computerWin];
            return true;
        }
        else if ([self.labelTwo.text isEqualToString:@"O"] && self.labelFive.text.length == 0) {
            [self computerFive];
            [self computerWin];
            return true;
        }
        else if ([self.labelSeven.text isEqualToString:@"O"] && self.labelNine.text.length == 0) {
            [self computerNine];
            [self computerWin];
            return true;
        }
        else if ([self.labelNine.text isEqualToString:@"O"] && self.labelSeven.text.length == 0) {
            [self computerSeven];
            [self computerWin];
            return true;
        }
    }
    if ([self.labelNine.text isEqualToString:@"O"]) {
        if ([self.labelOne.text isEqualToString:@"O"] && self.labelFive.text.length == 0) {
            [self computerFive];
            [self computerWin];
            return true;
        }
        else if ([self.labelFive.text isEqualToString:@"O"] && self.labelOne.text.length == 0) {
            [self computerOne];
            [self computerWin];
            return true;
        }
        else if ([self.labelSix.text isEqualToString:@"O"] && self.labelThree.text.length == 0) {
            [self computerThree];
            [self computerWin];
            return true;
        }
        else if ([self.labelThree.text isEqualToString:@"O"] && self.labelSix.text.length == 0) {
            [self computerSix];
            [self computerWin];
            return true;
        }
        else if ([self.labelEight.text isEqualToString:@"O"] && self.labelSeven.text.length == 0) {
            [self computerSeven];
            [self computerWin];
            return true;
        }
        else if ([self.labelSeven.text isEqualToString:@"O"] && self.labelEight.text.length == 0) {
            [self computerEight];
            [self computerWin];
            return true;
        }
    }
    return false;
}
-(void)checkBlock {
    if ([self.labelOne.text isEqualToString:@"X"]) {
        if ([self.labelTwo.text isEqualToString:@"X"]) {
            [self computerThree];
        }
        else if ([self.labelThree.text isEqualToString:@"X"]) {
            [self computerTwo];
        }
        else if ([self.labelFour.text isEqualToString:@"X"]) {
            [self computerSeven];
        }
        else if ([self.labelSeven.text isEqualToString:@"X"]) {
            [self computerFour];
        }
        else if ([self.labelFive.text isEqualToString:@"X"]) {
            [self computerNine];
        }
        else if ([self.labelNine.text isEqualToString:@"X"]) {
            [self computerFive];
        }
    }
    if ([self.labelTwo.text isEqualToString:@"X"]) {
        if ([self.labelThree.text isEqualToString:@"X"]) {
            [self computerOne];
        }
        else if ([self.labelOne.text isEqualToString:@"X"]) {
            [self computerThree];
        }
        else if ([self.labelFive.text isEqualToString:@"X"]) {
            [self computerEight];
        }
        else if ([self.labelEight.text isEqualToString:@"X"]) {
            [self computerFive];
        }
    }
    if ([self.labelThree.text isEqualToString:@"X"]) {
        if ([self.labelTwo.text isEqualToString:@"X"]) {
            [self computerOne];
        }
        if ([self.labelOne.text isEqualToString:@"X"]) {
            [self computerTwo];
        }
        if ([self.labelFive.text isEqualToString:@"X"]) {
            [self computerSeven];
        }
        if ([self.labelSeven.text isEqualToString:@"X"]) {
            [self computerFive];
        }
        if ([self.labelSix.text isEqualToString:@"X"]) {
            [self computerNine];
        }
        if ([self.labelNine.text isEqualToString:@"X"]) {
            [self computerSix];
        }
    }
    if ([self.labelFour.text isEqualToString:@"X"]) {
        if ([self.labelFive.text isEqualToString:@"X"]) {
            [self computerSix];
        }
        else if ([self.labelSix.text isEqualToString:@"X"]) {
            [self computerFive];
        }
        else if ([self.labelSeven.text isEqualToString:@"X"]) {
            [self computerOne];
        }
        else if ([self.labelOne.text isEqualToString:@"X"]) {
            [self computerSeven];
        }
    }
    if ([self.labelFive.text isEqualToString:@"X"]) {
        if ([self.labelOne.text isEqualToString:@"X"]) {
            [self computerNine];
        }
        else if ([self.labelNine.text isEqualToString:@"X"]) {
            [self computerOne];
        }
        else if ([self.labelTwo.text isEqualToString:@"X"]) {
            [self computerEight];
        }
        else if ([self.labelEight.text isEqualToString:@"X"]) {
            [self computerTwo];
        }
        else if ([self.labelThree.text isEqualToString:@"X"]) {
            [self computerSeven];
        }
        else if ([self.labelSeven.text isEqualToString:@"X"]) {
            [self computerThree];
        }
        else if ([self.labelSix.text isEqualToString:@"X"]) {
            [self computerFour];
        }
        else if ([self.labelFour.text isEqualToString:@"X"]) {
            [self computerSix];
        }
    }
    if ([self.labelSix.text isEqualToString:@"X"]) {
        if ([self.labelFive.text isEqualToString:@"X"]) {
            [self computerFour];
        }
        else if ([self.labelFour.text isEqualToString:@"X"]) {
            [self computerFive];
        }
        else if ([self.labelThree.text isEqualToString:@"X"]) {
            [self computerNine];
        }
        else if ([self.labelNine.text isEqualToString:@"X"]) {
            [self computerThree];
        }
    }
    if ([self.labelSeven.text isEqualToString:@"X"]) {
        if ([self.labelFour.text isEqualToString:@"X"]) {
            [self computerOne];
        }
        else if ([self.labelOne.text isEqualToString:@"X"]) {
            [self computerFour];
        }
        else if ([self.labelFive.text isEqualToString:@"X"]) {
            [self computerThree];
        }
        else if ([self.labelThree.text isEqualToString:@"X"]) {
            [self computerFive];
        }
        else if ([self.labelEight.text isEqualToString:@"X"]) {
            [self computerNine];
        }
        else if ([self.labelNine.text isEqualToString:@"X"]) {
            [self computerEight];
        }
    }
    if ([self.labelEight.text isEqualToString:@"X"]) {
        if ([self.labelNine.text isEqualToString:@"X"]) {
            [self computerSeven];
        }
        else if ([self.labelSeven.text isEqualToString:@"X"]) {
            [self computerNine];
        }
        else if ([self.labelFive.text isEqualToString:@"X"]) {
            [self computerTwo];
        }
        else if ([self.labelTwo.text isEqualToString:@"X"]) {
            [self computerFive];
        }
    }
    if ([self.labelNine.text isEqualToString:@"X"]) {
        if ([self.labelFive.text isEqualToString:@"X"]) {
            [self computerOne];
        }
        else if ([self.labelOne.text isEqualToString:@"X"]) {
            [self computerFive];
        }
        else if ([self.labelSix.text isEqualToString:@"X"]) {
            [self computerThree];
        }
        else if ([self.labelThree.text isEqualToString:@"X"]) {
            [self computerSix];
        }
        else if ([self.labelEight.text isEqualToString:@"X"]) {
            [self computerSeven];
        }
        else if ([self.labelSeven.text isEqualToString:@"X"]) {
            [self computerEight];
        }
    }
}
-(void)checkWin {

}

-(void)computerOne {
    self.labelOne.text = @"O";
    self.labelOne.textColor = [UIColor redColor];
    self.labelOne.textAlignment = NSTextAlignmentCenter;
}

-(void)computerTwo {
    self.labelTwo.text = @"O";
    self.labelTwo.textColor = [UIColor redColor];
    self.labelTwo.textAlignment = NSTextAlignmentCenter;
}

-(void)computerThree {
    self.labelThree.text = @"O";
    self.labelThree.textColor = [UIColor redColor];
    self.labelThree.textAlignment = NSTextAlignmentCenter;
}

-(void)computerFour {
    self.labelFour.text = @"O";
    self.labelFour.textColor = [UIColor redColor];
    self.labelFour.textAlignment = NSTextAlignmentCenter;
}

-(void)computerFive {
    self.labelFive.text = @"O";
    self.labelFive.textColor = [UIColor redColor];
    self.labelFive.textAlignment = NSTextAlignmentCenter;
}

-(void)computerSix {
    self.labelSix.text = @"O";
    self.labelSix.textColor = [UIColor redColor];
    self.labelSix.textAlignment = NSTextAlignmentCenter;
}

-(void)computerSeven {
    self.labelSeven.text = @"O";
    self.labelSeven.textColor = [UIColor redColor];
    self.labelSeven.textAlignment = NSTextAlignmentCenter;
}

-(void)computerEight {
    self.labelEight.text = @"O";
    self.labelEight.textColor = [UIColor redColor];
    self.labelEight.textAlignment = NSTextAlignmentCenter;
}

-(void)computerNine {
    self.labelNine.text = @"O";
    self.labelNine.textColor = [UIColor redColor];
    self.labelNine.textAlignment = NSTextAlignmentCenter;
}



-(void)computerWin {
    UIAlertController *computerWinAlert = [UIAlertController alertControllerWithTitle:@"Game Over" message:@"O Won" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *restartAction = [UIAlertAction actionWithTitle:@"Start A New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self viewDidLoad];
    }];
    [computerWinAlert addAction:restartAction];
    [self presentViewController:computerWinAlert animated:YES completion:nil];
}

@end
