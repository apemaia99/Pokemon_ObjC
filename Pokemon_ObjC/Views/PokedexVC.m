//
//  ViewController.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 29/07/22.
//

#import "PokedexVC.h"

@interface PokedexVC ()

@property(strong, nonnull) PokemonManager *pokemonManager;
@property(strong, null_unspecified) UITableView *tableView;

- (void)configureVC;
- (UITableView *_Nonnull)createTableView;
- (UIBarButtonItem *_Nonnull)createNavBarMenu;

@end

@implementation PokedexVC

+ (instancetype)initWithPokemonManager:(PokemonManager *)pokemonManager {
    //Dependency Injection
    PokedexVC *newInstance = [[PokedexVC alloc] init];
    newInstance.pokemonManager = pokemonManager;
    
    return newInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureVC];
    self.tableView = [self createTableView];
    
    [self.pokemonManager loadFirstTimeWithCompletion:^{
        [self.tableView reloadData];
    }];
}
//MARK: - Views Setup
- (void)configureVC {
    self.title = @"Pokedex";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.navigationItem.rightBarButtonItem = [self createNavBarMenu];
}

- (UITableView *)createTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    tableView.rowHeight = 90;
    
    [tableView registerClass:[PokedexRow class] forCellReuseIdentifier:@"PokedexRow"];
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
            [self.pokemonManager sortListByMode:alphabetical];
            [self.tableView reloadData];
        }],
        [UIAction
         actionWithTitle:@"Reverse"
         image:nil
         identifier:nil
         handler:^(__kindof UIAction * _Nonnull action) {
            [self.pokemonManager sortListByMode:reverse];
            [self.tableView reloadData];
        }],
        [UIAction
         actionWithTitle:@"Standard"
         image:nil
         identifier:nil
         handler:^(__kindof UIAction * _Nonnull action) {
            [self.pokemonManager sortListByMode:standard];
            [self.tableView reloadData];
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

//MARK: - Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonManager.pokemonList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Pagination
    if (indexPath.row == [self.tableView numberOfRowsInSection:0] - 1) {
        [self.pokemonManager loadMoreWithCompletion:^{
            [self.tableView reloadData];
        }];
    }
    //Cell setup
    PokedexRow *cell = [tableView dequeueReusableCellWithIdentifier:@"PokedexRow"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setDataWithPokemon:self.pokemonManager.pokemonList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PokemonDetailedVC *pokemonDetailedVC = [PokemonDetailedVC initWithPokemon:self.pokemonManager.pokemonList[indexPath.row]];
    [self.navigationController pushViewController:pokemonDetailedVC animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
