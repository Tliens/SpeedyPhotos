//
//  QAlbumImagesMaker.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import Foundation
import UIKit
import Photos

open class QAlbumImagesMaker:NSObject{
    
    class func getImagesWithAssets(_ assets:PHFetchResult<PHAsset>,quality:QAlbumImageQuality,thumbnailSize:CGSize = ThumbnailSize)->[UIImage]{
        var container:[UIImage] = []
        assets.enumerateObjects({ (asset, index, _) in
            if let img = getImageWithAsset(asset,quality:quality,thumbnailSize:thumbnailSize){
                container.append(img)
            }
        })
        return container
    }
    class func getImageWithAsset(_ asset:PHAsset,quality:QAlbumImageQuality,thumbnailSize:CGSize = ThumbnailSize)->UIImage?{
        let options = getPHImageRequestOptions()
        var image : UIImage?
        //       let originalSize = CGSize.init(width: CGFloat(asset.pixelWidth), height: CGFloat(asset.pixelWidth))
        
        PHImageManager.default().requestImage(for: asset, targetSize:thumbnailSize , contentMode: .default, options: options, resultHandler: { (img, info) in
            image = img
        })
        return image
    }
    /// decide single asset 'eg:(img)' how to be returned
    class func getPHImageRequestOptions()->PHImageRequestOptions{
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        return options
    }
    
    /// get images
    /// when ascending is false , return asset'creationDate such as [20,19,18,17,16,15]
    class func getImagesWith(albumName:String,ascending:Bool,thumbnailSize:CGSize = ThumbnailSize)->[UIImage]?{
        if let assets = QAblumAssetsMaker.getAlbumAssets(albumName: albumName, ascending: ascending){
            let images = getImagesWithAssets(assets, quality: .height)
            return images
        }else{
            return nil
        }
    }
    
}
