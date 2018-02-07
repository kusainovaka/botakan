import UIKit
import EasyPeasy

class ZhanyltViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {

    var zhanultParse = [ParsingJSON]()
    var detailLabel: DetailLabels = {
        let view = DetailLabels(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 175))
        view.nameLabel.text = "Жаңылтпаштар"
        return view
    }()
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.ZhanultLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CLImage.self, forCellWithReuseIdentifier: "zhanultCell")
        return collectionView
    }()
    fileprivate lazy var ZhanultLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 25
        layout.sectionInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        return layout
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
         getFromJSON()
        view.addSubview(detailLabel)
        view.addSubview(collectionView)
        layouyts()
       
        detailLabel.backBTN.addTarget(self, action: #selector(backToBTN), for: .touchUpInside)

}
    @objc func backToBTN(){
        navigationController?.popViewController(animated: false)
    }
    
    func getFromJSON(){
        do {
            if let path = Bundle.main.url(forResource: "ZhanylData", withExtension: "json") {
                let url = try Data(contentsOf: path)
                let jsonData = try
                    JSONDecoder().decode([ParsingJSON].self, from: url)
                self.zhanultParse = jsonData
            } else { print("Error") }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return zhanultParse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zhanultCell", for: indexPath) as! CLImage
            cell.imageView.image = UIImage(named: zhanultParse[indexPath.row].photo)
            
            return cell
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         about(place: zhanultParse[indexPath.row])
        
    }
    
    func about(place: ParsingJSON){
        let vc = TakpakDetailsVC()
        vc.tempImage = place
        navigationController?.pushViewController(vc, animated: false)
    }
    func layouyts(){
        collectionView <- [
            Top(screenWidth / 2.3),
            Width(screenWidth),
            Left(10),
            Height(screenHeight / 1.08)
        ]
    }

}
