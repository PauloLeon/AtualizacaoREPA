//
//  MainViewController.m
//  ARSSReader
//
//  Created by Caio Borsoi on 3/10/14.
//  Copyright (c) 2014 Underplot ltd. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface MainViewController ()
{
    NSMutableArray *photos;
    NSTimer *timer;
    int currentImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *slide;
@property (weak, nonatomic) IBOutlet UIWebView *webProximoJogo;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //porra
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _webProximoJogo.hidden= YES;
    NSURL *url1 = [NSURL URLWithString:@"http://localhost:8888/photos/proximo_jogo.png"];
    NSURLRequest* articleRequest = [NSURLRequest requestWithURL:url1];
    _webProximoJogo.backgroundColor = [[UIColor alloc]initWithRed:15 green:26 blue:48 alpha:1.0];
    [_webProximoJogo loadRequest: articleRequest];
    
    self.title = @"Início";
    
    // Change button color
    _barButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
     photos = [[NSMutableArray alloc] init];
    
    NSXMLParser *photoParser = [[NSXMLParser alloc]
                                 initWithContentsOfURL:[NSURL URLWithString:
                                                        @"http://localhost:8888/index.xml"]];
    [photoParser setDelegate:self];
    [photoParser parse];
    
    currentImage = 0;
    
    NSURL *imageURL = [NSURL URLWithString:[photos objectAtIndex:0]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    [_slide setImage:[UIImage imageWithData:imageData]];
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 2.0
                                             target: self
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
    
<<<<<<< HEAD
    NSURL *url1 = [NSURL URLWithString:@"http://localhost:8888/photos/proximo_jogo.png"];
    NSURLRequest* articleRequest = [NSURLRequest requestWithURL:url1];
    _webProximoJogo.backgroundColor = [UIColor clearColor];
    [_webProximoJogo loadRequest: articleRequest];
=======
    if (_webProximoJogo.isLoading==NO) {
        _webProximoJogo.hidden= NO;
    }
>>>>>>> FETCH_HEAD
    
}

- (void) handleTimer: (NSTimer *) timer {
    currentImage++;
    if ( currentImage >= photos.count )
        currentImage = 0;
    
    NSURL *imageURL = [NSURL URLWithString:[photos objectAtIndex:currentImage]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    [_slide setImage:[UIImage imageWithData:imageData]];
    //[self fadeInImage];
}

- (void)fadeInImage
{
    if (_slide.alpha == 0) {
        _slide.alpha =1.0;
    }
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:4.0];
    _slide.alpha = 0;
    [UIView commitAnimations];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    if ( [elementName isEqualToString:@"photo"]) {
        [photos addObject:[attributeDict objectForKey:@"url"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
