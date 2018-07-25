//
//  QAlbumPermissionRequest .swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import Foundation
import Photos

class QAlbumPermissionRequest : NSObject {
    class func requestPhotosPermision(completed: ((_ error:Error?)->())?){
        let authStatus = PHPhotoLibrary.authorizationStatus()
        // .notDetermined .authorized .restricted .denied
        if authStatus != .authorized {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .notDetermined || status == .denied || status == .restricted{
                    completed?(NSError.init(domain: "not permision", code: 1, userInfo: nil))
                }else{
                    completed?(nil)
                }
            }
        }else{
            completed?(nil)
        }
    }
}
