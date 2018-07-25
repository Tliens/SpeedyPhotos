//
//  QAlbumVideosMaker.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import Foundation
import Photos

class QAlbumVideosMaker:NSObject{
    
    class func getVideosWithAssets(_ assets:PHFetchResult<PHAsset>) -> [(AVAsset,URL)]? {
        var container:[(AVAsset,URL)] = []

        assets.enumerateObjects({ (asset, index, _) in
            if asset.mediaType == .video{
                if let info = getVideoWithAsset(asset){
                    container.append(info)
                }
            }
        })
        return container
    }
    
    class func getVideoWithAsset(_ asset:PHAsset) -> (AVAsset,URL)? {
        let options = getPHVideoRequestOptions()
        options.progressHandler = { (progress,_,_,_) in
            print("正在下载,进度为\(progress * 100)%")
        }
        var avAsset: AVAsset! = nil
        var videoURL: URL! = nil
        
        PHImageManager.default().requestAVAsset(forVideo: asset, options: options, resultHandler: { (asset, _, info) in
            DispatchQueue.main.async {
                guard let asset = asset else{
                    return
                }
                guard let strMessage = info?["PHImageFileSandboxExtensionTokenKey"] as? String else{
                    return
                }
                guard let path = strMessage.components(separatedBy: ";").last else{
                    return
                }
                avAsset = asset
                videoURL = URL(fileURLWithPath: path)
                
            }
        })
        return (avAsset,videoURL)
    }

    class func getPHVideoRequestOptions()->PHVideoRequestOptions{
        let options = PHVideoRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        return options
    }

}
