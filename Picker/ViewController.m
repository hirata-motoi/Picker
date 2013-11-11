//
//  ViewController.m
//  Picker
//
//  Created by Motoi Hirata on 2013/11/11.
//  Copyright (c) 2013年 Motoi Hirata. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) UIImagePickerControllerSourceType sourceType;
- (UIImagePickerController *)createImagePicker;


@end

@implementation ViewController
@synthesize imageView;
@synthesize cameraButton;
@synthesize sourceType;

- (UIImagePickerController *)createImagePicker
{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self] ;
    imagePicker.sourceType = self.sourceType;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        // camera
        imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                 UIImagePickerControllerSourceTypeCamera];
        imagePicker.allowsEditing = YES;
    }
    else {
        imagePicker.allowsEditing = NO;
    }
    return imagePicker;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // check camara availability
    //if ( ! [UIImagePickerControllerisSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    //    [self.cameraButton setEnabled:NO];
    //}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonTap:(id)sender {
    if (self.imageView.isAnimating) {
        [self.imageView stopAnimating];
    }
    
    // create UIImagePicker
    self.sourceType = UIImagePickerControllerSourceTypeCamera ;
    UIImagePickerController * imagePicker = [self createImagePicker] ;
    
    //UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init] ;
    //[imagePicker setDelegate:self] ;
    //imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //imagePicker.allowsEditing = YES;
    //imagePicker.mediaTypes = [UIImagePickerController
    //    availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentModalViewController:imagePicker animated:YES];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare(
                        (__bridge CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        UIImage * editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        UIImage * originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage * imageToSave;
        
        if (editedImage) {
            imageToSave = editedImage;
        }
        else {
            imageToSave = originalImage;
        }
        
        [self.imageView setImage:imageToSave];
        
        if ( self.sourceType == UIImagePickerControllerSourceTypeCamera ) {
            UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil) ;
        }
        
    }
    
    if (CFStringCompare((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSString *moviePath = [[info objectForKey: UIImagePickerControllerMediaURL] path];
        
        [self.imageView setImage:[UIImage imageNamed:@"baby1.JPG"]];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, nil, nil, nil);
        }
    }
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (IBAction)albumButtonTap:(id)sender {
    if (self.imageView.isAnimating) {
        [self.imageView stopAnimating];
    }
    
    // create ImagePicker
    self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
    UIImagePickerController * imagePicker = [self createImagePicker] ;
    
    // modal
    [self presentModalViewController:imagePicker animated:YES];
}

@end

































