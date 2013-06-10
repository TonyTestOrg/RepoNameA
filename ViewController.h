//
//  ViewController.h
//  ImageImportandExport
//
//  Created by Andrews Remigius on 23/04/13.
//  Copyright (c) 2013 Andrews Remigius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController{

    NSMutableArray *dataArray;
    
}
@property (nonatomic,retain) IBOutlet UIButton *usersBtn;
@property (nonatomic,retain) IBOutlet UIButton *photosBtn;
@property (nonatomic,retain) IBOutlet UIButton *voteQuesBtn;
@property (nonatomic,retain) IBOutlet UIButton *insatllationBtn;
@property (nonatomic,retain) IBOutlet UIButton *insertUsersBtn;
@property (nonatomic,retain) IBOutlet UIButton *insertPhotosBtn;
@property (nonatomic,retain) IBOutlet UIButton *insertVoteQuesBtn;
@property (nonatomic,retain) IBOutlet UIButton *insertInstallBtn;


@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,retain) NSMutableArray *photosArray;
@property (nonatomic,retain) NSMutableArray *voteQuestionArray;


-(IBAction)getUsersTable   :(id)sender;
-(IBAction)getPhotosTable  :(id)sender;
-(IBAction)getVoteQuesTable:(id)sender;
-(IBAction)getInsatllationTable :(id)sender;


-(IBAction)insertIntoUsersTable    :(id)sender;
-(IBAction)insertIntoPhotosTable   :(id)sender;
-(IBAction)insertIntoVoteQuesTable :(id)sender;
-(IBAction)insertInstallationTable :(id)sender;


@end
