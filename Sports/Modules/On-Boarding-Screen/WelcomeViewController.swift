//
//  WelcomeViewController.swift
//  Sports
//
//  Created by Youssef on 24/05/2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    // MARK:- Intialise New Varibles
    let stringArr = [
        """
 Our App helps users to know information about
 any leagues they want
 """ ,
        """
 Show Details For your favorite team,
 encourage him with you know about it all information
 """,
        """
 Sea olds results in your favorite league,
 see your team results
 """
              ]
    let imageArr = ["AllSports","Barchelona","ResultsImage"]
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "WelcomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WelcomeCollectionViewCell")
        /*
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
         section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 15
          , bottom: 0, trailing: 10)
         section.orthogonalScrollingBehavior = .continuous
         */
        /*
          
         */
        
        /*
         let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
             switch sectionIndex {
             case 0:
               return self.drowSectionZero()
             case 1:
                return self.drowSectionOne()
             case 2:
               return self.drowSectionTwo()
             default :
                return self.drowSectionZero()
             }
         }
         */
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        collectionView.reloadData()
        count += 1
        print("BeforeID: \(self.count)")
        print("ID: \(self.count)")
        let nextItem = IndexPath(row: count, section: 0)
        if nextItem.row == 1 {
            collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
            self.pageControl.currentPage = 1
        }
        else if nextItem.row == 2 {
            nextBtn.setTitle("let's do it", for: .normal)
            collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
            self.pageControl.currentPage = 2
        }
        else if nextItem.row == 3 {
            self.pageControl.currentPage = 3
            print("Finished!")
            let story = UIStoryboard(name: "Main", bundle: nil)
            let next  = story.instantiateViewController(withIdentifier: "HomeTabBar")
            next.modalPresentationStyle = .fullScreen
            self.present(next, animated: true, completion: nil)
        }
        else {
            collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }
    }
}
extension WelcomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WelcomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionViewCell", for: indexPath) as! WelcomeCollectionViewCell
        cell.titleLabel.text = stringArr[indexPath.row]
        cell.coverImageView.image = UIImage(named: imageArr[indexPath.row])
        return cell
    }
}
extension WelcomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
}
extension WelcomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        
         return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


