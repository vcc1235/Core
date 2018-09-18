//
//  VCRDataSource.h
//  KJZTool
//
//  Created by alete on 2018/8/29.
//  Copyright © 2018 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);

@interface VCRDataSource : NSObject <UITableViewDataSource,UICollectionViewDataSource>

@property (nonatomic, strong)  NSMutableArray *dataArray;;

//自定义
- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before;

//sb
@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;

@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;



- (void)addDataArray:(NSArray *)datas;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;



@end

NS_ASSUME_NONNULL_END
