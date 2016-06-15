//
//  ViewController.m
//  HelloUploader
//
//  Created by Ricardo Nazario on 3/10/16.
//  Copyright © 2016 Ricardo Nazario. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    //NSMutableArray *_filesArray;
}

@property (weak, nonatomic) IBOutlet UITextField *IDTextfield;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSelector;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) NSURL *imageUrl;
@property (nonatomic) UIImagePickerController *imagePicker;

@end

@implementation ViewController

- (IBAction)chooseImage:(id)sender {
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

- (IBAction)saveProfile:(id)sender {
    
    NSString *selectedGender = [[NSString alloc] init];
    
    if (self.genderSelector.selectedSegmentIndex == 0) {
        selectedGender = @"male";
    } else {
        selectedGender = @"female";
    }
    
    NSLog(@"%@ is the selected gender", selectedGender);
    
    [Uploader createProfile:self.IDTextfield.text
                   withName:self.nameTextfield.text
               profileImage:self.imageUrl
                  andGender:selectedGender];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSURL *tempUrl;
    
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.png"];
    NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.jpg"];
    
    // Write image to PNG
    [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
    
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:jpgPath atomically:YES];
    
    // Create file manager
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Point to Document directory
    //NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    if (jpgPath) {
        tempUrl = [[NSURL alloc] initFileURLWithPath:jpgPath];
    } else {
        tempUrl = [[NSURL alloc] initFileURLWithPath:jpgPath];
    }
    
    self.imageUrl = tempUrl;
    
    self.imageView.image = image;
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
