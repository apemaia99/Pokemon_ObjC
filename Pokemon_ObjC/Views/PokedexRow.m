//
//  PokedexRow.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 03/08/22.
//

#import "PokedexRow.h"

@interface PokedexRow ()

@property(strong, null_unspecified) UIStackView *pokemonCaptionStack;
@property(strong, null_unspecified) UIImageView *pokemonImageView;
@property(strong, null_unspecified) UILabel *pokemonNameLabelView;
@property(strong, null_unspecified) UILabel *pokemonMovesLabelView;

- (UIImageView *)createPokemonImageView;
- (UIStackView *)createPokemonDescriptionStack;
- (UILabel *)createPokemonNameLabelView;
- (UILabel *)createPokemonMovesLabelView;

@end

@implementation PokedexRow

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.pokemonImageView = [self createPokemonImageView];
    self.pokemonCaptionStack = [self createPokemonDescriptionStack];
    
    return self;
}

- (void)setDataWithPokemon:(Pokemon*)pokemon {
    self.pokemonNameLabelView.text = [pokemon.name capitalizedString];
    self.pokemonMovesLabelView.text = [[NSString alloc] initWithFormat:@"%@%lu", @"Number of moves: ",pokemon.moves.count];
//    fetch async image
}

- (UIImageView *)createPokemonImageView {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.layer.cornerRadius = 10;
    imageView.clipsToBounds = YES;
    
    [self addSubview:imageView];
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView.widthAnchor constraintEqualToConstant:80].active = YES;
    [imageView.heightAnchor constraintEqualToConstant:80].active = YES;
    [imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16].active = YES;
    [imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    
    return imageView;
}

- (UIStackView *)createPokemonDescriptionStack {
    
    self.pokemonNameLabelView = [self createPokemonNameLabelView];
    self.pokemonMovesLabelView = [self createPokemonMovesLabelView];
    
    UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:@[
        self.pokemonNameLabelView,
        self.pokemonMovesLabelView
    ]];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.distribution = UIStackViewDistributionEqualSpacing;
    stack.spacing = 12;
    
    [self addSubview:stack];
    
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [stack.leadingAnchor constraintEqualToAnchor:self.pokemonImageView.trailingAnchor constant:16].active = YES;
    [stack.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    
    return stack;
}

- (UILabel *)createPokemonNameLabelView {
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    label.numberOfLines = 0;
    label.adjustsFontSizeToFitWidth = YES;
    
    return label;
}

- (UILabel *)createPokemonMovesLabelView {
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = [UIColor secondaryLabelColor];
    
    return label;
}

@end
