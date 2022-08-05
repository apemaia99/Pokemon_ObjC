//
//  PokemonDetailedVC.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 04/08/22.
//

#import "PokemonDetailedVC.h"

@interface PokemonDetailedVC ()

@property(strong, nonnull) Pokemon *pokemon;
@property(strong, null_unspecified) UITableView *tableView;

- (void)configureVC;
- (UITableView *)createTableView;
- (UITableViewCell *)createImageCellByUrl:(NSURL *)url;
- (UITableViewCell *)createCellWithText:(NSString *)text;

@end

@implementation PokemonDetailedVC

+ (instancetype)initWithPokemon:(Pokemon *)pokemon {
    PokemonDetailedVC *newInstance = [[PokemonDetailedVC alloc] init];
    newInstance.pokemon = pokemon;
    
    return newInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureVC];
    self.tableView = [self createTableView];
}
//MARK: - Views Setup
- (void)configureVC {
    self.title = [self.pokemon.name capitalizedString];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.view.backgroundColor = [UIColor systemBackgroundColor];
}

- (UITableView *)createTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    tableView.rowHeight = 90;
    tableView.allowsSelection = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    return tableView;
}

- (UITableViewCell *)createImageCellByUrl:(NSURL *)url {
    
    UITableViewCell *imageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"image"];
    UIImageView *imageView = [[UIImageView alloc] init];
    
    [imageCell addSubview:imageView];
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView.centerXAnchor constraintEqualToAnchor:imageCell.centerXAnchor].active = YES;
    [imageView.centerYAnchor constraintEqualToAnchor:imageCell.centerYAnchor].active = YES;
    
    [NetworkService.sharedInstance fetchObjectByUrlWithCache:url completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = [UIImage imageWithData:data];
            });
        } else {
            NSLog(@"Error: %@ - (PokemonDetailedVC: createImageCellByUrl)", error.localizedDescription);
        }
    }];
    
    return imageCell;
}

- (UITableViewCell *)createCellWithText:(NSString *)text {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:text];
    
    UILabel *labelView = [[UILabel alloc] init];
    labelView.text = text;
    
    [cell addSubview:labelView];
    
    labelView.translatesAutoresizingMaskIntoConstraints = NO;
    [labelView.centerYAnchor constraintEqualToAnchor:cell.centerYAnchor].active = YES;
    [labelView.leadingAnchor constraintEqualToAnchor:cell.leadingAnchor constant:20].active = YES;
    
    return cell;
}
//MARK: - Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        default:
            return self.pokemon.moves.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 210 : 45;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return [@"details" capitalizedString];
        case 2:
            return [[NSString stringWithFormat:@"%@%lu", @"moves ", self.pokemon.moves.count] capitalizedString];
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return [self createImageCellByUrl:self.pokemon.sprites.front_default];
        case 1:
            if (indexPath.row == 0) {
                return [self createCellWithText:[NSString stringWithFormat:@"%@%u", @"Height ", self.pokemon.height]];
            } else {
                return [self createCellWithText:[NSString stringWithFormat:@"%@%u", @"weight ", self.pokemon.weight]];
            }
        default:
            return [self createCellWithText:self.pokemon.moves[indexPath.row].name];
    }
}

@end
