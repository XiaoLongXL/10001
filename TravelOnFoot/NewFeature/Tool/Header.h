//
//  Header.h
//  TravelOnFoot
//
//  Created by xiaolong on 15/7/17.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#ifndef TravelOnFoot_Header_h
#define TravelOnFoot_Header_h

#pragma mark ------------活动----------------

/*活动-API*/
#define kAPIActivity @"http://tubu.ibuzhai.com/rest/v3/activity/hot?app_version=2.3.1&device_type=1&page=1&page_size=20"

/*上拉刷新拼接接口*/
#define KAPIActivityAppend @"http://tubu.ibuzhai.com/rest/v3/activity/hot?app_version=2.3.1&device_type=1&page=%ld&page_size=20"


#pragma mark ------------游记----------------
/********************直播********************/
/*游记-直播-API*/
#define kAPITravelLiveNotes @"http://tubu.ibuzhai.com/rest/v1/broadcasts?app_version=2.3.1&device_type=1&page=1&page_size=20"

/*游记-直播-详情API需要拼接ID*/
#define kAPITravelLiveNotesDetail @"http://tubu.ibuzhai.com/rest/v2/travelog/%@?app_version=2.3.1&device_type=1"

/*上拉刷新拼接接口*/
#define kAPITravelLiveNotesAppend @"http://tubu.ibuzhai.com/rest/v1/broadcasts?app_version=2.3.1&device_type=1&page=%ld&page_size=20"
/********************推荐********************/

/*游记-推荐-API*/
#define kAPITravelCommendNotes @"http://tubu.ibuzhai.com/rest/v1/travelog/recommends?app_version=2.3.1&device_type=1&page=1&page_size=20"

/*游记-推荐-详情-API需要拼接ID*/
#define kAPITravelCommendNotesDetail @"http://tubu.ibuzhai.com/rest/v2/travelog/%@?app_version=2.3.1&device_type=1"


/*上拉刷新拼接接口*/
#define kAPITravelCommendNotesAppend @"http://tubu.ibuzhai.com/rest/v1/travelog/recommends?app_version=2.3.1&device_type=1&page=%ld&page_size=20"


#pragma mark ------------路线----------------


/*路线-路线库-API*/
#define kAPIRoads @"http://tubu.ibuzhai.com/rest/v2/trail/regions?app_version=2.3.1&device_type=1"

/*路线-路线库-详情-API需要拼接地点名字*/
#define kAPIRoadDetail @"http://tubu.ibuzhai.com/rest/v2/trails?app_version=2.3.1&city=0&crowd=0&device_type=1&page=1&page_size=0&search=%@&search_in=1&trait=0"





/*路线详情界面 5个APi接口*/
/*路线详情API需要拼接cellID*/

//#define kAPIRoadDetail @"http://tubu.ibuzhai.com/rest/v2/trail/%@?app_version=2.3.1&device_type=1"





#endif
