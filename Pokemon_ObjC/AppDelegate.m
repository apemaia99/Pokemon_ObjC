//
//  AppDelegate.m
//  Pokemon_ObjC
//
//  Created by Alessandro Di Maio on 29/07/22.
//

#import "AppDelegate.h"
#import "PokedexVC.h"

@interface AppDelegate ()

@property(strong, nonnull) PokemonManager *pokemonManager;

- (UINavigationController *)createRootVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.pokemonManager = [PokemonManager init];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [self createRootVC];
    
    return YES;
}

- (UINavigationController *)createRootVC {
    return [[UINavigationController alloc] initWithRootViewController:[PokedexVC initWithPokemonManager:self.pokemonManager]];
}

@end
