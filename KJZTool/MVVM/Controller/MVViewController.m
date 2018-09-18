//
//  MVViewController.m
//  KJZTool
//
//  Created by alete on 2018/8/24.
//  Copyright © 2018 aletevcc. All rights reserved.
//

#import "MVViewController.h"
#import "MVViewModel.h"
#import "MVTableViewCell.h"

#import "VCRDataSource.h"
#import <Masonry.h>
#import <ReactiveObjC/RACReturnSignal.h>

@interface MVViewController () < UITableViewDelegate >

@property (nonatomic, strong) UITableView *tableView ;
@property (nonatomic, strong) MVViewModel *mvModel ;
@property (nonatomic, strong) VCRDataSource *dataSource ;

@end

@implementation MVViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _mvModel = [[MVViewModel alloc]init];
    
    
    @weakify(self)
    [self.mvModel.reccomand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"%@",x);
        [self.dataSource addDataArray:self.mvModel.dataArray];
        [self.tableView reloadData];
    }];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(30, 30, 50, 20)];
    [button setTitle:@"RAC" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.mvModel.reccomand execute:@"hello worlddfsdafd"];
    }];
    
    [self.tableView registerClass:[MVTableViewCell class] forCellReuseIdentifier:@"qwrerqwe"];
    self.dataSource = [[VCRDataSource alloc]initWithIdentifier:@"qwrerqwe" configureBlock:^(MVTableViewCell * _Nonnull cell, MVModel *  _Nonnull model, NSIndexPath * _Nonnull indexPath) {
//        @strongify(self)
        cell.textLabel.text = model.title ;
    }];
    
    [[[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)]map:^id _Nullable(RACTuple * _Nullable value) {
        @strongify(self)
        NSIndexPath *index = value.second ;
        MVTableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
        return cell.textLabel.text ;
    }]subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
        NSLog(@"%@",x);
    }];
    
    
    self.tableView.dataSource = self.dataSource ;
    self.tableView.delegate = self ;
    [self.view bringSubviewToFront:button];
    
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView ;
    
}

#pragma mark - TableViewDataSource -
-(void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
