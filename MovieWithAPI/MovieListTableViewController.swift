//
//  MovieListTableViewController.swift
//  MovieWithAPI
//
//  Created by NAI LUN CHEN on 2023/4/16.
//

import UIKit
import Kingfisher

class MovieListTableViewController: UITableViewController {
    
    var movies = [MovieInfo]()
    var imageInfo: ImageInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovies()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieListTableViewCell.self)", for: indexPath) as! MovieListTableViewCell
        
        var movieInfo = movies[indexPath.row]
        cell.movieTitle.text = movieInfo.title
        cell.movieReleaseDate.text = "上映日期：\(movieInfo.release_date)"
                
        if let imageUrl = URL(string: imageInfo!.secure_base_url + "original" + movieInfo.poster_path) {
            cell.movieImage?.kf.setImage(with: imageUrl)
        }

        // Configure the cell...

        return cell
    }
    
    func fetchMovies() {
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=a23559d13fed39749e5b94e6fefd836e&language=zh-TW&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=2023&with_watch_monetization_types=flatrate";
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response , error in
                if let data {
                    let decoder = JSONDecoder()
                    do {
                        let movieListResponse = try decoder.decode(MovieListResponse.self,
                                                                   from: data)
                        self.movies = movieListResponse.results
                        
                        DispatchQueue.main.sync {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                        // show error alert
                    }
                } else {
                    // show error alert
                }
            }.resume()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
