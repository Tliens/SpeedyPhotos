//
//  QAlbumSaveVideo.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import Foundation
import Photos
open class QAlbumSaveVideo: NSObject {
    /// save video with url
    /// photos permission resquest
    /// creat album , if don't exit,else return one
    /// - Parameters:
    ///   - path: url
    ///   - album: album name
    ///   - completed: if success, error is nil,else save failed
    open class func saveVideoWithURL(_ url:URL,album:String,completed: ((_ error:Error?)->())?){
        //MARK: - creat Album
        QAlbumMaker.creatAlbum(name: album, completed: { (collection, error) in
            if let error = error {
                completed?(error)
            }else{
                if let collection = collection{
                    //MARK: - save video
                    saveVideo(url: url, collection: collection, completed: { (error) in
                        completed?(nil)
                    })
                }else{
                    let error = NSError.init(domain: "collection is nil", code: 800851, userInfo: nil)
                    completed?(error)
                }
            }
        })
    }
    open class func saveVideo(url:URL,collection:PHAssetCollection,completed: ((_ error:Error?)->())?) {
        
        //MARK: - save Image with url
        PHPhotoLibrary.shared().performChanges({
            let assetRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
            let assetPlaceholder = assetRequest?.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest.init(for: collection)
            albumChangeRequest?.addAssets([assetPlaceholder!] as NSArray)
            
        }) { (result, error) in
            completed?(error)
        }
    }
}
