//
//  MarksTableViewCell.swift
//  CityMarks
//
//  Created by André Emiliano on 27/11/2023.
//

import UIKit

class MarksTableViewCell: UITableViewCell {

    var mark: Mark? {
        didSet {
            markLabel.text = mark?.name
            if let imageString = mark?.image,
               let imageURL = URL(string: imageString) {
               load(url: imageURL)
           }
        }
    }

    @IBOutlet weak var markImageView: UIImageView!
    @IBOutlet weak var markLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func load(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, _) in

            if let data = data {
                DispatchQueue.main.async {
                    self?.markImageView.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self?.markImageView.image = UIImage(named: "errorImage")
                }
            }
        }
        task.resume()
    }

}
