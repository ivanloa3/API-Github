//
//  ViewController.h
//  Eval_Test_v1.1(iOS)
//
//  Created by Ivan Lopez Ansaldo on 10/10/17.
//  Copyright © 2017 Ivan Lopez Ansaldo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tf_programmingLanguage;

- (IBAction)b_searchLanguage:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tv_listRepos;
@property (weak, nonatomic) IBOutlet UILabel *labelLeyenda;


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@property NSMutableArray *repos;


@end

