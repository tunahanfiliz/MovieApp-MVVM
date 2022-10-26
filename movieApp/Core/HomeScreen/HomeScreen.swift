//
//  HomeScreen.swift
//  movieApp
//
//  Created by Ios Developer on 24.10.2022.
//

import UIKit

protocol HomeScreenInterface : AnyObject{ //homeviewmodel de bi ifade buraya erişemiyo erişim için anyobject
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateToDetailScreen(movie:MovieResult)
}

final class HomeScreen: UIViewController{
    
    private let viewModel = HomeViewModel()
    
    private var collectionView : UICollectionView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}


extension HomeScreen:HomeScreenInterface{
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Popular Movies 🔥"
    }
    func configureCollectionView() {
      
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        
        collectionView.pinToEdgesOf(view: view)
    }
        
    func reloadCollectionView() {
       
        /* reload data edebilecegimiz fazladan collectionviewimiz olabilir her yere dispatque.main.async yazmak yerine collectionviewe extension yazıp burda direkt kullanabiliriz
        DispatchQueue.main.async {
            self.collectionView.reloadData()
         
        } gerçek ornek aşagıda*/
        self.collectionView.reloadOnMainThread()
    }
    
    func navigateToDetailScreen(movie:MovieResult) {
        DispatchQueue.main.async {
            let detailScreen = DetailScreen(movie:movie)
            self.navigationController?.pushViewController(detailScreen, animated: true) //bir sonraki hedef sayfaya pushlamak
        }
        
        
    }
    
}


extension HomeScreen: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        
        cell.setCell(movie: viewModel.movies[indexPath.item])
        
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(id: viewModel.movies[indexPath.item]._id)
    }
   
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { // aşagı dogru kaydırdıgımızda durursak scrool degerlerini vericek ve verimli çalışcak. ama sadece scrooldidview fonksiyonunu çagırsaydık her kaydırısta çıkcaktı veri kalabalıgı olcak ve kastırır.
        
        let offsetY = scrollView.contentOffset.y // y ekseninde kaydırıyoruz ya o değerleri verir
        let contentHeight = scrollView.contentSize.height // poster boyutu gibi bi sey
        let height = scrollView.frame.size.height // tüm sayfanın boyutu
        
        print("offsetY:\(offsetY)")
        print("contentHeight:\(contentHeight)")
        print("height:\(height)")
        print("")
        
        if offsetY >= contentHeight - (5 * height){
            viewModel.getMovies()
            
            // bu algoritma tüm uzunluktan şeyi çıkardıgımızda yani sayfanın yuzde 85i tamamlandıgında getmovies fonksiyonunu çağır demek. 20tane filmin yuzde 85 ini kaydırarak gördügümüz gibi diger 20 tane diziyi çagırcak ve böyle kaydırdıkça ilerlicek verilere ulascak
        }
       
    }
    
    
}
