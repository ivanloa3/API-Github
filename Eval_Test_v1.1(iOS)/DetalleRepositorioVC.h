//
//  DetalleRepositorioVC.h
//  Eval_Test_v1.1(iOS)
//
//  Created by Ivan Lopez Ansaldo on 10/11/17.
//  Copyright © 2017 Ivan Lopez Ansaldo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalleRepositorioVC : UIViewController


@property (nonatomic, assign) NSMutableDictionary *repo;

@property (weak, nonatomic) IBOutlet UITextView *tvDescripcion;
@property (weak, nonatomic) IBOutlet UIImageView *repoImage;
@property NSMutableDictionary *owner;
@property (weak, nonatomic) IBOutlet UIView *curtainView;
@property (weak, nonatomic) IBOutlet UITableView *containerTableView;
- (IBAction)b_issues:(UIButton *)sender;
- (IBAction)b_usuarios:(UIButton *)sender;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@property NSMutableArray *myarray;
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@property NSString *selected;
@property (weak, nonatomic) IBOutlet UIButton *bCerrar;
- (IBAction)b_cerrar:(UIButton *)sender;

@end


