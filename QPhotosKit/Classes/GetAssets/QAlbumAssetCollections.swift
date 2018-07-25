//
//  QAlbumAssetCollections.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import Foundation
import Photos
open class QAlbumAssetCollections:NSObject{
//    public enum PHAssetCollectionType : Int {
//        case album
//        case smartAlbum
//        case moment
//    }
    /// get all assets collection (input output（理解为：） all albums)
    open class func getAssetCollections(_ name:String)->PHFetchResult<PHAssetCollection>{
        let result = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        return result
    }
}
