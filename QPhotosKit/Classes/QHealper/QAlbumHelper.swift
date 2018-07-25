//
//  QAlbumHelper.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import Foundation
import UIKit
import Photos

enum QAlbumImageQuality{
    case low
    case middle
    case height
}

let ThumbnailSize = CGSize.init(width: 80, height: 80)
let QAlbumImgMaxSize = PHImageManagerMaximumSize
