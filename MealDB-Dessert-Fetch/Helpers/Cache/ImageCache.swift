//
//  ImageCache.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import Foundation

class ImageCache {
    //Using class because we are going to create a singleton.
    // Singleton, since instance through the entire application rather than keep creating it. ONly one instance that we keep alive for the entire application
    
    typealias CacheType = NSCache<NSString, NSData>
    //NSString is the imgURL string and the NSData is the data saved associated with imgURL
    
    // MARK: - Singleton
    static let shared = ImageCache()
    
    // MARK: - Initializer
    //When making an instance, use a private init so no one can create an instance of the class
    private init() {}
    
    //Lazy because this won't be initialized until we directly use the cache
    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 100 //How many items within it
        cache.totalCostLimit = 50 * 1024 * 1024 // 50 MB
        return cache
        
    }()
    
    
    // MARK: - Methods
    //Getting the item
    //Allows us to grab an object from the cache and need to pass in the key for the object.
    func object(forkey key: NSString) -> Data? {
        cache.object(forKey: key) as? Data
    }
    
    //Saving the object and the key for the objects
    func set(object: NSData, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}
