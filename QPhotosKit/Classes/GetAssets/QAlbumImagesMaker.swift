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
    
    open class func getImagesWithAssets(_ assets:PHFetchResult<PHAsset>,quality:QAlbumImageQuality,thumbnailSize:CGSize = ThumbnailSize)->[UIImage]{
        //可能会引起 内存溢出 不建议在controller中持有 [UIImage] 建议持有 PHAsset ，需要时请求Image
        var container:[UIImage] = []
        assets.enumerateObjects({ (asset, index, _) in
            if let img = getImageWithAsset(asset,quality:quality,thumbnailSize:thumbnailSize){
                container.append(img)
            }
        })
        return container
    }
    open class func getImageWithAsset(_ asset:PHAsset,quality:QAlbumImageQuality,thumbnailSize:CGSize = ThumbnailSize)->UIImage?{
        let options = getPHImageRequestOptions()
        var image : UIImage?
        //       let originalSize = CGSize.init(width: CGFloat(asset.pixelWidth), height: CGFloat(asset.pixelWidth))
        
        PHImageManager.default().requestImage(for: asset, targetSize:thumbnailSize , contentMode: .default, options: options, resultHandler: { (img, info) in
            image = img
        })
        return image
    }
    /// decide single asset 'eg:(img)' how to be returned
    open class func getPHImageRequestOptions()->PHImageRequestOptions{
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        return options
    }
    
    /// get images
    /// when ascending is false , return asset'creationDate such as [20,19,18,17,16,15]
    open class func getImagesWith(albumName:String,ascending:Bool,thumbnailSize:CGSize = ThumbnailSize)->[UIImage]?{
        if let assets = QAlbumAssetsMaker.getAlbumAssets(albumName: albumName, ascending: ascending){
            let images = getImagesWithAssets(assets, quality: .height)
            return images
        }else{
            return nil
        }
    }
    
}
