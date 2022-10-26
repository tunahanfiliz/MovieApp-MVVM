//
//  DetailViewModel.swift
//  movieApp
//
//  Created by Ios Developer on 26.10.2022.
//

import Foundation

protocol DetailViewModelInterface {
 
    var view : DetailScreenInterface? {get set}
    
    func viewDidLoad()
}


final class DetailViewModel {
    
    weak var view : DetailScreenInterface?
    
}

extension DetailViewModel: DetailViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configurePosterImageView()
        view?.downloadPosterImage()
        view?.configureTitleLabel()
        view?.configureDateLabel()
        view?.configureOverviewLabel()
    }
}
