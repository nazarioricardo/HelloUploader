//
//  UploadAudioViewController.m
//  HelloUploader
//
//  Created by Ricardo Nazario on 4/13/16.
//  Copyright © 2016 Ricardo Nazario. All rights reserved.
//

#import "UploadAudioViewController.h"

@interface UploadAudioViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ownerTextField;

@property (weak, nonatomic) IBOutlet UITextField *levelTextField;
@property (weak, nonatomic) IBOutlet UITextField *lineNumberTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation UploadAudioViewController

- (IBAction)uploadPressed:(id)sender {
    [self uploadLine:NO];
}
- (IBAction)uploadBatchPressed:(id)sender {
    [self uploadLine:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.indicatorView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)uploadLine:(BOOL)batch {
    
    [self shouldAnimateIndicator:YES];
    
    NSString *lineID = [NSString stringWithFormat:@"%@%@%@", _ownerTextField.text, _levelTextField.text, _lineNumberTextField.text];
    NSURL *audioURL = [[NSBundle mainBundle] URLForResource:lineID withExtension:@"mp3"];
    
    if (audioURL) {
        
        [Uploader saveLine:lineID
                   profile:_ownerTextField.text
                     level:_levelTextField.text
                       url:audioURL
     withCompletionHandler:^(CKRecord *savedRecord, NSError *error) {
         
         if (!error) {
             NSLog(@"%@ saved succesfully", savedRecord.recordID);
             
             NSInteger ln = [_lineNumberTextField.text integerValue];
             ln++;
             _lineNumberTextField.text = [NSString stringWithFormat:@"%ld", (long)ln];
             
             if (batch) {
                 [self uploadLine:batch];
             } else {
                 [self shouldAnimateIndicator:NO];
             }
             
         } else {
             NSLog(@"%@", error);
             
             NSString *errorMsg = [NSString stringWithFormat:@"%@", error];
             
             UIAlertController *alert = [UIAlertController
                                         alertControllerWithTitle:NSLocalizedString(@"Error!", nil)
                                         message:errorMsg
                                         preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Okay"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [alert dismissViewControllerAnimated:YES
                                                                                      completion:nil];
                                                        }];
             
             [alert addAction:ok];
             
             [self presentViewController:alert animated:YES completion:nil];
             
             [self shouldAnimateIndicator:NO];
         }
         
     }];
        
    } else {
        
        NSLog(@"Invalid URL");
        [self shouldAnimateIndicator:NO];
    }
}

- (void)shouldAnimateIndicator:(BOOL)animate {
    if (animate) {
        self.indicatorView.hidden = NO;
        [self.indicatorView startAnimating];
    } else {
        self.indicatorView.hidden = YES;
        [self.indicatorView stopAnimating];
    }
    self.view.userInteractionEnabled = !animate;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
