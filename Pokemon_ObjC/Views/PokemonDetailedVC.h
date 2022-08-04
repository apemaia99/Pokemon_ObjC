//
//  PokemonDetailedVC.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 04/08/22.
//

#import <UIKit/UIKit.h>
#import "NetworkService.h"
#import "Pokemon.h"

@interface PokemonDetailedVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

+ (instancetype)initWithPokemon:(Pokemon *)pokemon;

@end
