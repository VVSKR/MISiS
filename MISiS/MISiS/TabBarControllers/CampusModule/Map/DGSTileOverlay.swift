//
//  DGSTileOverlay.swift
//  MISiS
//
//  Created by Vova SKR on 10.02.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import MapKit

public class DGSTileOverlay: MKTileOverlay {
    
    private let cache = NSCache<NSURL, NSData>()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    private let retinaFormat = "https://rtile2.maps.2gis.com/tiles?x=%d&y=%d&z=%d&v=1"
    
    override public func url(forTilePath path: MKTileOverlayPath) -> URL {
        return URL(string: String(format: retinaFormat, path.x, path.y, path.z)) ?? super.url(forTilePath: path) 
    }
    
    internal init() {
        super.init(urlTemplate: nil)
        cache.countLimit = 20
        tileSize = CGSize(width: 512, height: 512)
        canReplaceMapContent = true
        maximumZ = 18
    }
    
    override public func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
        let url = self.url(forTilePath: path)
        print(url)
        if let cachedData = self.cache.object(forKey: url as NSURL) as Data? {
            result(cachedData, nil)
        } else {
            let task = urlSession.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                if let data = data {
                    self?.cache.setObject(data as NSData, forKey: url as NSURL)
                }
                result(data, error)
            })
            task.resume()
        }
    }
}
