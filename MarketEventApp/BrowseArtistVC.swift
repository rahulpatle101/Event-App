//
//  BrowseArtistVC.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/6/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import UIKit

class BrowseArtistVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var artist = [Artist]()
    var filteredArtist = [Artist]()
    
    var inSearchMode = false
    
//    var artists[] =[Lisa Sulton  ,Nena Plata  ,Lenita Newell  ,Jama Lieb  ,Jessenia Degen  ,Gayle Halter  ,Leon Troia  ,Donnell Sweeten  ,Pearlie Kaup  ,Trevor Prosperie  ,Agnus Weiss  ,Kathie Avilez  ,Hae Desroches  ,Terrilyn Burdette  ,Stefany Hibbler  ,Loura Peter  ,Sherie Glaser  ,Damian Chisolm  ,Shantae Gartner  ,Monet Anaya  ,Garnet Phillippi  ,Ossie Borrero  ,Ethan Talarico  ,Milan Hudak  ,Romana Bodine  ,Serita Dobbin  ,Charmain Mabrey  ,Anna Reali  ,Erwin Monsen  ,Jacalyn Berkeley  ,Elaina Sponsler  ,Gisela Crusoe  ,Alva Hyre  ,Lani Thierry  ,Marleen Mcfaul  ,Kraig Sjogren  ,Avery Pettit  ,Charise Brosius  ,Roselee Bonneau  ,Robbyn Hedman  ,Sasha Kiel  ,Louetta Langston  ,Otilia Percival  ,Anette Gosier  ,Demetrice Dilley  ,Asha Montes  ,Latricia Newby  ,Julianna Leal  ,Clarine Ellard  ,Doreatha Farrah]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        let artist1 = Artist(name: "Lisa Sulton", id: 1)
        let artist2 = Artist(name: "Nena Plata ", id: 2)
        let artist3 = Artist(name: "Lenita Newell", id: 3)
        let artist4 = Artist(name: "Roselee Bonneau", id: 4)
        let artist5 = Artist(name: "Clarine Ellard", id: 5)
        let artist6 = Artist(name: "Asha Montes", id: 6)
        let artist7 = Artist(name: "Hae Desroches ", id: 7)
        let artist8 = Artist(name: "Avery Pettit", id: 8)
        let artist9 = Artist(name: "Stefany Hibbler", id: 9)
        let artist10 = Artist(name: "Leon Troia", id: 10)
        let artist11 = Artist(name: "Pearlie Kaup", id: 11)
        let artist12 = Artist(name: "Otilia Percival", id: 12)
        let artist13 = Artist(name: "Doreatha Farrah", id: 13)
        let artist14 = Artist(name: "Jessenia Degen", id: 14)
        
//        artist.append(artist1)
//        artist.append(artist2)
//        artist.append(artist3)
//        artist.append(artist4)
//        artist.append(artist5)
//        artist.append(artist6)
//        artist.append(artist7)
//        artist.append(artist8)
//        artist.append(artist9)
//        artist.append(artist10)
//        artist.append(artist11)
//        artist.append(artist12)
//        artist.append(artist13)
//        artist.append(artist14)
        
        parseArtistDataCSV()
        
    }
    
    func parseArtistDataCSV() {
        let path = Bundle.main.path(forResource: "ArtistName", ofType: "csv")!

        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
//                if row["ArtistName"] != "" {
                    let artistName = String(row["ArtistName"]!)
//                } else {
//                    let artistName = "No Name"
//                }
                
//                if row["ArtistID"] != "" {
                    let artistID = Int(row["ArtistID"]!)!
//                }
                
                let arti = Artist(name: artistName!, id: artistID)
                artist.append(arti)
  
            }
            print(rows)
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for:indexPath) as? ArtistCell {
            
            
//            let artist = Artist(name: "Artist Name", id: indexPath.row)
            let arti: Artist!
            
            if inSearchMode {
                arti = filteredArtist[indexPath.row]
            } else {
                arti = artist[indexPath.row]
            }
            cell.configureCell(arti)
            return cell
            
        } else {
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var arti: Artist!
        
        if inSearchMode {
            arti = filteredArtist[indexPath.row]
        } else {
            arti = artist[indexPath.row]
        }
        
        performSegue(withIdentifier: "ArtistDetailVC", sender: arti)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredArtist.count
        }
        
        return artist.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 85)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
            
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredArtist = artist.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ArtistDetailVC" {
            if let detailVC = segue.destination as? ArtistDetailVC {
                if let arti = sender as? Artist {
                    detailVC.artistDetail = arti
                }
            }
        }
        
    }

}
