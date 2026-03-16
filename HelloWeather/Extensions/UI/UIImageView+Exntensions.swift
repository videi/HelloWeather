import UIKit

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString else { return }
        
        let completeURLString = urlString.hasPrefix("//") ? "https:\(urlString)" : urlString
        guard let url = URL(string: completeURLString) else { return }
        
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, let response = response, let image = UIImage(data: data) else { return }
            
            let cachedResponse = CachedURLResponse(response: response, data: data)
            cache.storeCachedResponse(cachedResponse, for: request)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}

