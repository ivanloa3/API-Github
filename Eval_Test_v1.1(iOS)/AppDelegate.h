//
//  AppDelegate.h
//  Eval_Test_v1.1(iOS)
//
//  Created by Ivan Lopez Ansaldo on 10/10/17.
//  Copyright © 2017 Ivan Lopez Ansaldo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

