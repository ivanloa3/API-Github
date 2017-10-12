//
//  ViewController.m
//  Eval_Test_v1.1(iOS)
//
//  Created by Ivan Lopez Ansaldo on 10/10/17.
//  Copyright © 2017 Ivan Lopez Ansaldo. All rights reserved.
//

#import "ViewController.h"
#import "DetalleRepositorioVC.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_repos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSMutableDictionary *repo = _repos[indexPath.row];
    cell.textLabel.text = [repo objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //DetalleRepositorioVC *detalleRepositorioVC = [[UIViewController alloc] init];
    DetalleRepositorioVC *detalleRepositorioVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetalleRepositorioVC"];
    
    NSMutableDictionary *repo = _repos[indexPath.row];
    
    detalleRepositorioVC.repo = repo;

    
    [self.navigationController pushViewController:detalleRepositorioVC animated:true];
    
}

- (IBAction)b_searchLanguage:(id)sender{
    
    if (![_tf_programmingLanguage.text  isEqual: @""]){
        
        
        NSString *link = [NSString stringWithFormat: @"https://api.github.com/search/repositories?q=+language:%@&sort=stars&order=desc", _tf_programmingLanguage.text]; ;
        NSLog(@"Link: %@", link);
        
        NSURL *searchURL =  [NSURL URLWithString:link];
        NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
        NSError *error;
        
        NSMutableDictionary *searchDict = [NSJSONSerialization JSONObjectWithData:searchData options:NSJSONReadingMutableContainers error:&error];
        
        if (error){
            NSLog(@"Error: %@",error.description);
            _labelLeyenda.text = @"Error en busqueda";
        }else{
            NSMutableArray *repos_search = [searchDict objectForKey:@"items"];
            //NSLog(@"REPOS: %@", repos_search);
            if ([repos_search count] > 0){
                _repos = repos_search;
                [self.tv_listRepos reloadData];
                _labelLeyenda.text = @"";
            }
        }
    }else{
        _repos = nil;
        _labelLeyenda.text = @"Especificar Lenguaje de Programación.";
        [self.tv_listRepos reloadData];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
