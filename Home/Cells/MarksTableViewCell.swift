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
    @IBOutlet weak var errorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func load(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, _) in
            guard let self = self else { return }

            if let data = data {
                DispatchQueue.main.async {
                    self.markImageView.image = UIImage(data: data)
                }
            } else {
                self.markImageView.isHidden = true
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Sorry,There was an error loading the image"
                return
            }
        }
        task.resume()
    }

}
