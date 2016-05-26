//
//  ViewController.m
//  LeoSegmentContol
//
//  Created by leo on 16/5/26.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "ViewController.h"
#import "LeoSegmentControl.h"
@interface ViewController ()

@property (nonatomic, strong)LeoSegmentControl *segment;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _segment = [[LeoSegmentControl alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _segment.sectionTitles = @[@"第一段",@"第二段",@"第三段",@"第四段"];
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.selectionIndicatorColor = [UIColor clearColor];
    [self.view addSubview:_segment];
    [_segment setIndexChangeBlock:^(NSInteger index, NSInteger indexOld) {
        if (index == 0) {
            NSLog(@"click one");
        }else if (index == 1){
            NSLog(@"click two");
        }else if (index == 2){
            NSLog(@"click three");
        }else{
            NSLog(@"click four");
        }
        
    }];
    
    [_segment setIndexCanceledBlock:^(NSInteger index) {
        if (index == 0) {
            NSLog(@"0");
        }else if (index == 1){
            NSLog(@"1");
        }else if (index == 2){
            NSLog(@"2");
        }else if (index == 3){
            NSLog(@"3");
        }
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
