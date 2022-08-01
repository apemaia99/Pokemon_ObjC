//
//  ViewController.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 29/07/22.
//

#import "PokedexVC.h"
#import "NetworkService.h"
#import "PokemonIndex.h"

@interface PokedexVC ()
//MARK: - Private Properties and Methods Blueprints
@property(strong, null_unspecified) UITableView *tableView;

- (void)configureVC;

- (UITableView *_Nonnull)createTableView;

- (UIBarButtonItem *_Nonnull)createNavBarMenu;

@end

@implementation PokedexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureVC];
    self.tableView = [self createTableView];
    
    
    [NetworkService fetchObjectByUrl: [NSURL URLWithString:@"https://pokeapi.co/api/v2/pokemon"]
                          completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        
        PokemonIndex * test = [PokemonIndex initFromData:data];
        
        [test getCurrentInfo];
        
        
        [NetworkService fetchObjectByUrl:test.anchors.firstObject.url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
            
            NSDictionary * req2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"opsla");
            
        }];
        
        
    }];
    
    
    
}
//MARK: - Views Configuration
- (void)configureVC {
    self.title = @"Pokedex";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.navigationItem.rightBarButtonItem = [self createNavBarMenu];
}

- (UITableView *)createTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    tableView.rowHeight = 90;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview: tableView];
    
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    return tableView;
}

- (UIBarButtonItem *)createNavBarMenu {
    
    NSArray<UIAction*> *actions = @[
        [UIAction
         actionWithTitle:@"Alphabetical"
         image:nil
         identifier:nil
         handler:^(__kindof UIAction * _Nonnull action) {
            
        }],
        [UIAction
         actionWithTitle:@"Reverse"
         image:nil
         identifier:nil
         handler:^(__kindof UIAction * _Nonnull action) {
            
        }],
        [UIAction
         actionWithTitle:@"Standard"
         image:nil
         identifier:nil
         handler:^(__kindof UIAction * _Nonnull action) {
            
        }]
    ];
    
    UIMenu *menu = [UIMenu menuWithTitle:@"Order Mode"
                                   image:nil
                              identifier:UIMenuView
                                 options:UIMenuOptionsSingleSelection
                                children:actions];
    
    UIImage *symbol = [UIImage systemImageNamed:@"arrow.up.arrow.down.circle.fill"
                              withConfiguration:[UIImageSymbolConfiguration configurationWithTextStyle:UIFontTextStyleTitle2]];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:symbol menu:menu];
    
    return button;
}

//MARK: - TableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

@end
