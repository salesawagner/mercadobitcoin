//
//  UIImageViewExtensions.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

extension UIImageView {
    private func imageError() {
        image = .init(named: "noImage")
    }

    func loadFromUrl(stringURL: String?) {
        guard let string = stringURL,  let url = URL(string: string) else {
            imageError()
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
           guard let data = data, error == nil else {
               self?.imageError()
               return
           }

           if let downloadedImage = UIImage(data: data) {
               DispatchQueue.main.async {
                   self?.image = downloadedImage
               }
           }
        }

        task.resume()
    }
}
