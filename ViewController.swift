//
//  ViewController.swift
//  Day1-StormViewer
//
//  Created by Brendan Giberson on 7/10/19.
//  Copyright © 2019 BrendanGiberson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  var pictures = [String]()
  
  override func viewDidLoad() {
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Picture")
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true

    title = "Storm Viewer"
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)
    
    for item in items {
      if item.hasPrefix("nssl") {
        pictures.append(item)
      }
    }
    pictures = pictures.sorted(by: <)
    print(pictures)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
      // 2: success! Set its selectedImage property
      vc.selectedImage = pictures[indexPath.row]
      vc.totalPictures = pictures.count;
      vc.selectedPictureNumber = indexPath.row + 1
      // 3: now push it onto the navigation controller
      navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return pictures.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

