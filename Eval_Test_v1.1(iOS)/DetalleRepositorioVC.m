//
//  DetalleRepositorioVC.m
//  Eval_Test_v1.1(iOS)
//
//  Created by Ivan Lopez Ansaldo on 10/11/17.
//  Copyright © 2017 Ivan Lopez Ansaldo. All rights reserved.
//

#import "DetalleRepositorioVC.h"

@implementation DetalleRepositorioVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = [_repo objectForKey:@"name"];
    
    _tvDescripcion.text = [_repo objectForKey:@"description"];
    
    NSMutableDictionary *owner = [_repo objectForKey:@"owner"];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [owner objectForKey:@"avatar_url"]]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            _repoImage.image = [UIImage imageWithData: data];
        });
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)b_issues:(UIButton *)sender {
    _selected = @"Last Issues";
    
    _curtainView.alpha = 0.6;
    _containerTableView.alpha = 1;
    _bCerrar.alpha = 1;
    
    NSString *issues = [_repo objectForKey:@"issues_url"];
    NSArray *issues_item = [issues componentsSeparatedByString:@"{"];
    NSString *issues_url = issues_item[0];
    NSLog(@"issues: %@",issues_url);
    
    NSString *link = [NSString stringWithFormat: @"%@", issues_url];
    
    NSURL *searchURL =  [NSURL URLWithString:link];
    NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
    NSError *error;
    
    NSMutableDictionary *searchDict = [NSJSONSerialization JSONObjectWithData:searchData options:NSJSONReadingMutableContainers error:&error];
    
    if (error){
        NSLog(@"Error: %@",error.debugDescription);
        
    }else{

        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (NSDictionary *sub in searchDict)
        {
            NSString *title = [sub objectForKey:@"title"];
            id tit = title;
            //NSLog(@"title %@",tit);
            [mutableArray addObject:tit];
            
        }
        _myarray = mutableArray;        
        
        [_containerTableView reloadData];
    }
}

- (IBAction)b_usuarios:(UIButton *)sender {
    _selected = @"Most Active Contributors";
    
    _curtainView.alpha = 0.6;
    _containerTableView.alpha = 1;
    _bCerrar.alpha = 1;
    
    NSString *contributors_url = [_repo objectForKey:@"contributors_url"];
    
    NSString *link = [NSString stringWithFormat: @"%@", contributors_url];
    
    NSURL *searchURL =  [NSURL URLWithString:link];
    NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
    NSError *error;
    
    NSMutableDictionary *searchDict = [NSJSONSerialization JSONObjectWithData:searchData options:NSJSONReadingMutableContainers error:&error];
    
    if (error){
        NSLog(@"Error: %@",error.debugDescription);
        
    }else{
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (NSDictionary *sub in searchDict)
        {
            NSString *login = [sub objectForKey:@"login"];
            id log = login;
            //NSLog(@"log %@",log);
            [mutableArray addObject:log];
            
        }
        _myarray = mutableArray;
        
        [_containerTableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSString *issue = _myarray[indexPath.row];

    cell.textLabel.text = issue;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *message = _myarray[indexPath.row];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:_selected
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* doneButton = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     //Handle your yes please button action here
                                 }];
    
    [alert addAction:doneButton];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)b_cerrar:(UIButton *)sender {
    _curtainView.alpha = 0;
    _bCerrar.alpha = 0;
    _containerTableView.alpha = 0;
}

@end
