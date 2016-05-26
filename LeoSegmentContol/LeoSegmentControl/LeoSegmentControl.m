//
//  LeoSegmentControl.m
//  LeoSegmentContol
//
//  Created by leo on 16/5/26.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "LeoSegmentControl.h"
#import <QuartzCore/QuartzCore.h>

@interface LeoSegmentControl()

@property (nonatomic, strong)CALayer * selectedSegmentLayer;
@property (nonatomic, readwrite)CGFloat segmentWidth;

@end


@implementation LeoSegmentControl

 - (instancetype)initWithFrame:(CGRect)frame{
     self = [super initWithFrame:frame];
     if (self) {
         [self setDefaults];
     }
     return self;
}

- (id)initWithSectionTitles:(NSArray *)sectiontitles
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.sectionTitles = [NSMutableArray arrayWithArray:sectiontitles];
        
        self.imgNormal = [UIImage imageNamed:@"segDownArrow"];
        self.imgSelected = [UIImage imageNamed:@"segUpArrow"];
        [self setDefaults];
    }
    
    return self;
}

- (void)changeSectionTitle:(NSString *)nssTitle ofSection:(NSInteger)iSection{
    if (self.sectionTitles && iSection < [self.sectionTitles count] && nssTitle && (NSNull*)nssTitle != [NSNull null]) {
        [self.sectionTitles replaceObjectAtIndex:iSection withObject:nssTitle];
        [self setNeedsDisplay];
    }
}

- (void)setDefaults{
    self.font = [UIFont systemFontOfSize:15];
    self.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:0.8];// [UIColor colorWithRed:83 green:83 blue:82 alpha:1.0];
    self.textSelectedColor = [UIColor colorWithRed:35/255.0 green:189/255.0 blue:57/255.0 alpha:1.0];
    self.backgroundColor = [UIColor whiteColor];
    self.selectionIndicatorColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    
    self.selectedIndex = -1;
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.height = 32.0f;
    self.selectionIndicatorHeight = 2.0f;
    self.selectionIndicatorMode = HMSelectionIndicatorResizesToStringWidth;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, [self bounds]);
    // 画底线
    CGPoint pt1;
    CGPoint pt2;
    
    pt1.x = 0;
    pt2.y = 0;
    pt2.x = rect.size.width;
    pt2.y = 0;
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:217.f/255.0f green:217.0/255.0f blue:217.0/255.0f alpha:0.5] CGColor]);
    
    CGContextMoveToPoint(context, pt1.x, pt1.y);
    CGContextAddLineToPoint(context, pt2.x, pt2.y);//画曲线用CGContextAddArc
    CGContextStrokePath(context);
    
    [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
        CGFloat stringHeight = [titleString sizeWithFont:self.font].height;
        CGFloat y = ((self.height - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - stringHeight / 2);
        CGRect rcItem = CGRectMake(self.segmentWidth * idx, y, self.segmentWidth, rect.size.height);
        
        //绘制分割竖线
        if (idx < [self.sectionTitles count]-1) {
            CGPoint pt1;
            CGPoint pt2;
            
            pt1.x = rcItem.origin.x + rcItem.size.width;
            pt1.y = 4;
            pt2.x = pt1.x;
            pt2.y = rect.size.height - 4;
            
            CGContextSetLineWidth(context, 1.0);
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:217.f/255.0f green:217.0/255.0f blue:217.0/255.0f alpha:1.0] CGColor]);
            CGContextMoveToPoint(context, pt1.x, pt1.y);
            CGContextAddLineToPoint(context, pt2.x, pt2.y);
            CGContextStrokePath(context);
        }
        
        if (idx == self.selectedIndex && idx != -1) {//选中的item
            //self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
            //self.selectedSegmentLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
            //[self.layer addSublayer:self.selectedSegmentLayer];
            
            CGPoint pt1;
            CGPoint pt2;
            pt1.x = rcItem.origin.x;
            pt1.y = rect.size.height;
            pt2.x = pt1.x+rcItem.size.width;
            pt2.y = pt1.y;
            
            //绘制三角
            //drawing the border with arrow
            CGFloat fAW = 8;
            CGFloat fAH = 4;
            
            CGPoint ptL;
            ptL.x = rcItem.origin.x + rcItem.size.width/2 - fAW/2;
            ptL.y = pt1.y;
            CGPoint ptT;
            ptT.x = ptL.x + fAW/2;
            ptT.y = ptL.y - fAH;
            
            CGPoint ptR;
            ptR.x = ptL.x + fAW;
            ptR.y = ptL.y;
            
            CGContextSetLineWidth(context, 1.0);
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:217.f/255.0f green:217.0/255.0f blue:217.0/255.0f alpha:1.0] CGColor]);
            
            CGContextMoveToPoint(context, pt1.x, pt1.y);
            
            CGContextAddLineToPoint(context, ptL.x, ptL.y);
            
            CGContextAddLineToPoint(context, ptT.x, ptT.y);
            
            CGContextAddLineToPoint(context, ptR.x, ptR.y);
            
            CGContextAddLineToPoint(context, pt2.x, pt2.y);
            CGContextStrokePath(context);
            
            //设置画笔线条粗细
            CGContextSetLineWidth(context, 1.0);
            CGContextSetFillColorWithColor(context, self.textSelectedColor.CGColor);
            
            NSMutableParagraphStyle * paragraphStyle= [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            
            NSDictionary * dicTextAttri = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, self.textSelectedColor, NSForegroundColorAttributeName, paragraphStyle, NSParagraphStyleAttributeName, nil];
            
            CGFloat fTextAndImgW = 0;
            CGFloat fImgW = 0;
            CGFloat fImgH = 0;
            if (self.imgSelected) {
                fImgW = self.imgSelected.size.width;
                fImgH = self.imgSelected.size.height;
            }
            
            CGFloat fTextX = 0;
            CGFloat fTextY = 0;
            CGFloat fTextW = 0;
            CGFloat fTextH = 0;
            if (titleString) {
                CGSize szText = [titleString sizeWithAttributes:dicTextAttri];
                fTextW = szText.width;
                fTextH = szText.height;
                
                fTextAndImgW = fTextW + fImgW + 5;
                if (fTextAndImgW >= rcItem.size.width) {
                    fTextW = rcItem.size.width - fImgW - 10;
                    fTextAndImgW = fTextW + fImgW + 5;
                }
                
                fTextX = rcItem.origin.x+(rcItem.size.width-fTextAndImgW)/2;
                fTextY = (rcItem.size.height-fTextH)/2;
                CGRect rcText = CGRectMake(fTextX, fTextY, fTextW, fTextH);
                [titleString drawInRect:rcText withAttributes:dicTextAttri];
            }
            
            
            if (self.imgSelected) {
                CGFloat fImgX = fTextX + fTextW + 5;
                CGFloat fImgY = (rcItem.size.height-fImgH)/2;
                
                [self.imgSelected drawInRect:CGRectMake(fImgX, fImgY, fImgW, fImgH)];
            }
            
        }
        else
        {
            CGPoint pt1;
            CGPoint pt2;
            pt1.x = rcItem.origin.x;
            pt1.y = rect.size.height;
            pt2.x = pt1.x+rcItem.size.width;
            pt2.y = pt1.y;
            
            CGContextSetLineWidth(context, 1.0);
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:217.f/255.0f green:217.0/255.0f blue:217.0/255.0f alpha:1.0] CGColor]);
            CGContextMoveToPoint(context, pt1.x, pt1.y);
            CGContextAddLineToPoint(context, pt2.x, pt2.y);
            CGContextStrokePath(context);
            
            //设置画笔线条粗细
            CGContextSetLineWidth(context, 1.0);
            CGContextSetFillColorWithColor(context, self.textColor.CGColor);
            
            NSMutableParagraphStyle * paragraphStyle= [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            
            NSDictionary * dicTextAttri = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, self.textColor, NSForegroundColorAttributeName, paragraphStyle, NSParagraphStyleAttributeName, nil];
            
            CGFloat fTextAndImgW = 0;
            CGFloat fImgW = 0;
            CGFloat fImgH = 0;
            if (self.imgSelected) {
                fImgW = self.imgSelected.size.width;
                fImgH = self.imgSelected.size.height;
            }
            
            CGFloat fTextX = 0;
            CGFloat fTextY = 0;
            CGFloat fTextW = 0;
            CGFloat fTextH = 0;
            if (titleString) {
                CGSize szText = [titleString sizeWithAttributes:dicTextAttri];
                fTextW = szText.width;
                fTextH = szText.height;
                
                fTextAndImgW = fTextW + fImgW + 5;
                if (fTextAndImgW >= rcItem.size.width) {
                    fTextW = rcItem.size.width - fImgW - 10;
                    fTextAndImgW = fTextW + fImgW + 5;
                }
                
                fTextX = rcItem.origin.x+(rcItem.size.width-fTextAndImgW)/2;
                fTextY = (rcItem.size.height-fTextH)/2;
                CGRect rcText = CGRectMake(fTextX, fTextY, fTextW, fTextH);
                
                [titleString drawInRect:rcText withAttributes:dicTextAttri];
            }
            
            
            if (self.imgNormal) {
                CGFloat fImgX = fTextX + fTextW + 5;
                CGFloat fImgY = (rcItem.size.height-fImgH)/2;
                
                [self.imgNormal drawInRect:CGRectMake(fImgX, fImgY, fImgW, fImgH)];
            }
        }
        
        
        
    }];

    
}

- (CGRect)frameForSelectionIndicator {
    CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedIndex] sizeWithFont:self.font].width;
    
    if (self.selectionIndicatorMode == HMSelectionIndicatorResizesToStringWidth) {
        CGFloat widthTillEndOfSelectedIndex = (self.segmentWidth * self.selectedIndex) + self.segmentWidth;
        CGFloat widthTillBeforeSelectedIndex = (self.segmentWidth * self.selectedIndex);
        
        CGFloat x = ((widthTillEndOfSelectedIndex - widthTillBeforeSelectedIndex) / 2) + (widthTillBeforeSelectedIndex - stringWidth / 2);
        return CGRectMake(x, self.height - self.selectionIndicatorHeight, stringWidth, self.selectionIndicatorHeight);
    } else {
        return CGRectMake(self.segmentWidth * self.selectedIndex, self.height - self.selectionIndicatorHeight, self.segmentWidth, self.selectionIndicatorHeight);
    }
}

-(void)updateSegmentsRects {
    // If there's no frame set, calculate the width of the control based on the number of segments and their size
    if (CGRectIsEmpty(self.frame)) {
        self.segmentWidth = 0;
        
        for (NSString *titleString in self.sectionTitles) {
            CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
            self.segmentWidth = MAX(stringWidth, self.segmentWidth);
        }
        
        self.bounds = CGRectMake(0, 0, self.segmentWidth * self.sectionTitles.count, self.height);
    } else {
        self.segmentWidth = self.frame.size.width / self.sectionTitles.count;
        self.height = self.frame.size.height;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // Control is being removed
    if (newSuperview == nil)
        return;
    
    [self updateSegmentsRects];
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment = touchLocation.x / self.segmentWidth;
        
        [self changeSelectItem:segment oldItem:self.selectedIndex animated:YES];
        /*
         if (segment != self.selectedIndex) {
         if (self.indexChangeBlock)
         self.indexChangeBlock(segment, self.selectedIndex);
         [self setSelectedIndex:segment animated:YES];
         [self setNeedsDisplay];
         }
         else
         {
         if (self.indexCanceledBlock) {
         self.indexCanceledBlock(segment);
         [self setSelectedIndex:-1 animated:YES];
         [self setNeedsDisplay];
         }
         }
         */
    }
}

#pragma mark -
- (void)setSelectedIndex:(NSInteger)index {
    _selectedIndex = index;
    [self changeSelectItem:index oldItem:self.selectedIndex animated:YES];
    //[self setSelectedIndex:index animated:NO];
    
}

-(void)changeSelectItem:(NSInteger)indexCur oldItem:(NSInteger)indexSelected animated:(BOOL)animated
{
    if (indexCur != self.selectedIndex && indexCur != -1) {//改变
        if (self.indexChangeBlock)
            self.indexChangeBlock(indexCur, indexSelected);
        [self setSelectedIndex:indexCur animated:YES];
        [self setNeedsDisplay];
    }
    else if (indexCur == -1)//取消选择
    {
        if (self.indexCanceledBlock) {
            self.indexCanceledBlock(self.selectedIndex);
        }
        
        [self setSelectedIndex:-1 animated:YES];
        [self setNeedsDisplay];
    }
    else//取消
    {
        if (self.indexCanceledBlock) {
            self.indexCanceledBlock(indexCur);
        }
        [self setSelectedIndex:-1 animated:YES];
        [self setNeedsDisplay];
    }
}

- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated {
    
    if (-1 == index) {
        if (self.indexCanceledBlock) {
            self.indexCanceledBlock(self.selectedIndex);
        }
    }
    
    _selectedIndex = index;
    
    if (animated) {
        // Restore CALayer animations
        //self.selectedSegmentLayer.actions = nil;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.15f];
        [CATransaction setCompletionBlock:^{
            if (self.superview)
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            /*
             if (self.indexChangeBlock)
             self.indexChangeBlock(index, 0);
             */
        }];
        //self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        [CATransaction commit];
    } else {
        // Disable CALayer animations
        NSMutableDictionary * newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
        //self.selectedSegmentLayer.actions = newActions;
        
        //self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        
        if (self.superview)
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        /*
         if (self.indexChangeBlock)
         self.indexChangeBlock(index, 0);
         */
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.sectionTitles)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (self.sectionTitles)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
