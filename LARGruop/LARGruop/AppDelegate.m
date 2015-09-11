//
//  AppDelegate.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Entities.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupApp];
    [self firstRunApp];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

-(void)firstRunApp
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"firstRun"])
    {
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            
            Customer *testCust1 =[Customer MR_createEntityInContext:localContext];
            testCust1.firstName = @"Jose";
            testCust1.lastName = @"Perez";
            
            Customer *testCust2 =[Customer MR_createEntityInContext:localContext];
            testCust2.firstName = @"Sofia";
            testCust2.lastName = @"Vergara";
            
            Customer *testCust3 =[Customer MR_createEntityInContext:localContext];
            testCust3.firstName = @"Fredy";
            testCust3.lastName = @"Juarez";
            
            Customer *testCust4 =[Customer MR_createEntityInContext:localContext];
            testCust4.firstName = @"Laura";
            testCust4.lastName = @"Paez";
            
            Customer *testCust5 =[Customer MR_createEntityInContext:localContext];
            testCust5.firstName = @"Rosa";
            testCust5.lastName = @"Orto";
            
            Customer *testCust6 =[Customer MR_createEntityInContext:localContext];
            testCust6.firstName = @"Ana";
            testCust6.lastName = @"Solano";
            
            Customer *testCust7 =[Customer MR_createEntityInContext:localContext];
            testCust7.firstName = @"Miguel";
            testCust7.lastName = @"Vionee";
            
            Customer *testCust8 =[Customer MR_createEntityInContext:localContext];
            testCust8.firstName = @"Lucas";
            testCust8.lastName = @"Volucas";
            
        } completion:nil];
        [defaults setObject:[NSDate date] forKey:@"firstRun"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    //[[NSManagedObjectContext defaultContext] saveNestedContexts];
}

-(void)setupApp
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self MR_SetupDatabase];
    //[[GenericService sharedService] MR_SetupDatabase];
    //[[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    
    // Preloads keyboard so there's no lag on initial keyboard appearance.
    UITextField *lagFreeField = [[UITextField alloc] init];
    [self.window addSubview:lagFreeField];
    [lagFreeField becomeFirstResponder];
    [lagFreeField resignFirstResponder];
    [lagFreeField removeFromSuperview];
}

- (void)registerDefaultsFromSettingsBundle {
    // this function writes default settings as settings
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
            NSLog(@"writing as default %@ to the key %@",[prefSpecification objectForKey:@"DefaultValue"],key);
        }
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    
}

- (void)MR_SetupDatabase
{
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:YES];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"LARGruop"];
    
    if ([[[NSPersistentStoreCoordinator MR_defaultStoreCoordinator] persistentStores] count] == 0){
        [MagicalRecord cleanUp];
        NSError *error;
        NSURL *fileURL = [NSPersistentStore MR_urlForStoreName:@"LARGruop"];
        [[NSFileManager defaultManager] removeItemAtURL:fileURL error:&error];
        [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"LARGruop"];
        [MagicalRecord setupCoreDataStackWithStoreNamed:@"LARGruop"];
    }
}

#pragma mark -
#pragma mark - Core Data stack
#pragma mark - 

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "prsp.LARGruop" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LARGruop" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LARGruop.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark -
#pragma mark - Core Data Saving support
#pragma mark -

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
