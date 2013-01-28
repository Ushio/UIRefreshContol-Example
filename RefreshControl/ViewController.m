#import "ViewController.h"

@implementation ViewController
{
    __weak IBOutlet UITableView *tableView;
    UIRefreshControl *refleshControl;
    
    NSMutableArray *contents;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    contents = [NSMutableArray array];
    
    refleshControl = [[UIRefreshControl alloc] init];
    refleshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"update"];
    [refleshControl addTarget:self action:@selector(onBeginUpdate:) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refleshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)onBeginUpdate:(UIRefreshControl *)sender
{
    refleshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"updating"];
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString *content = [NSString stringWithFormat:@"content %d", (int)contents.count + 1];
        [contents insertObject:content atIndex:0];
        [tableView reloadData];
        [sender endRefreshing];
        refleshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"update"];
    });
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contents.count;
}

-(UITableViewCell *)tableView:(UITableView *)sender
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [sender dequeueReusableCellWithIdentifier:@"MyCell"];
    UILabel *label1 = (UILabel*)[cell viewWithTag:1];
    
    label1.text = contents[indexPath.row];
    
    return cell;
};
@end
