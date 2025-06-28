//
//  ImageCache.swift
//  Test
//
//  Created by Савва Пономарев on 28.06.2025.
//

import UIKit

extension UIImageView {
    /// Загрузка изображения по URL
    func load(url: URL) {
        /// поиск изображения в кэше
        let cacheKey = url.absoluteString as NSString
        if let cachedImage = ImageCache.shared.image(forKey: cacheKey as String) {
            self.image = cachedImage
            return
        }

        /// поиск изображения в сети
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to create image from data")
                return
            }

            /// сохранение в кэш
            ImageCache.shared.set(image, forKey: cacheKey as String)

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}


/// SingleTon для кэширования изображения
class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    /// загрузка обьктов в кэш
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    /// парсинг объектов из кэша
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
