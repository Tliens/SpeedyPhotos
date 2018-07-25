//
//  QAlbumSaveImage.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import Foundation
import Photos

open class QAlbumSaveImage:NSObject{
    /// save image
    /// photos permission resquest
    /// creat album , if don't exit,else return one
    /// - Parameters:
    ///   - image: UIImage
    ///   - album: album name
    ///   - completed: if success, error is nil,else save failed
    class func saveImage(_ image:UIImage,album:String,completed: ((_ error:Error?)->())?) {
        //MARK: - creat Album
        QAlbumMaker.creatAlbum(name: album, completed: { (collection, error) in
            if let error = error {
                completed?(error)
            }else{
                if let collection = collection{
                    //MARK: - save Image
                    saveImage(image: image, collection: collection, completed: { (error) in
                        
                        completed?(nil)
                    })
                }else{
                    let error = NSError.init(domain: "collection is nil", code: 800851, userInfo: nil)
                    completed?(error)
                }
            }
        })
    }
    /// save image with local path
    /// photos permission resquest
    /// creat album , if don't exit,else return one
    /// - Parameters:
    ///   - path: local path in sandbox
    ///   - album: album name
    ///   - completed: if success, error is nil,else save failed
    class func saveImageWithLocalPath(_ path:String,album:String,completed: ((_ error:Error?)->())?){
        let image = UIImage.init(contentsOfFile: path)
        if let img = image {
            saveImage(img, album: album, completed: completed)
        }else{
            let error = NSError.init(domain: "path is invalid", code: 800852, userInfo: nil)
            completed?(error)
        }
    }
    /// save image with url
    /// photos permission resquest
    /// creat album , if don't exit,else return one
    /// - Parameters:
    ///   - path: url
    ///   - album: album name
    ///   - completed: if success, error is nil,else save failed
    class func saveImageWithURL(_ url:URL,album:String,completed: ((_ error:Error?)->())?){
        //MARK: - creat Album
        QAlbumMaker.creatAlbum(name: album, completed: { (collection, error) in
            if let error = error {
                completed?(error)
            }else{
                if let collection = collection{
                    //MARK: - save Image
                    saveImage(url: url, collection: collection, completed: { (error) in
                        completed?(nil)
                    })
                }else{
                    let error = NSError.init(domain: "collection is nil", code: 800851, userInfo: nil)
                    completed?(error)
                }
            }
        })
    }
    class func saveImage(url:URL,collection:PHAssetCollection,completed: ((_ error:Error?)->())?) {
        
        //MARK: - save Image with url
        PHPhotoLibrary.shared().performChanges({
            let assetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
            let assetPlaceholder = assetRequest?.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest.init(for: collection)
            albumChangeRequest?.addAssets([assetPlaceholder!] as NSArray)
            
        }) { (result, error) in
            completed?(error)
        }
    }
    class func saveImage(image:UIImage,collection:PHAssetCollection,completed: ((_ error:Error?)->())?) {
        
        //MARK: - save Image with image
        PHPhotoLibrary.shared().performChanges({
            let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let assetPlaceholder = assetRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest.init(for: collection)
            albumChangeRequest?.addAssets([assetPlaceholder!] as NSArray)
            
        }) { (result, error) in
            completed?(error)
        }
    }
    
}
