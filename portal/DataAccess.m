//
//  DataAccess.m
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "DataAccess.h"

@implementation DataAccess



#pragma mark - Account Methods

- (BOOL)UserIsLoggedIn {
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"]) {
        return YES;
    }
    return NO;
}

- (void)setUserLoginStatus:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"isLoggedIn"];
}

- (void)setProfileImageStatus:(BOOL)status {
    DataAccess *Data = [DataAccess singletonInstance];
    Data.isProfileImageSet = status;
    [Data persistToUserDefaults];
}

- (BOOL)ProfileImageIsSet {
    DataAccess *Data = [DataAccess singletonInstance];
    return Data.isProfileImageSet;
}

- (void)setProfileImageStatus2:(BOOL)status {
    DataAccess *Data = [DataAccess singletonInstance];
    Data.isProfileImageSet = status;
    [Data persistToUserDefaults];
}

- (BOOL)ProfileImageIsSet2 {
    DataAccess *Data = [DataAccess singletonInstance];
    return Data.isProfileImageSet;
}

- (void)setProfileImageStatus3:(BOOL)status {
    DataAccess *Data = [DataAccess singletonInstance];
    Data.isProfileImageSet = status;
    [Data persistToUserDefaults];
}

- (BOOL)ProfileImageIsSet3 {
    DataAccess *Data = [DataAccess singletonInstance];
    return Data.isProfileImageSet;
}

- (void)setProfileImageStatus4:(BOOL)status {
    DataAccess *Data = [DataAccess singletonInstance];
    Data.isProfileImageSet = status;
    [Data persistToUserDefaults];
}

- (BOOL)ProfileImageIsSet4 {
    DataAccess *Data = [DataAccess singletonInstance];
    return Data.isProfileImageSet;
}

- (void)setAddedFB:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"AddedFB"];
}

- (BOOL)AddedFB {
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"AddedFB"]) {
        return YES;
    }
    
    return NO;
}

- (void)setAddedLinkedin:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"AddedLinkedin"];
}

- (BOOL)AddedLinkedin {
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"AddedLinkedin"]) {
        return YES;
    }
    
    return NO;
}

- (void)setisLoggedInWithFB:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"LoggedInWithFB"];
}

- (BOOL)LoggedInWithFB {
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"LoggedInWithFB"]) {
        return YES;
    }
    
    return NO;
}

- (void)setisLoggedInWithLinkedin:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"LoggedInWithLinkedin"];
}

- (BOOL)LoggedInWithLinkedin {
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"LoggedInWithLinkedin"]) {
        return YES;
    }
    
    return NO;
}

- (void)setUselinkedinOptionStatus:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"linkedinIsUsed"];
}

- (BOOL)uselinkedinOption {
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"linkedinIsUsed"]) {
        return YES;
    }
    
    return NO;
}

- (void)setUsefbOptionStatus:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"facebookIsUsed"];
}

- (BOOL)useFBOption {
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"facebookIsUsed"]) {
        return YES;
    }
    
    return NO;
}

- (void)setfbPublicStatus:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"facebookIsPublic"];

    
    //  DataAccess *Data = [DataAccess singletonInstance];
  //  Data.fbPublic = status;
  //  [Data persistToUserDefaults];
}

- (BOOL)fbIsPublic {
   
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"facebookIsPublic"]) {
        return YES;
    }
    
    return NO;
    //DataAccess *Data = [DataAccess singletonInstance];
    //return Data.fbPublic;
}

- (void)setinstagramPublicStatus:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"instagramIsPublic"];

}

- (BOOL)instagramIsPublic {
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"instagramIsPublic"]) {
        return YES;
    }
    
    return NO;
}

- (void)setlinkedinPublicStatus:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"linkedinIsPublic"];

}

- (BOOL)linkedinIsPublic {
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"linkedinIsPublic"]) {
        return YES;
    }
    
    return NO;
}


- (void)setsnapchatPublicStatus:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"snapchatIsPublic"];
}

- (BOOL)snapchatIsPublic {
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"snapchatIsPublic"]) {
        return YES;
    }
    
    return NO;
}


-(void)setProfileImage:(UIImage*)image{
    
    DataAccess *Data = [DataAccess singletonInstance];
    Data.profileImage = image;
    [Data persistToUserDefaults];


}

-(UIImage*)getProfileImage{
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
    
}

-(void)setProfileImage2:(UIImage*)image{
    
    DataAccess *Data = [DataAccess singletonInstance];
    Data.profileImage = image;
    [Data persistToUserDefaults];
    
    
}

-(UIImage*)getProfileImage2{
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage2"];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
    
}

-(void)setProfileImage3:(UIImage*)image{
    
    DataAccess *Data = [DataAccess singletonInstance];
    Data.profileImage = image;
    [Data persistToUserDefaults];
    
    
}

-(UIImage*)getProfileImage3{
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage3"];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
    
}

-(void)setProfileImage4:(UIImage*)image{
    
    DataAccess *Data = [DataAccess singletonInstance];
    Data.profileImage = image;
    [Data persistToUserDefaults];
    
    
}

-(UIImage*)getProfileImage4{
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage4"];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
    
}

#pragma - user info

-(void)setName:(id)name{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"username"];
    
}

-(NSString*)getName{
    
    NSString *name = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"username"];
    
    return name;
}


#pragma - social networks

-(void)setFacebook:network{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:network forKey:@"facebook_id"];
    
}

-(NSString*)getFacebook{
    
    NSString *network = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"facebook_id"];
    
    return network;
}


-(void)setInstagram:network{
    
 
    [[NSUserDefaults standardUserDefaults] setObject:network forKey:@"instagram_name"];
    
}

-(NSString*)getInstagram{
    
    NSString *network = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"instagram_name"];
    
    return network;
}

-(void)setLinkedin:network{
    
    [[NSUserDefaults standardUserDefaults] setObject:network forKey:@"linkedin_name"];
    
}

-(NSString*)getLinkedin{
    
    NSString *network = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"linkedin_name"];
    
    return network;
}

-(void)setSnapchat:network{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:network forKey:@"snapchat_name"];
    
}

-(NSString*)getSnapchat{
    
    NSString *network = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"snapchat_name"];
    
    return network;
}



#pragma mark - NSCoding serialization

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    DataAccess *singletonInstance = [DataAccess singletonInstance];
    
    BOOL loggedInStatus = [aDecoder decodeBoolForKey:@"LoggedInStatus"];
    [singletonInstance setUserLoginStatus:loggedInStatus];
    
    BOOL profileImageStatus = [aDecoder decodeBoolForKey:@"ProfileImageIsSet"];
    [singletonInstance setProfileImageStatus:profileImageStatus];
  /*
    BOOL fbPublicStatus = [aDecoder decodeBoolForKey:@"facebookIsPublic"];
    [singletonInstance setfbOptionStatus:fbPublicStatus];
    
    BOOL instagramPublicStatus = [aDecoder decodeBoolForKey:@"instagramIsPublic"];
    [singletonInstance setfbOptionStatus:instagramPublicStatus];
    
    BOOL linkedinPublicStatus = [aDecoder decodeBoolForKey:@"linkedinIsPublic"];
    [singletonInstance setfbOptionStatus:linkedinPublicStatus];
    
    BOOL snapchatPublicStatus = [aDecoder decodeBoolForKey:@"snapchatIsPublic"];
    [singletonInstance setfbOptionStatus:snapchatPublicStatus];
   */
    
    UIImage *ProfileImage = [aDecoder decodeObjectForKey:@"ProfileImage"];
    [singletonInstance setProfileImage:ProfileImage];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    DataAccess *singletonInstance = [DataAccess singletonInstance];
    
    [aCoder encodeBool:[singletonInstance UserIsLoggedIn] forKey:@"LoggedInStatus"];
    
    [aCoder encodeBool:[singletonInstance isProfileImageSet] forKey:@"ProfileImageIsSet"];
    
    [aCoder encodeBool:[singletonInstance fbPublic] forKey:@"facebookIsPublic"];
    
    [aCoder encodeBool:[singletonInstance instagramPublic] forKey:@"instagramIsPublic"];

    [aCoder encodeBool:[singletonInstance linkedinPublic] forKey:@"linkedinIsPublic"];

    [aCoder encodeBool:[singletonInstance snapchatPublic] forKey:@"snapchatIsPublic"];


    
}


- (void)persistToUserDefaults {
    if(!self){
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"DataAccess"];
    
}


- (void)initUserDefaults {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"DataAccess"];
    
    [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

#pragma mark - Singleton Methods
+ (id)singletonInstance {
    
    static DataAccess *sharedOTTODataAccess = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOTTODataAccess = [[self alloc] init];
    });
    
    return sharedOTTODataAccess;
    
}

@end
