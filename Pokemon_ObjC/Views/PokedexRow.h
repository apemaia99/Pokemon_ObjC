//
//  PokedexRow.h
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 03/08/22.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

@interface PokedexRow : UITableViewCell

- (void)setDataWithPokemon:(Pokemon*)pokemon;

@end
