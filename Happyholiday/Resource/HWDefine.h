//
//  HWDefine.h
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#ifndef HWDefine_h
#define HWDefine_h
#import <Foundation/Foundation.h>



//typedef NS_ENUM(NSInteger,ClassifyListType){
//    ClassifyListTypeShowRepertoire = 1,   //演出剧目
//    ClassifyListTypeTouristPlace ,        //旅游景点
//    ClassifyListTypeStudyPUZ,             //益智
//    ClassifyListTypeFamilyTrave           //亲子旅游
//};


typedef NS_ENUM(NSInteger, ClassfyListType) {
    
    ClassfyListTypeShowRepertoire=1,//演出剧目
    ClassfyListTypeTouristPlace,  //景点场馆
    ClassfyListTypeStudyPUZ,  //学习益智
    ClassfyListTypeFamilyTravel //亲子旅行
        
 
};


#pragma mark ----主页接口

//首页数据接口
#define kMainDataInterface    @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1"


//活动详情接口
#define kActivityDetail @"http://e.kumi.cn/app/articleinfo.php?_s_=6055add057b829033bb586a3e00c5e9a&_t_=1452071715&channelid=appstore&cityid=1&id=%@&lat=34.61356779156581&lng=112.4141403843618"
#define kActivitychangeDetail @"http://e.kumi.cn/app/articleinfo.php?_s_=6055add057b829033bb586a3e00c5e9a&_t_=1452071715&channelid=appstore&cityid=1&lat=34.61356779156581&lng=112.4141403843618"


//推荐专题
//&id=821
#define KactivityThem @"http://e.kumi.cn/app/positioninfo.php?_s_=1b2f0563dade7abdfdb4b7caa5b36110&_t_=1452218405&channelid=appstore&cityid=1&lat=34.61349052974207&limit=30&lng=112.4139739846577&page=1"



//演出剧目

//演出节目
#define  KactivityClassfyPlay   @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=1e925924e35606ad84e25cc4f8181052&_t_=1452419774&channelid=appstore&cityid=1&lat=34.61352375700717&limit=30&lng=112.4140695882542&typeid=6"




//景点场馆
#define  kSpotsVenue      @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=07098ba9b3c880d9f0861206cf8d6208&_t_=1452420865&channelid=appstore&cityid=1&lat=34.61353403229416&limit=30&lng=112.4140383019175&page=1&typeid=23"
//学习益智
#define  kStudyIntellect   @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=b6912dc77e7e12a24c48fc7bbef0c0b2&_t_=1452423875&channelid=appstore&cityid=1&lat=34.61355699177267&limit=30&lng=112.414074144134&typeid=22"
//亲子旅游
#define  kSonTour  @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=64084c92a84b719e3d5c844c8bade788&_t_=1452424822&channelid=appstore&cityid=1&lat=34.6135238020622&limit=30&lng=112.4139990666016&typeid=21"



//分类列表

#define KClassfy @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=dad924a9b9cd534b53fc2c521e9f8e84&_t_=1452495193&channelid=appstore&cityid=1&lat=34.61356398594803&limit=30&lng=112.4140434532402"










//精选活动&page=1

#define KactivityGood @"http://e.kumi.cn/app/articlelist.php?_s_=a9d09aa8b7692ebee5c8a123deacf775&_t_=1452236979&channelid=appstore&cityid=1&lat=34.61351314785497&limit=30&lng=112.4140755658942&type=1"


//热门专题

#define KactivityHot @"http://e.kumi.cn/app/positionlist.php?_s_=e2b71c66789428d5385b06c178a88db2&_t_=1452237051&channelid=appstore&cityid=1&lat=34.61351314785497&limit=30&lng=112.4140755658942"




#pragma mark ----发现

#define Kdiscover @"http://e.kumi.cn/app/found.php?_s_=a82c7d49216aedb18c04a20fd9b0d5b2&_t_=1451310230&channelid=appstore&cityid=1&lat=34.62172291944134&lng=112.4149512442411"







//微博
#define kAppkey @"2593994676"
#define kRedirectURI @"http://sns.whalecloud.com/sina2/callback"
#define kAppSecret @"7a552857245955d2db216d60cd6083b8"



//微信
#define kWeixinAppId  @"wx948ab99ff0970cf6"
#define kWeixinAppSecret @"824b1cd01b6315c884051128af6b7b7b"







//引入类目
#import "UIViewController+Common.h"



#endif /* HWDefine_h */
