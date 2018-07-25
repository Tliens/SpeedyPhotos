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

public enum QAlbumImageQuality{
    case low
    case middle
    case height
}

public let ThumbnailSize = CGSize.init(width: 80, height: 80)
public let QAlbumImgMaxSize = PHImageManagerMaximumSize
