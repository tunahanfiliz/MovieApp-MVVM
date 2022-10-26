//
//  MovieCell.swift
//  movieApp
//
//  Created by Ios Developer on 24.10.2022.
//

import UIKit

class MovieCell: UICollectionViewCell {

   static let reuseID = "MovieCell"
    private var posterImageView: PosterImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configurePosterImageView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() { // aşağı dogru kaydırdıkca celleri 0 ıncı index 4. index yerine geçerek kasmaları azaltır bu da atıyorum bir sonraki indexi sıfırlayarak karışıklıgı onler.
        posterImageView.image = nil // boş yapıyoruz posterin imagesini
        posterImageView.cancelDownloading() 
    }
    
    func setCell(movie:MovieResult){
        posterImageView.downloadImage(movie: movie)
    }
    
    
    
    private func configureCell(){
        backgroundColor = .systemGray5
        layer.cornerRadius = 16
        clipsToBounds = true // bu radiuslu cellin üstüne alt tarafta poster koyduk ya o poster radiusların üstüne geliyo doalyısıyla radiuslar gitmesin diye gerekli olan kod.
    }
    
    private func configurePosterImageView(){
        posterImageView = PosterImageView(frame: .zero)
        addSubview(posterImageView)
        
        posterImageView.pinToEdgesOf(view: self)
    }
    
}
