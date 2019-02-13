//
//  FQMenuView.h
//  FQWechatAppletDemo
//
//  Created by mac on 2019/2/13.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "FQStickyHeaderView.h"

NS_ASSUME_NONNULL_BEGIN
@class FQMenuView;
@protocol FQMenuViewDelegate <NSObject>

- (void)menuViewStatusChanged:(BOOL)status;

@end

@interface FQMenuView : FQStickyHeaderView

/** 代理 */
@property (nonatomic, weak) id <FQMenuViewDelegate > delegate;



@end

NS_ASSUME_NONNULL_END
