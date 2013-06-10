//
//  ViewController.m
//  ImageImportandExport
//
//  Created by Andrews Remigius on 23/04/13.
//  Copyright (c) 2013 Andrews Remigius. All rights reserved.
//

#import "ViewController.h"
#define NSStringFromBOOL(aBOOL)    aBOOL? @"YES" : @"NO"

@interface ViewController ()

@end

@implementation ViewController
@synthesize dataArray,photosArray,voteQuestionArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)getUsersTable:(id)sender{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *root = [documentsDir stringByAppendingPathComponent:@"Users.csv"];
    
    //Image file will be store in local
    NSArray *imgPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [imgPaths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"MyImageFolder"];
    
    PFQuery *getQuery = [PFQuery queryWithClassName:@"Users"];
    [getQuery findObjectsInBackgroundWithBlock:^(NSArray *usersArray, NSError *error) {
        NSString *firstName,*lastName,*phoneNumber,*userId;
        PFFile *imageFile;
        //temp = [NSString stringWithFormat:@"%@", [usersArray objectAtIndex:0]];
        NSMutableString *usersRow = [[NSMutableString alloc]init];
        for (int i = 0; i < [usersArray count]; i++) {
            
            firstName   = [[usersArray objectAtIndex:i]objectForKey:@"firstName"   ];
            lastName    = [[usersArray objectAtIndex:i]objectForKey:@"lastName"    ];
            phoneNumber = [[usersArray objectAtIndex:i]objectForKey:@"phoneNumber" ];
            userId      = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"userId"      ]];
            imageFile   = [[usersArray objectAtIndex:i]objectForKey:@"imageFile"   ];
            
            NSData *imgData = [imageFile getData];
            NSError *error;
            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
            
            NSString *fullPath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"image%d.jpg", i]]; //add our image to the path
            bool successI = [imgData writeToFile:fullPath atomically:YES];
            if (successI) {
                //        NSLog(@"Image saved correctly");
            } else
                NSLog(@"Error while saving Image");
            
            
            [usersRow appendString:firstName];
            NSLog(@"Temp string:%@",usersRow);
            [usersRow appendString:@","];
            [usersRow appendString:lastName];
            [usersRow appendString:@","];
            [usersRow appendString:phoneNumber];
            [usersRow appendString:@","];
            [usersRow appendString:userId];
            [usersRow appendString:@"\n"];
            //[usersRow appendString:imageFile];
            [usersRow writeToFile:root atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        }
        NSLog(@"Data content array:%@",usersArray);
        NSLog(@"Temp string:%@",usersRow);
        }];

    
}



-(IBAction)getPhotosTable:(id)sender{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *root = [documentsDir stringByAppendingPathComponent:@"Photos.csv"];
    
    //Image file will be store in local
    NSArray *imgPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [imgPaths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"PhotosTable"];
    
    PFQuery *getQuery = [PFQuery queryWithClassName:@"Photos"];
    [getQuery findObjectsInBackgroundWithBlock:^(NSArray *usersArray, NSError *error) {
        NSString *userId;
        PFFile *imagePhotos;
        //temp = [NSString stringWithFormat:@"%@", [usersArray objectAtIndex:0]];
        NSMutableString *usersRow = [[NSMutableString alloc]init];;
        for (int i = 0; i < [usersArray count]; i++) {
            
            
            userId      = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"userId"      ]];
            imagePhotos   = [[usersArray objectAtIndex:i]objectForKey:@"image"   ];
            
            NSData *imgData = [imagePhotos getData];
            NSError *error;
            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
            
            NSString *fullPath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"image%d.jpg", i]]; //add our image to the path
            
            bool successI = [imgData writeToFile:fullPath atomically:YES];
            if (successI) {
                NSLog(@"Image saved correctly");
            } else
                NSLog(@"Error while saving Image");
            
            [usersRow appendString:userId];
            [usersRow appendString:@"\n"];
            //[usersRow appendString:imageFile];
            [usersRow writeToFile:root atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        }
        
        }];
}

-(IBAction)getInsatllationTable:(id)sender{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
//    NSString *documentsDir = [paths objectAtIndex:0];
//    NSString *root = [documentsDir stringByAppendingPathComponent:@"Installation.csv"];
//    
//    PFQuery *getQuery = [PFInstallation query];
//    [getQuery findObjectsInBackgroundWithBlock:^(NSArray *usersArray, NSError *error) {
//        NSString *appIdentifier,*appName,*appVersion,*badge,*deviceToken,*deviceType,*InstallationId,*parseVersion,
//        *phoneNumber,*timeZone,*createdAt,*updatedAt;
//        NSMutableString *usersRow = [[NSMutableString alloc]init];;
//        for (int i = 0; i < [usersArray count]; i++) {
//            
//            
//    appIdentifier =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"appIdentifier"]];
//    appName       =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"appName"]];
//    appVersion    =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"appVersion"]];
//    badge         =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"badge"]];
//    deviceToken   =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"deviceToken"]];
//    deviceType    =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"deviceType"]];
//    InstallationId=[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"installationId"]];
//    parseVersion  =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"parseVersion"]];
//    phoneNumber   =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"phoneNumber"]];
//    timeZone      =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"timeZone"]];
//    createdAt     =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"createdAt"]];
//    updatedAt     =[NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"updatedAt"]];
//      
//                       
//            [usersRow appendString:appIdentifier];
//            [usersRow appendString:@","];
//            [usersRow appendString:appName];
//            [usersRow appendString:@","];
//            [usersRow appendString:appVersion];
//            [usersRow appendString:@","];
//            [usersRow appendString:badge];
//            [usersRow appendString:@","];
//            [usersRow appendString:deviceToken];
//            [usersRow appendString:@","];
//            [usersRow appendString:deviceType];
//            [usersRow appendString:@","];
//            [usersRow appendString:InstallationId];
//            [usersRow appendString:@","];
//            [usersRow appendString:parseVersion];
//            [usersRow appendString:@","];
//            [usersRow appendString:phoneNumber];
//            [usersRow appendString:@","];
//            [usersRow appendString:timeZone];
//            [usersRow appendString:@","];
//            [usersRow appendString:createdAt];
//            [usersRow appendString:@","];
//            [usersRow appendString:updatedAt];
//            [usersRow appendString:@"\n"];
//            //[usersRow appendString:imageFile];
//            [usersRow writeToFile:root atomically:YES encoding:NSUTF8StringEncoding error:NULL];
//        }
//        
//    }];
//
}

-(IBAction)getVoteQuesTable:(id)sender{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *root = [documentsDir stringByAppendingPathComponent:@"VoteQuestions.csv"];
    
    //Image file will be store in local
    NSArray *imgPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [imgPaths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"VoteQuestionFolder"];
    
    PFQuery *getQuery = [PFQuery queryWithClassName:@"VoteQues"];
    [getQuery orderByDescending:@"createdAt"];
    [getQuery setLimit:250];
    [getQuery findObjectsInBackgroundWithBlock:^(NSArray *usersArray, NSError *error) {
        NSString *ansOptHitcount1,*ansOptHitcount2,*ansOptHitcount3,*ansOptHitcount4,*userId,*ansOptTxt1,*ansOptTxt2,*ansOptTxt3,*ansOptTxt4,*ansType;
        NSString *frdsAnsOptHitcount1,*frdsAnsOptHitcount2,*frdsAnsOptHitcount3,*frdsAnsOptHitcount4,*frdsHitcount,*frndRateAverage,*grdVal,*hitCount,*quesId,*quesTxt,*rateAverage;
        NSString *schlAnsOptHitcount1,*schlAnsOptHitcount2,*schlAnsOptHitcount3,*schlAnsOptHitcount4;
        NSString *schlHitCount,*schlOption,*schlRateAverage,*schlVal,*target;
        Boolean userAnonym;
        PFFile *ansOptImg1,*ansOptImg2,*ansOptImg3,*ansOptImg4,*quesImg,*rateOptImg;
        //temp = [NSString stringWithFormat:@"%@", [usersArray objectAtIndex:0]];
        NSMutableString *usersRow = [[NSMutableString alloc]init];
        for (int i = 0; i < [usersArray count]; i++) {
            
            ansOptHitcount1 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"ansOptHitcount1"]];
            ansOptHitcount2 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"ansOptHitcount2"]];
            ansOptHitcount3 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"ansOptHitcount3"]];
            ansOptHitcount4 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"ansOptHitcount4"]];
            ansOptTxt1      = [[usersArray objectAtIndex:i]objectForKey:@"ansOptTxt1"];
            ansOptTxt2      = [[usersArray objectAtIndex:i]objectForKey:@"ansOptTxt2"];
            ansOptTxt3      = [[usersArray objectAtIndex:i]objectForKey:@"ansOptTxt3"];
            ansOptTxt4      = [[usersArray objectAtIndex:i]objectForKey:@"ansOptTxt4"];
            ansType         = [[usersArray objectAtIndex:i]objectForKey:@"ansType"];
            frdsAnsOptHitcount1 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"frdsAnsOptHitcount1"]];
            frdsAnsOptHitcount2 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"frdsAnsOptHitcount2"]];
            frdsAnsOptHitcount3 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"frdsAnsOptHitcount3"]];
            frdsAnsOptHitcount4 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"frdsAnsOptHitcount4"]];
            frdsHitcount    = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"frdsHitcount"]];
            frndRateAverage = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"frndRateAverage"]];
            grdVal          = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"grdVal"]];
            hitCount        = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"hitCount"]];
            quesId          = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"quesId"]];
            quesTxt         = [[usersArray objectAtIndex:i]objectForKey:@"quesTxt" ];
            rateAverage     = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"rateAverage"]];
            //rateOptImg      = [[usersArray objectAtIndex:i]objectForKey:@"rateOptImg" ];
            schlAnsOptHitcount1 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"schlAnsOptHitcount1"]];
            schlAnsOptHitcount2 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"schlAnsOptHitcount2"]];
            schlAnsOptHitcount3 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"schlAnsOptHitcount3"]];
            schlAnsOptHitcount4 = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"schlAnsOptHitcount4"]];
            schlHitCount     = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"schlHitCount"]];
            schlOption      = [[usersArray objectAtIndex:i]objectForKey:@"schlOption" ];
            schlRateAverage = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"frndRateAverage"]];
            schlVal    = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"schlVal"]];
            target     = [[usersArray objectAtIndex:i]objectForKey:@"target"    ];
            userAnonym = [[[usersArray objectAtIndex:i]objectForKey:@"userAnonym"] intValue];
            userId     = [NSString stringWithFormat:@"%@",[[usersArray objectAtIndex:i]objectForKey:@"userId"      ]];
            ansOptImg1  = [[usersArray objectAtIndex:i]objectForKey:@"ansOptImg1"  ];
            ansOptImg2  = [[usersArray objectAtIndex:i]objectForKey:@"ansOptImg2"  ];
            ansOptImg3  = [[usersArray objectAtIndex:i]objectForKey:@"ansOptImg3"  ];
            ansOptImg4  = [[usersArray objectAtIndex:i]objectForKey:@"ansOptImg4"  ];
            quesImg     = [[usersArray objectAtIndex:i]objectForKey:@"quesImg"     ];
            rateOptImg  = [[usersArray objectAtIndex:i]objectForKey:@"rateOptImg"  ];

            NSError *error;
            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
            
            if (ansOptImg1) {
               NSData *imgData        = [ansOptImg1 getData];
                NSString *fullPath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"ansOptImg1(%d).jpg", i]]; //add our image to the path
                bool successI = [imgData writeToFile:fullPath atomically:YES];
                if (successI) {
                    //        NSLog(@"Image saved correctly");
                } else
                    NSLog(@"Error while saving Image");
            }
            
            if (ansOptImg2) {
                NSData *ansOptImg2Data = [ansOptImg2 getData];
                NSString *ansOptImg2Path = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"ansOptImg2(%d).jpg", i]]; //add our image to the path
                bool successSec = [ansOptImg2Data writeToFile:ansOptImg2Path atomically:YES];
                if (successSec) {
                    //        NSLog(@"Image saved correctly");
                } else
                    NSLog(@"Error while saving Image");


            }
            if (ansOptImg3) {
                NSData *ansOptImg3Data = [ansOptImg3 getData];
                NSString *ansOptImg3Path = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"ansOptImg3%d.jpg", i]]; //add our image to the path
                bool successThird = [ansOptImg3Data writeToFile:ansOptImg3Path atomically:YES];
                if (successThird) {
                    //        NSLog(@"Image saved correctly");
                } else
                    NSLog(@"Error while saving Image");


            }
            
            if (ansOptImg4) {
                NSData *ansOptImg4Data = [ansOptImg4 getData];
                NSString *ansOptImg4Path = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"ansOptImg4%d.jpg", i]]; //add our image to the path
                bool successFourth = [ansOptImg4Data writeToFile:ansOptImg4Path atomically:YES];
                if (successFourth) {
                    //        NSLog(@"Image saved correctly");
                } else
                    NSLog(@"Error while saving Image");
            }
            if ([quesImg isKindOfClass:[NSNull class]]) {
                NSLog(@"Null image");
            }
            else if(quesImg){
                NSData *quesImgData    = [quesImg    getData];
                NSString *quesImgPath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"quesImg%d.jpg", i]]; //add our image to the path
                bool successFifth = [quesImgData writeToFile:quesImgPath atomically:YES];
                if (successFifth) {
                    //        NSLog(@"Image saved correctly");
                } else
                    NSLog(@"Error while saving Image");

            }
                
            if (rateOptImg) {
                NSData *rateImgData    = [rateOptImg    getData];
                NSString *rateImgPath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"rateOptImg%d.jpg", i]]; //add our image to the path
                bool successSixth = [rateImgData writeToFile:rateImgPath atomically:YES];
                if (successSixth) {
                    //        NSLog(@"Image saved correctly");
                } else
                    NSLog(@"Error while saving Image");
            }

            if (ansOptHitcount1) {
                [usersRow appendString:ansOptHitcount1];
              }
            [usersRow appendString:@","];
            if (ansOptHitcount2) {
                [usersRow appendString:ansOptHitcount2];

            }
            [usersRow appendString:@","];
            if (ansOptHitcount3) {
                [usersRow appendString:ansOptHitcount3];
            }
            [usersRow appendString:@","];
            if (ansOptHitcount4) {
                [usersRow appendString:ansOptHitcount4];

            }
            [usersRow appendString:@","];
            if (ansType) {
                [usersRow appendString:ansType];
            }
            [usersRow appendString:@","];
            if (ansOptTxt1) {
                [usersRow appendString:ansOptTxt1];

            }
            [usersRow appendString:@","];
            if (ansOptTxt2) {
                [usersRow appendString:ansOptTxt2];

            }
            [usersRow appendString:@","];
            if (ansOptTxt3) {
                [usersRow appendString:ansOptTxt3];

            }
            [usersRow appendString:@","];
            if (ansOptTxt4) {
                [usersRow appendString:ansOptTxt4];

            }
            [usersRow appendString:@","];
            if (frdsAnsOptHitcount1) {
                [usersRow appendString:frdsAnsOptHitcount1];

            }
            [usersRow appendString:@","];
            if (frdsAnsOptHitcount2) {
                [usersRow appendString:frdsAnsOptHitcount2];

            }
            [usersRow appendString:@","];
            if (frdsAnsOptHitcount3) {
                [usersRow appendString:frdsAnsOptHitcount3];

            }
            [usersRow appendString:@","];
            if (frdsAnsOptHitcount4) {
                [usersRow appendString:frdsAnsOptHitcount4];

            }
            [usersRow appendString:@","];
            if (frdsHitcount) {
                [usersRow appendString:frdsHitcount];

            }
            [usersRow appendString:@","];
            if (frndRateAverage) {
                [usersRow appendString:frndRateAverage];

            }
            [usersRow appendString:@","];
            if (grdVal) {
                [usersRow appendString:grdVal];

            }
            [usersRow appendString:@","];
            if (hitCount) {
                [usersRow appendString:hitCount];

            }
            [usersRow appendString:@","];
            if (quesId) {
                [usersRow appendString:quesId];

            }
            [usersRow appendString:@","];
            if (quesTxt) {
                [usersRow appendString:quesTxt];

            }
            [usersRow appendString:@","];
            if (rateAverage) {
                [usersRow appendString:rateAverage];

            }
            [usersRow appendString:@","];
            if (userAnonym) {
                [usersRow appendString: @"YES"];
            }else{
                [usersRow appendString: @"NO"];
            }
            [usersRow appendString:@","];
            if (schlAnsOptHitcount1) {
                [usersRow appendString:schlAnsOptHitcount1];

            }
            [usersRow appendString:@","];
            if (schlAnsOptHitcount2) {
                [usersRow appendString:schlAnsOptHitcount2];

            }
            [usersRow appendString:@","];
            if (schlAnsOptHitcount3) {
                [usersRow appendString:schlAnsOptHitcount3];

            }
            [usersRow appendString:@","];
            if (schlAnsOptHitcount4) {
                [usersRow appendString:schlAnsOptHitcount4];

            }
            [usersRow appendString:@","];
            if (schlHitCount) {
                [usersRow appendString:schlHitCount];

            }
            [usersRow appendString:@","];
            if (schlRateAverage) {
                [usersRow appendString:schlRateAverage];

            }
            [usersRow appendString:@","];
            if (schlOption) {
                [usersRow appendString:schlOption];

            }
            [usersRow appendString:@","];
            if (schlVal) {
                [usersRow appendString:schlVal];

            }
            [usersRow appendString:@","];
            if (target) {
                [usersRow appendString:target];

            }
            [usersRow appendString:@","];
            [usersRow appendString:userId];
            [usersRow appendString:@"\n"];
            [usersRow writeToFile:root atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        }
        NSLog(@"Data content array:%@",usersArray);
    }];


}



-(IBAction)insertIntoUsersTable:(id)sender{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Users" ofType:@"csv"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for (int id1 =0; id1 <pointStrings.count; id1++ ) {
        NSString *userstring =[pointStrings objectAtIndex:id1];
        NSArray *newQues =[userstring componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSString *userId = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:3]];
        NSString *firstName = [newQues objectAtIndex:0];
        NSString *lastName  = [newQues objectAtIndex:1];
        NSString *phoneNumber = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:2]];
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg",id1]];
        NSData *jpegImageData = UIImageJPEGRepresentation(image,1.0f);
        PFFile *imageFile = [PFFile fileWithName:@"Users.jpeg" data:jpegImageData];
        [imageFile save];
        PFObject *object = [PFObject objectWithClassName:@"Users"];
        [object setObject:[NSNumber numberWithInt:[userId intValue]] forKey:@"userId"];
        [object setObject:imageFile   forKey:@"imageFile"];
        [object setObject:firstName   forKey:@"firstName"];
        [object setObject:lastName    forKey:@"lastName"];
        [object setObject:phoneNumber forKey:@"phoneNumber"];
        [array addObject:object];
        
    }
    [PFObject saveAllInBackground:array block:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            NSLog(@"successfully added question to VoteQues");
        }
        else{
            NSLog(@"failed %@",error);
        }
        
    }];
}

-(IBAction)insertIntoPhotosTable:(id)sender{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Photos" ofType:@"csv"];
    NSError *error;
   NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *array = [[NSMutableArray alloc]init];
        
    for (int id1 =0; id1 <pointStrings.count; id1++ ) {
        //NSString *userstring =[pointStrings objectAtIndex:id1];
        //NSArray *newQues =[userstring componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSString *userId = [[NSString alloc]initWithFormat:@"%@",[pointStrings objectAtIndex:id1]];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg",id1]];
        NSData *jpegImageData = UIImageJPEGRepresentation(image,1.0f);
        PFFile *imageFile = [PFFile fileWithName:@"users.jpeg" data:jpegImageData];
        [imageFile save];
        PFObject *object = [PFObject objectWithClassName:@"Photos"];
        [object setObject:[NSNumber numberWithInt:[userId intValue]] forKey:@"userId"];
        [object setObject:imageFile forKey:@"image"];
        [array addObject:object];

        }
    [PFObject saveAllInBackground:array block:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            NSLog(@"successfully added question to VoteQues");
        }
        else{
            NSLog(@"failed %@",error);
        }
        
    }];
}

-(IBAction)insertInstallationTable:(id)sender{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Installations" ofType:@"csv"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *installArray = [[NSMutableArray alloc]init];
    
    for (int id1 =0; id1 <pointStrings.count; id1++ ) {
    }

    
}

-(IBAction)insertIntoVoteQuesTable:(id)sender{
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"VoteQuestions" ofType:@"csv"];
    NSError *error;
    
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
    
    for (int id1 =0; id1 <pointStrings.count; id1++ ) {
        NSString *pointstring =[pointStrings objectAtIndex:id1];
        NSArray *newQues =[pointstring componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
        NSString *ansOptHitcount1 = [[NSString alloc] initWithFormat:@"%@",[newQues objectAtIndex:0]];
        //NSNumber *quesId = [[NSNumber alloc] initWithInt:[[newQues objectAtIndex:1]intValue]];
        NSString*ansOptHitcount2 =[[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:1]];
        NSString *ansOptHitcount3 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:2]];
        NSString *ansOptHitcount4 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:3]];
        
        
        //NSString *ansOptImg1 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:1]];
        //NSString *ansOptImg2 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:2]];
        //NSString *ansOptImg3 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:3]];
        //NSString *ansOptImg4 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:4]];
        NSString *ansOptTxt1 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:5]];
        NSString *ansOptTxt2 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:6]];
        NSString *ansOptTxt3 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:7]];
        NSString *ansOptTxt4 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:8]];
        NSString *ansType = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:4]];

        NSString *frdsAnsOptHitcount1 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:9]];
        NSString *frdsAnsOptHitcount2 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:10]];

        NSString *frdsAnsOptHitcount3 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:11]];

        NSString *frdsAnsOptHitcount4 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:12]];
        NSString *frdsHitcount = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:13]];
        NSString *frndRateAverage = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:14]];
        NSString *grdVal = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:15]];
        NSString *hitCount = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:16]];
        NSString *quesId = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:17]];
       // NSString *quesImg = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:5]];
        NSString *quesTxt = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:18]];
        NSString *rateAverage = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:19]];
       // NSString *rateOptImg = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:6]];
        NSString *schlAnsOptHitcount1 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:21]];
        NSString *schlAnsOptHitcount2 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:22]];
        NSString *schlAnsOptHitcount3 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:23]];
        NSString *schlAnsOptHitcount4 = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:24]];
        NSString *schlHitCount = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:25]];
        NSString *schlOption = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:27]];
        NSString *schlRateAverage = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:26]];
        NSString *schlval = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:28]];
        NSString *target = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:29]];
        NSString *userAnonym = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:20]];
        NSString *userId = [[NSString alloc]initWithFormat:@"%@",[newQues objectAtIndex:30]];

        PFObject *object = [PFObject objectWithClassName:@"VoteQues"];

        if (ansOptHitcount1) {
            [object setObject:[NSNumber numberWithInt:[ansOptHitcount1 intValue]] forKey:@"ansOptHitcount1"];
        }
        if(ansOptHitcount2){
            [object setObject:[NSNumber numberWithInt:[ansOptHitcount2 intValue]] forKey:@"ansOptHitcount2"];
        }
        if (ansOptHitcount3) {
            [object setObject:[NSNumber numberWithInt:[ansOptHitcount3 intValue]] forKey:@"ansOptHitcount3"];
        }
        if (ansOptHitcount4) {
            [object setObject:[NSNumber numberWithInt:[ansOptHitcount4 intValue]] forKey:@"ansOptHitcount4"];

        }
        
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ansOptImg1(%d).jpg",id1]];
            if (image) {
            NSData *jpegImageData = UIImageJPEGRepresentation(image,1.0f);
            PFFile *imageFile = [PFFile fileWithName:@"ansOptImg1.jpeg" data:jpegImageData];
            [imageFile save];
            [object setObject:imageFile forKey:@"ansOptImg1"];

        }
        
            UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"ansOptImg2(%d).jpg",id1]];
        if (image1) {
            NSData *jpegImageData = UIImageJPEGRepresentation(image1,1.0f);
            PFFile *imageFile1 = [PFFile fileWithName:@"ansOptImg2.jpeg" data:jpegImageData];
            [imageFile1 save];
            [object setObject:imageFile1 forKey:@"ansOptImg2"];
        }
            UIImage *image2 = [UIImage imageNamed:[NSString stringWithFormat:@"ansOptImg3%d.jpg",id1]];
        if (image2) {
            NSData *jpegImageData = UIImageJPEGRepresentation(image2,1.0f);
            PFFile *imageFile2 = [PFFile fileWithName:@"ansOptImg3.jpeg" data:jpegImageData];
            [imageFile2 save];
            [object setObject:imageFile2 forKey:@"ansOptImg3"];

        }
            UIImage *image3 = [UIImage imageNamed:[NSString stringWithFormat:@"ansOptImg4%d.jpg",id1]];
        if (image3) {
            NSData *jpegImageData = UIImageJPEGRepresentation(image3,1.0f);
            PFFile *imageFile3 = [PFFile fileWithName:@"ansOptImg4.jpeg" data:jpegImageData];
            [imageFile3 save];
            [object setObject:imageFile3 forKey:@"ansOptImg4"];

        }
        if (ansOptTxt1) {
            [object setObject:ansOptTxt1 forKey:@"ansOptTxt1"];
        }
        if (ansOptTxt2) {
            [object setObject:ansOptTxt2 forKey:@"ansOptTxt2"];
        }
        if (ansOptTxt3) {
            [object setObject:ansOptTxt3 forKey:@"ansOptTxt3"];
        }
        if (ansOptTxt4) {
            [object setObject:ansOptTxt3 forKey:@"ansOptTxt4"];
        }
        if (frdsAnsOptHitcount1) {
            [object setObject:[NSNumber numberWithInt:[frdsAnsOptHitcount1 intValue]] forKey:@"frdsAnsOptHitcount1"];

        }
        if (frdsAnsOptHitcount2) {
            [object setObject:[NSNumber numberWithInt:[frdsAnsOptHitcount2 intValue]] forKey:@"frdsAnsOptHitcount2"];

        }
        if (frdsAnsOptHitcount3) {
            [object setObject:[NSNumber numberWithInt:[frdsAnsOptHitcount3 intValue]] forKey:@"frdsAnsOptHitcount3"];

        }
        if (frdsAnsOptHitcount4) {
            [object setObject:[NSNumber numberWithInt:[frdsAnsOptHitcount4 intValue]] forKey:@"frdsAnsOptHitcount4"];

        }
        if (frdsHitcount) {
            [object setObject:[NSNumber numberWithInt:[frdsHitcount intValue]] forKey:@"frdsHitcount"];

        }
        if (ansType) {
            [object setObject:ansType forKey:@"ansType"];

        }
        if (frndRateAverage) {
            [object setObject:[NSNumber numberWithInt:[frndRateAverage intValue]] forKey:@"frndRateAverage"];

        }
        if (grdVal) {
            [object setObject:[NSNumber numberWithInt:[grdVal intValue]] forKey:@"grdVal"];

        }
        if (hitCount) {
            [object setObject:[NSNumber numberWithInt:[hitCount intValue]] forKey:@"hitCount"];

        }
        if (quesId) {
            [object setObject:[NSNumber numberWithInt:[quesId intValue]] forKey:@"quesId"];

        }
            UIImage *image4 = [UIImage imageNamed:[NSString stringWithFormat:@"quesImg%d.jpg",id1]];
        if (image4) {
            NSData *jpegImageData = UIImageJPEGRepresentation(image4,1.0f);
            PFFile *imageFile4 = [PFFile fileWithName:@"quesImg.jpeg" data:jpegImageData];
            [imageFile4 save];
            [object setObject:imageFile4 forKey:@"quesImg"];

        }
        if (quesTxt) {
            [object setObject:quesTxt forKey:@"quesTxt"];

        }
        if (rateAverage) {
            [object setObject:[NSNumber numberWithInt:[rateAverage intValue]] forKey:@"rateAverage"];

        }
        UIImage *image5 = [UIImage imageNamed:[NSString stringWithFormat:@"rateOptImg%d.jpg",id1]];
        if (image5) {
            NSData *jpegImageData = UIImageJPEGRepresentation(image5,1.0f);
            PFFile *imageFile5 = [PFFile fileWithName:@"rateOptImg.jpeg" data:jpegImageData];
            [imageFile5 save];
            [object setObject:imageFile5 forKey:@"rateOptImg"];

        }
        if (schlAnsOptHitcount1) {
            [object setObject:[NSNumber numberWithInt:[schlAnsOptHitcount1 intValue]] forKey:@"schlAnsOptHitcount1"];

        }
        if (schlAnsOptHitcount2) {
            [object setObject:[NSNumber numberWithInt:[schlAnsOptHitcount2 intValue]] forKey:@"schlAnsOptHitcount2"];

        }
        if (schlAnsOptHitcount3) {
            [object setObject:[NSNumber numberWithInt:[schlAnsOptHitcount3 intValue]] forKey:@"schlAnsOptHitcount3"];

        }
        if (schlAnsOptHitcount4) {
            [object setObject:[NSNumber numberWithInt:[schlAnsOptHitcount4 intValue]] forKey:@"schlAnsOptHitcount4"];

        }
        if (schlHitCount) {
            [object setObject:[NSNumber numberWithInt:[schlHitCount intValue]] forKey:@"schlHitCount"];

        }
        if (schlOption) {
            [object setObject:schlOption forKey:@"schlOption"];

        }
        if (schlRateAverage) {
            [object setObject:[NSNumber numberWithInt:[schlRateAverage intValue]] forKey:@"schlRateAverage"];

        }
        if (schlval) {
            [object setObject:[NSNumber numberWithInt:[schlval intValue]] forKey:@"schlVal"];

        }
        if (target) {
            [object setObject:target forKey:@"target"];

        }
        if (userAnonym) {
            [object setObject:[NSNumber numberWithBool:[userAnonym boolValue]] forKey:@"userAnonym"];

        }
        [object setObject:[NSNumber numberWithInt:[userId intValue]] forKey:@"userId"];
        
        [array1 addObject:object];
    }[PFObject saveAllInBackground:array1 block:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            NSLog(@"successfully added question to VoteQues");
        }
        else{
            NSLog(@"failed %@",error);
        }
        
    }];
}



//}

@end
