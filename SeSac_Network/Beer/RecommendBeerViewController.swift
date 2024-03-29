//
//  RecommendBeerViewController.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/16/24.
//

import UIKit
import Alamofire
import Kingfisher

class RecommendBeerViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var randomRecommendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        configureUI()
    }

    @IBAction func randomBtnClicked(_ sender: UIButton) {
        callRequest()
    }
}

extension RecommendBeerViewController {
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url).responseDecodable(of: [Beer].self) { response in
            switch response.result {
            case .success(let data):
                print(data)
                let url = URL(string: "\(data[0].image_url)")
                self.imageView.kf.setImage(with: url)
                self.nameLabel.text = data[0].name
                self.descriptionLabel.text = data[0].description
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
    func configureUI() {
        titleLabel.text = "오늘은 이 맥주를 추천합니다!"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        
        nameLabel.text = ""
        nameLabel.font = .boldSystemFont(ofSize: 15)
        nameLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFit
        
        descriptionLabel.text = ""
        descriptionLabel.numberOfLines = 0
        randomRecommendBtn.setTitle("맥주 랜덤 추천받기", for: .normal)
        randomRecommendBtn.setImage(UIImage(systemName: "dice.fill"), for: .normal)

    }
}
