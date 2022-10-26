//
//  HomeViewModel.swift
//  movieApp
//
//  Created by Ios Developer on 25.10.2022.
//

import Foundation

protocol HomeViewModelInterface {
    var view : HomeScreenInterface? {get set}
    func viewDidLoad()
    func getMovies()
}

final class HomeViewModel {
    weak var view: HomeScreenInterface?
    var movies : [MovieResult] = []
    
    private let service = MovieService()
    private var page : Int = 1
    
}

extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        getMovies()
        
    }
    
    func getMovies() {
        service.downloadMovies(page: page) { [weak self] movieReturned in
            guard let self = self else {return}
            guard let movieReturned = movieReturned else {return}
            //self.movies = movieReturned .bu bir sayfa olsaydı yeni sayfalar geliyo ekleyerek gitmeliyiz.
            self.movies.append(contentsOf: movieReturned)
            self.page += 1
            //reload yaptırmalıyız sayfalar geldikçe güncellensin
            self.view?.reloadCollectionView()
            // direkt burda reload yaptırmama sebebimiz viewmodel sadece emir verecek uikit çagırmadık o yüzden .
        }
    }
    
    func getDetail(id: Int) {
        service.downloadDetail(id: id) { [weak self] returnedDetail in
            guard let self = self else {return}
            guard let returnedDetail = returnedDetail else {return}
            print(returnedDetail)
            
            self.view?.navigateToDetailScreen(movie: returnedDetail) //burda aldıgımız returneddetaili homescreende navigateToDetailScreen fonksiyonunda detailScreene gönderdim
            
        }
    }
}

