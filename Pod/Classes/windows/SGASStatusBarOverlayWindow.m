//
//  SGASStatusBarOverlayWindow.m
//  SGASScreenRecorder
//
//  Created by Shmatlay Andrey on 22.06.13.
//  Edited by Aleksandr Gusev on 23/10/14
//

#import "SGASStatusBarOverlayWindow.h"

@implementation SGASStatusBarOverlayWindow

#pragma mark - Init/dealloc

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self applyState];
    }
    return self;
}

#pragma mark - Properties

- (void)setState:(SGASStatusBarOverlayWindowState)state {
    if (_state != state) {
        _state = state;
        [self applyState];
    }
}

#pragma mark - UIView

- (BOOL)isUserInteractionEnabled {
    return NO;
}

#pragma mark - UIWindow

- (UIWindowLevel)windowLevel {
    return UIWindowLevelStatusBar + 1.0f;
}

- (UIViewController *)rootViewController {
    UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window ?:
        [[UIApplication sharedApplication].windows firstObject];
    return mainWindow.rootViewController;
}

#pragma mark - Private

- (void)applyState {
    switch (_state) {
        case SGASStatusBarOverlayWindowStateIdle:
            self.backgroundColor = [UIColor colorWithRed:0x4C/(CGFloat)0xFF
                                                   green:0xD9/(CGFloat)0xFF
                                                    blue:0x64/(CGFloat)0xFF
                                                   alpha:0.5f];
            break;
        case SGASStatusBarOverlayWindowStateRecording:
            self.backgroundColor = [UIColor colorWithRed:0xFF/(CGFloat)0xFF
                                                   green:0x3B/(CGFloat)0xFF
                                                    blue:0x30/(CGFloat)0xFF
                                                   alpha:0.5f];
            break;
        case SGASStatusBarOverlayWindowStateSaving:
            self.backgroundColor = [UIColor colorWithRed:0xFF/(CGFloat)0xFF
                                                   green:0xCC/(CGFloat)0xFF
                                                    blue:0x00/(CGFloat)0xFF
                                                   alpha:0.5f];
            break;
        default:
            NSCAssert(NO, @"invalid state");
            break;
    }
    self.layer.borderColor = [self.backgroundColor colorWithAlphaComponent:0.9f].CGColor;
    self.layer.borderWidth = 1.0f / [UIScreen mainScreen].scale;
}

@end
