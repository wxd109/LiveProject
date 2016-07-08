//
//  GlobalConfig.h
//  LiveProject
//
//  Created by dd on 16/7/8.
//  Copyright © 2016年 dd. All rights reserved.
//

#ifndef GlobalConfig_h
#define GlobalConfig_h

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

// 颜色设置
#define RGBColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


#define _view_width    self.view.frame.size.width
#define _view_height   self.view.frame.size.height
#define _k_w           [UIScreen mainScreen].bounds.size.width
#define _k_h           [UIScreen mainScreen].bounds.size.height


#endif /* GlobalConfig_h */
