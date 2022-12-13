import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

/// UIKit extension that handles downloading an image from cache
extension UIImageView {
    
    /// Handles downloading images from cache
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            print(ErrorMessage.invalidURL)
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            print(ErrorMessage.imageFound)
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    print(ErrorMessage.imageNotFound)
                    self?.image = loadedImage
                    imageCache.setObject(loadedImage, forKey: url as AnyObject)
                }
            }
        }
    }
}
