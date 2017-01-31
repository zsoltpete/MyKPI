//
//  NewQuestionTypeCell.swift
//  MyKPI
//
//  Created by Zsolt Pete on 28/01/17.
//  Copyright © 2017 petez. All rights reserved.
//

import UIKit

class NewQuestionTypeCell: UITableViewCell {

    @IBOutlet weak var emojiButton: UIButton!
    @IBOutlet weak var pointButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var trueFalseButton: UIButton!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    var acticeType: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pointButton.setImage(self.noir(image: UIImage(named: "point")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.timeButton.setImage(self.noir(image: UIImage(named: "clock")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.trueFalseButton.setImage(self.noir(image: UIImage(named: "true_false")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.emojiButton.setImage(self.noir(image: UIImage(named: "emoji")!, filterName: "CIPhotoEffectProcess"), for: .normal)
        self.acticeType = Constants.QuestionTypes.Feeling
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func emoji(_ sender: Any) {
        self.pointButton.setImage(self.noir(image: UIImage(named: "point")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.timeButton.setImage(self.noir(image: UIImage(named: "clock")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.trueFalseButton.setImage(self.noir(image: UIImage(named: "true_false")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.emojiButton.setImage(self.noir(image: UIImage(named: "emoji")!, filterName: "CIPhotoEffectProcess"), for: .normal)
        self.acticeType = Constants.QuestionTypes.Feeling
    }
    @IBAction func point(_ sender: Any) {
        self.pointButton.setImage(self.noir(image: UIImage(named: "point")!, filterName: "CIPhotoEffectProcess"), for: .normal)
        self.timeButton.setImage(self.noir(image: UIImage(named: "clock")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.trueFalseButton.setImage(self.noir(image: UIImage(named: "true_false")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.emojiButton.setImage(self.noir(image: UIImage(named: "emoji")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.acticeType = Constants.QuestionTypes.Point
    }
    @IBAction func time(_ sender: Any) {
        self.pointButton.setImage(self.noir(image: UIImage(named: "point")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.timeButton.setImage(self.noir(image: UIImage(named: "clock")!, filterName: "CIPhotoEffectProcess"), for: .normal)
        self.trueFalseButton.setImage(self.noir(image: UIImage(named: "true_false")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.emojiButton.setImage(self.noir(image: UIImage(named: "emoji")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.acticeType = Constants.QuestionTypes.Time
    }
    @IBAction func trueFalse(_ sender: Any) {
        self.pointButton.setImage(self.noir(image: UIImage(named: "point")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.timeButton.setImage(self.noir(image: UIImage(named: "clock")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.trueFalseButton.setImage(self.noir(image: UIImage(named: "true_false")!, filterName: "CIPhotoEffectProcess"), for: .normal)
        self.emojiButton.setImage(self.noir(image: UIImage(named: "emoji")!, filterName: "CIPhotoEffectNoir"), for: .normal)
        self.acticeType = Constants.QuestionTypes.TrueFalse
    }
    


    
    var context = CIContext(options: nil)
    
    func noir(image: UIImage, filterName: String) -> UIImage{
        
        let currentFilter = CIFilter(name: filterName)
        currentFilter!.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        return processedImage
    }
    
    
}
