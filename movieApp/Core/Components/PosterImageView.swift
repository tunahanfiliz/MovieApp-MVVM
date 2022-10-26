//
//  PosterImageView.swift
//  movieApp
//
//  Created by Ios Developer on 25.10.2022.
//

import UIKit

final class PosterImageView: UIImageView {

    private var dataTask: URLSessionDataTask?
    // datatask ı urlsessina eşitlersek aşagıda verilerini tutabiliriz bu da başlatmayı silmeyi falan saglar. bu değişkenin amacı indirme işlemlerini iptal etmek
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func downloadImage(movie: MovieResult){
        
        
        guard let url = URL(string: APIURLs.imageURL(posterPath: movie._posterPath)) else{return}
       /*
        // aşağıdaki kodlar url sessionu 2. kez çagıralarak yapıldı fakat biz networkmanagere gidersek ve ordaki @escaping degeri urlsesiondatatask döndürürsek burada kullanma sansımız var. aşağıdaki çünkü dataTask urlsessiondatatask değerinde. networkManagere git ve düzelt.
        
        dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            
            DispatchQueue.main.async {// arka planda çalıstıgı için kitleyebilir main  threade almalıyız.
                self.image = UIImage(data: data)
            }}*/
        
        
        dataTask = NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
             
            case .failure(_):
                break
            }
            
        }
        
      
      //  dataTask?.resume() burda resumeye gerek yok cunku network managerın ettigi resume yetiyor
    }
    func cancelDownloading(){
        
        //cell kısmında prepareforresue vardı ya indirilmeyen şeyleri veya gösterilip geçilen şeyleri silerek rahatlık sağlamalı aşagıda yazarak sağladık.
        dataTask?.cancel()
        dataTask = nil // urlsession bir class onu da boşaltıcaz. ramden silinebilmesi için
        
    }
   
}
