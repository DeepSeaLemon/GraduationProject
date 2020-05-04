//
//  GPStatisticsTableHeaderView.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPStatisticsTableHeaderView.h"
#import "GPAccountMonthModel.h"

@interface GPStatisticsTableHeaderView ()<ChartViewDelegate>

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *payLabel;
@property (nonatomic, strong) UILabel *incomeLabel;

@property (nonatomic, strong) UILabel *payTextLabel;
@property (nonatomic, strong) UILabel *incomeTextLabel;

@property (nonatomic, strong) UILabel *yearLabel;

@property (nonatomic, strong) UIView *statisticsView;

@property (nonatomic, strong) BarChartView *barChartView;

@end

@implementation GPStatisticsTableHeaderView

- (void)setPayMoney:(double)pay incomeMoney:(double)income year:(NSInteger)year {
    self.payLabel.text = [NSString stringWithFormat:@"¥%0.2f",(0 - pay)];
    self.incomeLabel.text = [NSString stringWithFormat:@"¥%0.2f",income];
    self.yearLabel.text = [NSString stringWithFormat:@"%ld年",(long)year];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = GPBackgroundColor;
        [self initUI];
    }
    return self;
}

- (void)refreshBarChartViewWithArray:(NSMutableArray *)arr{
    self.barChartView.data = [self setDataWithArray:arr];
    [self.barChartView.viewPortHandler setMinimumScaleX:1.5f];
    [self.barChartView animateWithYAxisDuration:1.0f];
    [self.barChartView setVisibleXRangeMaximum:6];
}

- (BarChartData *)setDataWithArray:(NSMutableArray *)arr{
    int xVals_count = 12;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
    }
    self.barChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xVals];
    
    // 支出
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 1; i <= xVals_count; i++) {
        __block double val = 0;
        [arr enumerateObjectsUsingBlock:^(GPAccountMonthModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.month == i) {
                val = 0 - obj.payMoney;
            }
        }];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i-1 y:val];
        [yVals addObject:entry];
    }
    
    // 收入
    NSMutableArray *yValsTwo = [[NSMutableArray alloc] init];
    for (int i = 1; i <= xVals_count; i++) {
        __block double val = 0;
        [arr enumerateObjectsUsingBlock:^(GPAccountMonthModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.month == i) {
                val = obj.incomeMoney;
            }
        }];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i-1 y:val];
        [yValsTwo addObject:entry];
    }
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:nil];
    set1.barBorderWidth = 0;//边学宽
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = YES;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    [set1 setColors:@[[UIColor blackColor]]];//设置柱形图颜色
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithEntries:yValsTwo label:nil];
    set2.barBorderWidth = 0;//边学宽
    set2.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set2.highlightEnabled = YES;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    [set2 setColors:@[GPDeepGrayColor]];
    
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    //设置宽度   柱形之间的间隙占整个柱形(柱形+间隙)的比例
    [data setBarWidth:0.4];
    [data groupBarsFromX: -0.5 groupSpace: 0.2 barSpace: 0];
    [data setValueFont:[UIFont systemFontOfSize:9]];//文字字体
    [data setValueTextColor:[UIColor blackColor]];//文字颜色
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    ChartDefaultValueFormatter *forma = [[ChartDefaultValueFormatter alloc] initWithFormatter:formatter];
    [data setValueFormatter:forma];
    return data;
}

- (void)initUI {
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(70);
    }];
    
    [self addSubview:self.statisticsView];
    [self.statisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.backView.mas_bottom).offset(15);
        make.height.mas_equalTo(220);
    }];
    
    [self.statisticsView addSubview:self.barChartView];
    [self.barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.backView addSubview:self.payTextLabel];
    [self.payTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
    }];
    
    [self.backView addSubview:self.payLabel];
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.backView addSubview:self.yearLabel];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.backView);
    }];
    
    [self.backView addSubview:self.incomeTextLabel];
    [self.incomeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(10);
    }];
    
    [self.backView addSubview:self.incomeLabel];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-10);
    }];
    
    
}

#pragma mark - lazy

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5.0f;
    }
    return _backView;
}


- (UILabel *)payTextLabel {
    if (!_payTextLabel) {
        _payTextLabel = [[UILabel alloc] init];
        _payTextLabel.textColor = [UIColor blackColor];
        _payTextLabel.font = [UIFont systemFontOfSize:15];
        _payTextLabel.text = @"总支出";
    }
    return _payTextLabel;
}

- (UILabel *)incomeTextLabel {
    if (!_incomeTextLabel) {
        _incomeTextLabel = [[UILabel alloc] init];
        _incomeTextLabel.textColor = [UIColor blackColor];
        _incomeTextLabel.font = [UIFont systemFontOfSize:15];
        _incomeTextLabel.text = @"总收入";
    }
    return _incomeTextLabel;
}

- (UILabel *)payLabel {
    if (!_payLabel) {
        _payLabel = [[UILabel alloc] init];
        _payLabel.textColor = [UIColor blackColor];
        _payLabel.font = [UIFont systemFontOfSize:19];
        _payLabel.text = @"¥5000";
    }
    return _payLabel;
}

- (UILabel *)incomeLabel {
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc] init];
        _incomeLabel.textColor = [UIColor blackColor];
        _incomeLabel.font = [UIFont systemFontOfSize:19];
        _incomeLabel.text = @"¥1000";
    }
    return _incomeLabel;
}

- (UILabel *)yearLabel {
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc] init];
        _yearLabel.font = [UIFont systemFontOfSize:19];
        _yearLabel.textColor = [UIColor blackColor];
        _yearLabel.text = @"2020年";
    }
    return _yearLabel;
}

- (UIView *)statisticsView {
    if (!_statisticsView) {
        _statisticsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _statisticsView.backgroundColor = [UIColor whiteColor];
    }
    return _statisticsView;
}

- (BarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[BarChartView alloc] init];
        _barChartView.delegate = self;
        _barChartView.frame = CGRectZero;
        _barChartView.backgroundColor = [UIColor clearColor];
        _barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
        _barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
        _barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
        _barChartView.userInteractionEnabled = YES;
        _barChartView.scaleYEnabled = NO;//取消Y轴缩放
        _barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _barChartView.dragEnabled = YES;//启用拖拽图表
        _barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        ChartXAxis *xAxis = _barChartView.xAxis;
        xAxis.axisLineWidth = 1;//设置X轴线宽
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
        xAxis.labelTextColor = [UIColor blackColor];//label文字颜色
        xAxis.labelFont = [UIFont systemFontOfSize:9];
        
        ChartYAxis *leftAxis = _barChartView.leftAxis;//获取左边Y轴
        leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0;//Y轴线宽
        leftAxis.forceLabelsEnabled = YES;
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        leftAxis.axisMinimum = 0;
        leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
        leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
        leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
        
        _barChartView.rightAxis.enabled = NO;
        _barChartView.legend.enabled = NO;//不显示图例说明
    }
    return _barChartView;
}
@end
