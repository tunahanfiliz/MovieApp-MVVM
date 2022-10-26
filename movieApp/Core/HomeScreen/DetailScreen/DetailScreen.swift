//
//  DetailScreen.swift
//  movieApp
//
//  Created by Ios Developer on 25.10.2022.
//

import UIKit

protocol DetailScreenInterface: AnyObject {
    
    func configureVC()
    func configurePosterImageView()
    func downloadPosterImage()
    
    func configureTitleLabel()
    func configureDateLabel()
    func configureOverviewLabel()
    
}


final class DetailScreen: UIViewController {

    private let movie: MovieResult
    
    private let viewModel = DetailViewModel()
    
    private var posterImageView : PosterImageView!
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var overviewLabel: UILabel!
   
    
    private let padding: CGFloat = 16
    
    init(movie: MovieResult) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    

}

extension DetailScreen: DetailScreenInterface{
  
    func configureVC() {
        
        view.backgroundColor = .systemBackground
    }
    
    func configurePosterImageView() {
        posterImageView = PosterImageView(frame: .zero)
        view.addSubview(posterImageView)
        posterImageView.layer.cornerRadius = 16
        posterImageView.clipsToBounds = true //köşeleri geçmesin diye resim

        let posterWidth = CGFloat.dWidth * 0.4
        
        NSLayoutConstraint.activate([
        
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            posterImageView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterImageView.heightAnchor.constraint(equalToConstant: posterWidth * 1.5)
        
        ])
        
        posterImageView.backgroundColor = .red
    }
    func downloadPosterImage() {
        posterImageView.downloadImage(movie: movie)
    }
    
    func configureTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 2 //2 satır olabilir demek bu yazının . yoksa uzayıp gidiyor gözükmüyor. 0 yapsaydık sonsuz tane satır demek 
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = movie._title //titleyi optionaldan cıkardık
        titleLabel.font = .boldSystemFont(ofSize: 27)
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding)
        ])
    }
    
    func configureDateLabel() {
        dateLabel = UILabel(frame: .zero)
        view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.text = movie._releaseDate
        dateLabel.font = .boldSystemFont(ofSize: 18)
        dateLabel.textColor = .secondaryLabel //silik şekilde gözüksün diye
        
        NSLayoutConstraint.activate([
        
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 3 * padding),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    func configureOverviewLabel() {
        overviewLabel = UILabel(frame: .zero)
        view.addSubview(overviewLabel)
    
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overviewLabel.text = movie._overview
        overviewLabel.font = .boldSystemFont(ofSize: 18)
        overviewLabel.numberOfLines = 0
       
        
        NSLayoutConstraint.activate([
        
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 2 * padding),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
            
        
        ])
    }
}
 
