//
//  ViewController.h
//  Picker
//
//  Created by Motoi Hirata on 2013/11/11.
//  Copyright (c) 2013年 Motoi Hirata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)albumButtonTap:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIToolbar *cameraButton;
- (IBAction)cameraButtonTap:(id)sender;
@end
