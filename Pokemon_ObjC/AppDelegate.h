//
//  AppDelegate.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 29/07/22.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;

- (UINavigationController *)createRootVC;

@end
