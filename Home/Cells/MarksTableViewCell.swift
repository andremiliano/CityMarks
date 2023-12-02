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
            self.markLabel.text = mark?.name
            if let imageString = mark?.image,
               let imageURL = URL(string: imageString) {
               self.load(url: imageURL)
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
            guard let self else { return }

            if let data = data {
                DispatchQueue.main.async {
                    self.markImageView.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self.markImageView.image = UIImage(named: "errorImage")
                }
            }
        }
        task.resume()
    }

}
