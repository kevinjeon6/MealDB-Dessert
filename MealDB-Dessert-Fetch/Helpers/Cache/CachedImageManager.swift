//
//  CachedImageManager.swift
//  MealDB-Dessert-Fetch
//
//  Created by Kevin Mattocks on 6/18/23.
//

import Foundation


//Using the final keyword to avoid inheritence
final class CachedImageManager: ObservableObject {
    
    //private set - only want the views to listen to the changes and not change it
    @Published private(set) var data: Data?
    
    //Fetch image
    private let imageRetriever = ImageRetriever()
    
    //MainActor interacting with the UI. We want that it makes changes on the main thread
    //Give the ability to inject it's own ImageCache. Will allow to pass in different types of image caches in future if needed
    @MainActor
    func load(_ imgUrl: String, cache: ImageCache = .shared) async {
        
        
        //Check and see if the image already exists
        if let imageData = cache.object(forkey: imgUrl as NSString) {
            self.data = imageData
            #if DEBUG
            //Need to use if DEBUG which only executes in a developer environment and not in production
            print("fetching image from the cache: \(imgUrl)")
            #endif
            return
        }
        
        do {
            self.data = try await imageRetriever.fetch(imgUrl)
            if let dataToCache = data as? NSData {
            //Store into variable DataToCache and save it using the imgUrl
            cache.set(object: dataToCache, forKey: imgUrl as NSString)
            #if DEBUG
            print("caching image: \(imgUrl)")
            #endif
            }
        } catch {
            print(error)
        }
    }
}

