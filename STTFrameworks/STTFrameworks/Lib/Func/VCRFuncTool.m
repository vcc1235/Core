//
//  VCRFuncTool.m
//  秀VV
//
//  Created by alete on 2017/5/19.
//  Copyright © 2017年 vcc. All rights reserved.
//

#import "VCRFuncTool.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"

BOOL Device()
{
    {if(RectH>RectW)return RectH>667?YES:NO ;else return RectW>667?YES:NO;} ;
}

@interface VCRFuncToolItem ()

@property (nonatomic, strong) NSString *itemName;



@end


@implementation VCRFuncToolItem



@end
#import <Masonry/Masonry.h>
#define SUBVIEWTAG 1854875

@interface VCRFuncToolTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *selectTitle;

@property (nonatomic, strong,readonly) UILabel *titleLabel;

@property (nonatomic, strong) UIColor *tintColor ;

@property (nonatomic, strong) UIColor *separatorColor ;

@end

@implementation VCRFuncToolTableViewCell
@synthesize titleLabel = _titleLabel ;


-(void)initTableViewCell
{
    
    [self setSeparatorWithColor:self.separatorColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
    
}

-(void)setSeparatorWithColor:(UIColor *)color
{
    
    
    for (UIView *view in self.contentView.subviews) {
        view.tag = SUBVIEWTAG ;
        [view removeFromSuperview];
    }
    
    UIView *subView = [[UIView alloc]init];
    [subView setBackgroundColor:color];
    [self.contentView addSubview:subView];
    [self.contentView bringSubviewToFront:subView];
    subView.tag = SUBVIEWTAG ;
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).with.offset(0);
        make.right.equalTo(self.contentView).with.offset(0);
        make.bottom.equalTo(self.contentView).with.offset(0);
        make.height.mas_equalTo(@(0.3));
        
    }];
    
    
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        //        [self setSeparatorWithColor:Color(200, 200, 200, 1.0)];
        [self initTableViewCell];
        _titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = self.tintColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter ;
    }
    return _titleLabel ;
}

-(void)setSelectTitle:(NSString *)selectTitle
{
    self.titleLabel.text = selectTitle ;
}



@end

@protocol VCRFuncToolViewDelegate  <NSObject>

-(void)funcToolDidSelectAtIndex:(NSInteger)index ;

-(void)funcToolDidCancle ;

@end

@interface VCRFuncToolView : UIView < UITableViewDelegate , UITableViewDataSource >
{
@private
    NSArray *datalist ;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) id < VCRFuncToolViewDelegate > delegate ;

@property (nonatomic, strong) UIColor *backColor ;

@property (nonatomic, strong) UIColor *separatorColor ;

@property (nonatomic, strong) UIColor *tintColor ;

@property (nonatomic, strong) UILabel *headerlabel ;

@property (nonatomic, strong) NSString *title ;

@end

@implementation VCRFuncToolView

-(UILabel *)headerlabel{
    if (!_headerlabel) {
        _headerlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, RectW, 0)];
        _headerlabel.textAlignment = NSTextAlignmentCenter ;
        //        _headerlabel.textColor = UIColor.lightTextColor ;
        _headerlabel.font = [UIFont systemFontOfSize:13];
        _headerlabel.textColor = UIColor.lightGrayColor ;
    }
    return _headerlabel ;
}

-(void)setTitle:(NSString *)title{
    self.headerlabel.text = title ;
    if(title != nil)
        self.headerlabel.height = 60.0f ;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = self.backColor;
    }
    return self;
}

-(void)setBackColor:(UIColor *)backColor{
    self.backgroundColor = backColor ;
}

-(void)reloadByData:(NSArray *)data
{
    datalist = data ;
    
    [self.tableView reloadData];
}



-(UITableView *)tableView
{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        [self addSubview:_tableView];
        _tableView.scrollEnabled = NO ;
        _tableView.estimatedRowHeight = 0 ;
        _tableView.estimatedSectionHeaderHeight = 0 ;
        _tableView.estimatedSectionFooterHeight = 0 ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        [_tableView registerClass:[VCRFuncToolTableViewCell class] forCellReuseIdentifier:@"com.functiontool.show"];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _tableView.tableHeaderView = self.headerlabel ;
        //        [self setExtraCellLineHidden:_tableView];
    }
    return _tableView ;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return datalist.count ;
    }else
    {
        return 1 ;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Device()?48:44 ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section) {
        return 10 ;
    }else{
        if (self.headerlabel.text==nil) {
            return 0 ;
        }else{
            return 1 ;
        }
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VCRFuncToolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.functiontool.show" forIndexPath:indexPath];
    if (indexPath.section) {
        [cell setSelectTitle:@"取消"];
        return cell ;
    }else
    {
        VCRFuncToolItem *item = [datalist objectAtIndex:indexPath.row];
        cell.separatorColor = self.separatorColor ;
        cell.tintColor = self.tintColor ;
        [cell setSelectTitle:item.itemName];
        return cell ;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        if ([_delegate respondsToSelector:@selector(funcToolDidCancle)]) {
            [_delegate funcToolDidCancle];
        }
    }else
    {
        if ([_delegate respondsToSelector:@selector(funcToolDidSelectAtIndex:)]) {
            [_delegate funcToolDidSelectAtIndex:indexPath.row];
        }
    }
}


@end

@interface VCRFuncTool () < VCRFuncToolViewDelegate >
{
@private
    VCRFuncToolView *subView ;
    UIView *backView ;
}
@property (nonatomic, strong) NSArray <VCRFuncToolItem *> *datalist;

@property (nonatomic, strong) NSString *title ;

@end


@implementation VCRFuncTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tintColor = VCRColorMake(20, 20, 20, 1.0);
        self.separatorColor = VCRColorMake(200, 200, 200, 1.0);
    }
    return self;
}

-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor ;
    subView.tintColor = tintColor ;
    [subView reloadByData:self.datalist];
}

-(void)setSeparatorColor:(UIColor *)separatorColor{
    _separatorColor = separatorColor ;
    subView.separatorColor = separatorColor ;
    [subView reloadByData:self.datalist];
}

-(void)setBackColor:(UIColor *)backColor{
    subView.backColor = backColor ;
}

+(instancetype)initAddFuncToolItems:(NSArray <NSString *> *)items {
    VCRFuncTool *func = [[VCRFuncTool alloc]init];
    [func setItemDatalist:items] ;
    [func setupFuncTool];
    return func ;
}
+(instancetype)initAddFuncToolItems:(NSArray<NSString *> *)items title:(NSString *)title{
    VCRFuncTool *func = [[VCRFuncTool alloc]init];
    func.title = title;
    [func setItemDatalist:items] ;
    [func setupFuncTool];
    return func ;
}

+(instancetype)initAddFuncToolItems:(NSArray <NSString *> *)items delegate:(id<VCRFuncToolDelegate>)delegate {
    VCRFuncTool *func = [[VCRFuncTool alloc]init];
    func.delegate = delegate ;
    [func setItemDatalist:items] ;
    [func setupFuncTool];
    return func ;
}

+(instancetype)initAddFuncToolItems:(NSArray <NSString *> *)items title:(NSString *)title delegate:(id<VCRFuncToolDelegate>)delegate{
    VCRFuncTool *func = [[VCRFuncTool alloc]init];
    func.title = title;
    func.delegate = delegate ;
    [func setItemDatalist:items] ;
    [func setupFuncTool];
    return func ;
}



-(void)setItemDatalist:(NSArray<NSString *> *)datalist
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *string in datalist) {
        VCRFuncToolItem *item = [[VCRFuncToolItem alloc]init];
        item.itemName = string ;
        [array addObject:item];
    }
    self.datalist = array ;
}

-(CGFloat)getSubViewHeight{
    CGFloat height = (self.datalist.count+1)*44+10 ;
    if (Device()) {
        height = (self.datalist.count+1)*48+10 ;
    }
    if (self.title != nil) {
        height = height+60.0f ;
    }
    return height ;
}

-(void)setupFuncTool
{
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window] ;
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, RectW, RectH)];
    [window addSubview:backView];
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)]];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0 ;
    CGFloat height = [self getSubViewHeight];
    subView = [[VCRFuncToolView alloc]initWithFrame:CGRectMake(0,RectH,RectW, height)];
    [window addSubview:subView];
    subView.title = _title ;
    subView.delegate = self ;
    subView.backColor = self.backColor ;
    subView.tintColor = self.tintColor ;
    subView.separatorColor = self.separatorColor ;
    [subView reloadByData:self.datalist];
    
}


-(void)addFuncItem:(NSString *)name
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.itemName=%@",name];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.datalist];
    
    NSArray *filters = [self.datalist filteredArrayUsingPredicate:predicate];
    if ([filters count]) {
        return ;
    }
    
    VCRFuncToolItem *item = [[VCRFuncToolItem alloc]init];
    item.itemName = name ;
    [array addObject:item];
    self.datalist = array ;
    subView.height = [self getSubViewHeight] ;
    [subView reloadByData:self.datalist];
    
}


-(void)removeItem:(NSString *)name{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.itemName=%@",name];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.datalist];
    
    NSArray *filters = [self.datalist filteredArrayUsingPredicate:predicate];
    
    [array removeObjectsInArray:filters];
    
    self.datalist = array ;
    subView.height = [self getSubViewHeight] ;
    [subView reloadByData:self.datalist];
    
}

-(CGFloat)subViewShowHeight
{
    CGFloat height = (self.datalist.count+1)*44+10 ;
    if (Device()) {
        height = (self.datalist.count+1)*48+10 ;
    }
    return height ;
}


-(void)show{
    
    //    [subView setHeight:[self subViewShowHeight]];
    backView.hidden = false ;
    subView.hidden = false ;
    [UIView animateWithDuration:0.25 animations:^{
        if (kDevice_Is_iPhoneX) {
            [self->subView setY:RectH-self->subView.height-39];
        }else{
            [self->subView setY:RectH-self->subView.height];
        }
        
        self->backView.alpha = 0.3 ;
    }];
}

-(void)hidden{
    
    [UIView animateWithDuration:0.25 animations:^{
        [self->subView setY:RectH];
        self->backView.alpha = 0.0f ;
    }completion:^(BOOL finished) {
        self->backView.hidden = YES ;
        self->subView.hidden = YES ;
        [self->backView removeFromSuperview];
        [self->subView removeFromSuperview];
    }];
    
    if ([_delegate respondsToSelector:@selector(funcToolCancel)]) {
        [_delegate funcToolCancel];
    }
    
}

-(void)funcToolDidCancle
{
    [self hidden];
}

-(void)funcToolDidSelectAtIndex:(NSInteger)index
{
    
    [self hidden];
    VCRFuncToolItem *item = [self.datalist objectAtIndex:index];
    
    if ([_delegate respondsToSelector:@selector(funcToolItem:AtIndex:)]) {
        [_delegate funcToolItem:item AtIndex:index];
    }
    
    
}



@end

