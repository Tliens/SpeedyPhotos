//
//  QAlbumMaker.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import Foundation
import UIKit
import Photos

open class QAlbumMaker:NSObject{
    
    /// make album
    ///if had exit one,return ; else creat one
    ///
    /// - Parameters:
    ///   - name: album name
    ///   - completed: assetCollection:PHAssetCollection ,error
    open class func makerAlbum(name:String,completed: ((_ assetCollection:PHAssetCollection?,_ error:Error?)->())?) {
        getAlbum(name: name) { (collection, error) in
            if let _ = error {
                creatAlbum(name: name, completed: { (collection, error) in
                    completed?(collection,error)
                })
            }else{
                completed?(collection,nil)
            }
        }
    }
    
    /// get album
    /// search album and return it or nil
    open class func getAlbum(name:String,completed: ((_ assetCollection:PHAssetCollection?,_ error:Error?)->())?) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate.init(format: "title = %@", name)
        let collection : PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        if let assetCollection = collection.firstObject{
            completed?(assetCollection,nil)
        }else{
            completed?(nil,nil)
        }
    }
    /// creat album
    /// creat album and return it
    open class func creatAlbum(name:String,completed: ((_ assetCollection:PHAssetCollection?,_ error:Error?)->())?) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate.init(format: "title = %@", name)
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
        }) { (result, error) in
            if let error = error {
                completed?(nil,error)
            }else{
                let collection : PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
                completed?(collection.firstObject,nil)
            }
        }
    }
}
