//
//  PokedexVC.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 29/07/22.
//

#import <UIKit/UIKit.h>

@interface PokedexVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(strong, null_unspecified, nonatomic) UITableView *tableView;

- (void)configureVC;

- (UITableView *_Nonnull)createTableView;

- (UIBarButtonItem *_Nonnull)createNavBarMenu;

@end
