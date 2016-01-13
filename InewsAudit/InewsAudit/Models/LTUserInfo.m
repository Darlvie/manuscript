//
//  LTUserInfo.m
//  InewsAudit
//
//  Created by hooper on 12/31/15.
//  Copyright © 2015 BGXT. All rights reserved.
//

#import "LTUserInfo.h"
#import "MJExtension.h"

@implementation LTUserInfo

+ (instancetype)userInfoWithDict:(NSDictionary *)dict {
    [LTUserInfo setupReplacedKeyFromPropertyName:^NSDictionary *{
      return  @{ @"desc" : @"description"};
    }];
    
    return [LTUserInfo objectWithKeyValues:dict];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.userId forKey:USERINFO_USERID];
    [aCoder encodeObject:self.idCard forKey:USERINFO_IDCARD];
    [aCoder encodeObject:self.password forKey:USERINFO_PASSWPORD];
    [aCoder encodeObject:self.lastName forKey:USERINFO_LASTNAME];
    [aCoder encodeObject:self.firstName forKey:USERINFO_FIRSTNAME];
    [aCoder encodeObject:self.email forKey:USERINFO_EMAIL];
    [aCoder encodeObject:self.phone forKey:USERINFO_PHONE];
    [aCoder encodeObject:self.mobile forKey:USERINFO_MOBILE];
    [aCoder encodeObject:self.userType forKey:USERINFO_USERTYPE];
    [aCoder encodeObject:self.desc forKey:USERINFO_DESC];
    [aCoder encodeObject:self.honour forKey:USERINFO_HONOUR];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userId = [aDecoder decodeIntForKey:USERINFO_USERID];
        self.idCard = [aDecoder decodeObjectForKey:USERINFO_IDCARD];
        self.password = [aDecoder decodeObjectForKey:USERINFO_PASSWPORD];
        self.lastName = [aDecoder decodeObjectForKey:USERINFO_LASTNAME];
        self.firstName = [aDecoder decodeObjectForKey:USERINFO_FIRSTNAME];
        self.email = [aDecoder decodeObjectForKey:USERINFO_EMAIL];
        self.phone = [aDecoder decodeObjectForKey:USERINFO_PHONE];
        self.mobile = [aDecoder decodeObjectForKey:USERINFO_MOBILE];
        self.userType = [aDecoder decodeObjectForKey:USERINFO_USERTYPE];
        self.desc = [aDecoder decodeObjectForKey:USERINFO_DESC];
        self.honour = [aDecoder decodeObjectForKey:USERINFO_HONOUR];
    }
    return self;
}




@end
