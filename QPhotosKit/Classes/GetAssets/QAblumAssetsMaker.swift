//
//  QAblumAssetsMaker.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import Foundation
import Photos

class QAblumAssetsMaker: NSObject {
    /// get assets
    /// when ascending is false , return asset'creationDate such as [20,19,18,17,16,15]
    class func getAlbumAssets(albumName:String,ascending:Bool)->PHFetchResult<PHAsset>?{
        if let collection = getPHAssetCollection(albumName:albumName){
            let fetchOptions = getPHFetchOptions(ascending: ascending)
            let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
            return assets
        }else{
            return nil
        }
    }
    
    /// get PHAssetCollection with name,return first
    ///because PHAssetCollection maybe have more than one name -> albumName
    class func getPHAssetCollection(albumName:String)->PHAssetCollection?{
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate.init(format: "title = %@", albumName)
        let collection : PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        return collection.firstObject
    }

    /// decide assets collection in PHAsset how to be returned
    class func getPHFetchOptions(ascending:Bool)->PHFetchOptions{
        let assetOption = PHFetchOptions.init()
        assetOption.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: ascending)]
        return assetOption
    }
    

}
