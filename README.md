导入方式：
###pod 'QPhotosKit', '~> 0.3.2'

为什么要封装一层Photo呢？
我发现在使用过程中，使用Photo封装一次后，使用起来更好用，而且满足大多数情况

###说明

一、`QAlbumPermissionRequest`
用于请求权限：
```
open class QAlbumPermissionRequest : NSObject {

    open class func requestPhotosPermision(completed: ((_ error: Error?) -> ())?)
}

```
二、`QAlbumImagesMaker`
获取Image 具体返回值有参数决定，目前支持：
`PHFetchResult<PHAsset>`
`PHAsset`
`albumName`
```
open class QAlbumImagesMaker : NSObject {

    open class func getImagesWithAssets(_ assets: PHFetchResult<PHAsset>, quality: QAlbumImageQuality, thumbnailSize: CGSize = default) -> [UIImage]

    open class func getImageWithAsset(_ asset: PHAsset, quality: QAlbumImageQuality, thumbnailSize: CGSize = default) -> UIImage?

    /// decide single asset 'eg:(img)' how to be returned
    open class func getPHImageRequestOptions() -> PHImageRequestOptions

    /// get images
    /// when ascending is false , return asset'creationDate such as [20,19,18,17,16,15]
    open class func getImagesWith(albumName: String, ascending: Bool, thumbnailSize: CGSize = default) -> [UIImage]?
}
```

三、QAlbumAssetCollections
get all assets collection (input output（理解为：） all albums)
获取手机中所有的相册
```
open class QAlbumAssetCollections : NSObject {

    /// get all assets collection (input output（理解为：） all albums)
    open class func getAssetCollections() -> PHFetchResult<PHAssetCollection>
}
```
四、QAlbumAssetsMaker
获取Assets，具体返回值有参数决定，目前支持：
albumName
PHAssetCollection
```
open class QAlbumAssetsMaker : NSObject {

    /// get assets
    /// when ascending is false , return asset'creationDate such as [20,19,18,17,16,15]
    open class func getAlbumAssets(albumName: String, ascending: Bool) -> PHFetchResult<PHAsset>?

    open class func getAlbumAssets(collection: PHAssetCollection, ascending: Bool) -> PHFetchResult<PHAsset>?

    /// get PHAssetCollection with name,return first
    ///because PHAssetCollection maybe have more than one name -> albumName
    open class func getPHAssetCollection(albumName: String) -> PHAssetCollection?

    /// decide assets collection in PHAsset how to be returned
    open class func getPHFetchOptions(ascending: Bool) -> PHFetchOptions
}

```
五、QAlbumVideosMaker
获取相册中的Video
```
open class QAlbumVideosMaker : NSObject {

    open class func getVideosWithAssets(_ assets: PHFetchResult<PHAsset>) -> [(AVAsset, URL)]?

    open class func getVideoWithAsset(_ asset: PHAsset) -> (AVAsset, URL)?

    open class func getPHVideoRequestOptions() -> PHVideoRequestOptions
}
```
六、QAlbumSaveImage
保存图片
```
    open class func saveImageWithURL(_ url:URL,album:String,completed: ((_ error:Error?)->())?)
    open class func saveImage(url:URL,collection:PHAssetCollection,completed: ((_ error:Error?)->())?) 
    open class func saveImage(image:UIImage,collection:PHAssetCollection,completed: ((_ error:Error?)->())?) 

```
七：QAlbumSaveVideo 保存视频
 ```
open class QAlbumSaveVideo : NSObject {

    /// save video with url
    /// photos permission resquest
    /// creat album , if don't exit,else return one
    /// - Parameters:
    ///   - path: url
    ///   - album: album name
    ///   - completed: if success, error is nil,else save failed
    open class func saveVideoWithURL(_ url: URL, album: String, completed: ((_ error: Error?) -> ())?)

    open class func saveVideo(url: URL, collection: PHAssetCollection, completed: ((_ error: Error?) -> ())?)
}
```

八：QAlbumMaker 创建相册
```
open class QAlbumMaker : NSObject {

    /// make album
    ///if had exit one,return ; else creat one
    ///
    /// - Parameters:
    ///   - name: album name
    ///   - completed: assetCollection:PHAssetCollection ,error
    open class func makerAlbum(name: String, completed: ((_ assetCollection: PHAssetCollection?, _ error: Error?) -> ())?)

    /// get album
    /// search album and return it or nil
    open class func getAlbum(name: String, completed: ((_ assetCollection: PHAssetCollection?, _ error: Error?) -> ())?)

    /// creat album
    /// creat album and return it
    open class func creatAlbum(name: String, completed: ((_ assetCollection: PHAssetCollection?, _ error: Error?) -> ())?)
}
```
