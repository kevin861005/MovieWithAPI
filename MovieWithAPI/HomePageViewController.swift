//
//  HomePageViewController.swift
//  MovieWithAPI
//
//  Created by NAI LUN CHEN on 2023/4/16.
//

import UIKit

class HomePageViewController: UIViewController {
    // 2023電影按鈕
    @IBOutlet weak var movieListButton: UIButton!
    
    // 宣告一個裝MovieInfo的陣列
    var movies: [MovieInfo] = [] {
        // 使用property observer，主要是因為呼叫API過程不是同步的，當有值的時候(API已回傳資料)再跳轉到下個頁面
        didSet {
            // 將performSegue加回到主線程非同步執行
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "movieListSegue", sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toMovieList(_ sender: Any) {
        
        getMovieInfo()
        
    }
    
    // 呼叫API
    func getMovieInfo() -> Void {
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=a23559d13fed39749e5b94e6fefd836e&language=zh-TW&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=2023&with_watch_monetization_types=flatrate";
        
        var movies = [MovieInfo]()

        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response , error in
                if let data {
                    let decoder = JSONDecoder()
                    do {
                        let movieListResponse = try
                        decoder.decode(MovieListResponse.self, from: data)
                        
                        let results = movieListResponse.results
                        
                        for (_, data) in results.enumerated() {
                            let backdrop_path: String = data.backdrop_path
                            let id: Int = data.id
                            let overview: String = data.overview
                            let title: String = data.title
                            let release_date: String = data.release_date
                            
                            print(title)
                            
                            movies.append(MovieInfo(backdrop_path: backdrop_path,
                                                    id: id,
                                                    overview: overview,
                                                    title: title,
                                                    release_date: release_date))
                            
                        }
                        
                        self.movies = movies
                    } catch {
                        print(error)
                    }
                } else {
                    print(error)
                }
            }.resume()
        }
    }
    
    @IBSegueAction func toMovieListSegue(_ coder: NSCoder) -> MovieListTableViewController? {
        let movieListTableViewController = MovieListTableViewController(coder: coder)
        
        movieListTableViewController?.movies = movies
        
        return movieListTableViewController
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
