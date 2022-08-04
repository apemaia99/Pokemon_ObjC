//
//  PokedexVC.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 29/07/22.
//

#import <UIKit/UIKit.h>
#import "PokemonManager.h"

@interface PokedexVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

+ (instancetype)initWithPokemonManager:(PokemonManager *)pokemonManager;

@end
