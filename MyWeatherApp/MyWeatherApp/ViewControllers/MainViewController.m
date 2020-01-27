//
//  UIViewController+MainViewController.m
//  MyWeatherApp
//
//  Created by MacBook Pro  on 18.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "MainViewController.h"
#import "SearchViewController.h"
#import "AppDelegate.h"


@interface MainViewController() {
    AppDelegate* appDelegate;
    NSManagedObjectContext* context;
}

@end

@implementation MainViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.fetchedCities = [NSMutableArray array];
    _table.allowsMultipleSelectionDuringEditing = false;
    [self fetch];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void) edit {
    if (self.table.isEditing) {
        self.table.editing = NO;
        [self fetch];
        [self.table reloadData];
        self.navigationItem.leftBarButtonItem.title = @"Edit";
    } else {
        self.table.editing = YES;
        self.navigationItem.leftBarButtonItem.title = @"Done";
    }
}

-(void) didChooseValue:(City*) city {
    city.number = (int)[self.fetchedResultsController fetchedObjects].count;
    [self saveData:city];
    [self fetch];
    [self.table reloadData];
    NSLog(@"%@", [self.fetchedResultsController fetchedObjects]);
}


-(void)addCity:(id)sender {
    SearchViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    vc.delegate = self;
    UINavigationController *objNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [objNav setModalPresentationStyle:UIModalPresentationFullScreen];
    [self.navigationController pushViewController:vc animated:YES];
   // [self presentViewController:objNav animated:YES completion:nil];
    NSLog(@"+ tapped");
}



#pragma mark -Core data methods-

-(void) saveData:(City*)city {
   // NSNumber *count = [NSNumber numberWithInteger:self.locationsArray.count];
    NSManagedObject* entityObj = [NSEntityDescription insertNewObjectForEntityForName:@"CityEntity" inManagedObjectContext:context];
    [entityObj setValue:city.city forKey:@"city"];
    [entityObj setValue:city.country forKey:@"country"];
    [entityObj setValue:[NSNumber numberWithDouble:city.lat] forKey:@"lat"];
    [entityObj setValue:[NSNumber numberWithDouble:city.lng] forKey:@"lng"];
    [entityObj setValue:[NSNumber numberWithInt:city.number] forKey:@"number"];

    [appDelegate saveContext];
}

-(void) fetch {
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CityEntity"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:true];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                              initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"%@",[self.fetchedResultsController fetchedObjects] );
}

-(void) printResultsFromArray:(NSArray <City*>*) cities {
    for (City *city in cities) {
        NSLog(@"%@,%@,%f,%f", city.city,city.country,city.lat,city.lng);
    }
}

#pragma mark -Tableview methods-

- (void)configureCell:(UITableViewCell *)cell withObject:(City *)object {
    cell.textLabel.text = [NSString stringWithFormat:@"%d - %@, %@", object.number, object.city, object.country];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString* identifier = @"cityCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    City* city = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:(City*) city];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
   return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self.fetchedResultsController fetchedObjects]];
    City* movingCity = [array objectAtIndex:fromIndexPath.row];
    NSLog(@"%d", movingCity.number);
    [array removeObjectAtIndex:fromIndexPath.row];
    [array insertObject:movingCity atIndex:toIndexPath.row];
    NSLog(@"%d", movingCity.number);
    
    // Update the order of them all according to their index in the mutable array
     int i = 0;
     for (NSManagedObject *mo in array)
     {
         [mo setValue:[NSNumber numberWithInt:i++] forKey:@"number"];
     }
    [appDelegate saveContext];
 }

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray* array = [self.fetchedResultsController fetchedObjects];
        NSManagedObject* city = [array objectAtIndex:indexPath.row];
        [context deleteObject:city];
        [appDelegate saveContext];
        [self fetch];
        [self.table reloadData];
    }
}

@end
