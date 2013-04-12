//
//  AGViewController.m
//  Draw
//
//  Created by Håvard Fossli on 17.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import "AGViewController.h"
#import "AGPenStroke.h"
#import "AGPointsAndVectorHelper.h"
#import "AGColorHelper.h"


@interface AGDrawView : UIView

@property (nonatomic, weak) id drawDelegate;

@end

@implementation AGDrawView

- (void)drawRect:(CGRect)rect {
    [self.drawDelegate drawRect:rect];
}

@end

@interface AGViewController ()

@property (nonatomic, strong) UITouch *currentTouch;
@property (nonatomic, strong) AGPenStroke *currentStroke;
@property (nonatomic, strong) NSMutableArray *strokes;
@property (nonatomic, strong) AGColorPalette *palette;
@property (nonatomic, strong) Class penStrokeClass;

@end

@implementation AGViewController

- (void)selectARandomPenStrokeClass {
    self.penStrokeClass = self.penStrokeClass == [AGPenStrokeBasic class] ? [AGPenStrokeVelocity class] : [AGPenStrokeBasic class];
}

- (IBAction)changeColors:(id)sender {
    
    AGColorPalette *oldPalette = self.palette;
    while (oldPalette == self.palette) {
       self.palette = [AGColorHelper pickRandomPalette];
    }
    
    for(AGPenStroke *stroke in self.strokes) {
        stroke.color = [self.palette pickRandomColor];
    }
    
    [self.view setNeedsDisplay];
}

- (IBAction)clearCanvas:(id)sender {
    
    [self selectARandomPenStrokeClass];
    
    [self.strokes removeAllObjects];
    [self.view setNeedsDisplay];
}

- (void)loadView {
        
    AGDrawView *drawView = [[AGDrawView alloc] initWithFrame:CGRectZero];
    drawView.multipleTouchEnabled = TRUE;
    drawView.drawDelegate = self;
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    clearButton.frame = CGRectMake(20, 20, 120, 44);
    [drawView addSubview:clearButton];
    [clearButton addTarget:self action:@selector(clearCanvas:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *colorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [colorButton setTitle:@"Colors" forState:UIControlStateNormal];
    colorButton.frame = CGRectMake(160, 20, 120, 44);
    [drawView addSubview:colorButton];
    [colorButton addTarget:self action:@selector(changeColors:) forControlEvents:UIControlEventTouchUpInside];

    self.view = drawView;
    
}
    

- (void)viewDidLoad {
    
    ((AGDrawView *)self.view).drawDelegate = self;
    
    self.strokes = [NSMutableArray array];
    self.palette = [AGColorHelper pickRandomPalette];
    [self selectARandomPenStrokeClass];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(self.currentTouch == nil) {
        
        self.currentTouch = [touches anyObject];
        CGPoint currentPoint = [self.currentTouch locationInView:self.view];
        
        self.currentStroke = [[self.penStrokeClass alloc] init];
        self.currentStroke.color = [self.palette.colors objectAtIndex:rand() % self.palette.colors.count];
        self.currentStroke.shadowColor = self.palette.shadowColor;
        [self.currentStroke penStrokeToPoint:currentPoint forTimeStamp:CFAbsoluteTimeGetCurrent() closePath:NO];
        [self.strokes addObject:self.currentStroke];
        
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if([touches containsObject:self.currentTouch]) {
        
        CGPoint currentPoint = [self.currentTouch locationInView:self.view];
        
        CGRect redrawRect = [self.currentStroke penStrokeToPoint:currentPoint forTimeStamp:CFAbsoluteTimeGetCurrent() closePath:NO];
        
        [self.view setNeedsDisplayInRect:redrawRect];
        
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if([touches containsObject:self.currentTouch]) {
        
        CGPoint currentPoint = [self.currentTouch locationInView:self.view];
        
        CGRect redrawRect = [self.currentStroke penStrokeToPoint:currentPoint forTimeStamp:CFAbsoluteTimeGetCurrent() closePath:NO];
        
        [self.view setNeedsDisplayInRect:redrawRect];
        
        self.currentStroke = nil;
        self.currentTouch = nil;
    }
}

- (void)drawRect:(CGRect)rect {
    
    [self.palette.backgroundColor setFill];
    [[UIBezierPath bezierPathWithRect:rect] fill];
    
    for(AGPenStroke *penStroke in self.strokes) {
        [penStroke drawRect:rect];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
