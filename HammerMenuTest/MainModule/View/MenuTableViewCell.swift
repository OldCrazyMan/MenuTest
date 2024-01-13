//
//  SceneDelegate.swift
//  HammerMenuTest
//
//  Created by Tim Akhmetov on 12.01.2024.
//
import UIKit

class MenuTableViewCell: UITableViewCell {
    
    //IBoutlets:
    @IBOutlet weak var imageViewPizza: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        priceButton.layer.borderWidth = 0.5
        priceButton.layer.borderColor = #colorLiteral(red: 0.9909815192, green: 0.2285042405, blue: 0.410518527, alpha: 1)
        priceButton.layer.cornerRadius = 6
        
        separatorInset.right = 16
        separatorInset.left = 16
        selectionStyle = .none
    }
    
    func setupCell(model: PizzaModel) {
        nameLabel.text = model.title
        descriptionLabel.text = model.description
        priceButton.setTitle("\(model.price) р.", for: .normal)
        
        let urlString = model.imageURL
        guard let url = URL(string: urlString) else { return }
        
        getImage(url: url)
    }
    
    private func getImage(url: URL) {
        NetworkImageFetch.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.imageViewPizza.image = image
                }
            case .failure(let error):
                print("CellConfig error:\(error.localizedDescription)")
            }
        }
    }
}
