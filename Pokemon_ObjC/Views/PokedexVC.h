//
//  PokedexVC.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 29/07/22.
//

#import <UIKit/UIKit.h>
#import "PokemonManager.h"
#import "PokemonDetailedVC.h"
#import "PokedexRow.h"

@interface PokedexVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

+ (instancetype)initWithPokemonManager:(PokemonManager *)pokemonManager;

@end
