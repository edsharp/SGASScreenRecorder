//
//  SGASViewController.m
//  SGASScreenRecorder
//
//  Created by Alexander Gusev on 10/22/2014.
//  Copyright (c) 2014 Alexander Gusev. All rights reserved.
//

#import "SGASTableViewController.h"
#import "SGASScreenRecorderUIManager.h"
#import "SGASWebViewController.h"

@interface SGASTableViewController () {
    SGASScreenRecorderUIManager *_screenRecorderUIManager;
    NSArray *_goodReadsTitles;
    NSDictionary *_goodReadsURLs;
}

@end

static NSString * const kCellReuseIdentifier = @"objc";

@implementation SGASTableViewController

#pragma mark - Init/dealloc

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initializeGoodReads];
        self.title = NSLocalizedString(@"Good Reads", nil);
        _screenRecorderUIManager = [[SGASScreenRecorderUIManager alloc] initWithScreenCorner:UIRectCornerTopRight];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Toggle", nil)
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(toggleButtonAction)];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kCellReuseIdentifier];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Actions

- (void)toggleButtonAction {
    _screenRecorderUIManager.enabled = !_screenRecorderUIManager.enabled;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)[_goodReadsTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier
                                                            forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _goodReadsTitles[(NSUInteger)[indexPath row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url = _goodReadsURLs[_goodReadsTitles[(NSUInteger)[indexPath row]]];
    [self.navigationController pushViewController:[[SGASWebViewController alloc] initWithURL:url]
                                         animated:YES];
}

#pragma mark - Private

- (void)initializeGoodReads {
    _goodReadsTitles = @[@"objc.io",
                         @"NSHipster",
                         @"NSBlog"];
    _goodReadsURLs = @{@"objc.io": [NSURL URLWithString:@"http://www.objc.io"],
                       @"NSHipster": [NSURL URLWithString:@"http://nshipster.com"],
                       @"NSBlog": [NSURL URLWithString:@"https://www.mikeash.com/pyblog/"]};
}

@end
