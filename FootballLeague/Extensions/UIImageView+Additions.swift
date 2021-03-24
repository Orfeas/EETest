//
//  UIImageView+Additions.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 23/3/21.
//

import Foundation
import AlamofireImage
import SVGKit

extension UIImageView {
    func setImageWithURL(url: URL, placeholder: UIImage? = nil, completion: ((UIImage) -> Void)? = nil) {
        af.setImage(withURL: url,
                    placeholderImage: placeholder,
                    filter: nil,
                    progress: nil,
                    progressQueue: DispatchQueue.global(),
                    imageTransition: .crossDissolve(0.0),
                    runImageTransitionIfCached: false) { image in
            guard let downloadedImage = image.value else {
                return
            }
            completion?(downloadedImage)
        }
    }
    
    func downloadedsvg(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let receivedicon: SVGKImage = SVGKImage(data: data),
                let image = receivedicon.uiImage
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}
