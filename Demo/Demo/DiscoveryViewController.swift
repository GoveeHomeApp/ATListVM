import UIKit
import ATListVM

class DiscoveryViewController: LUFastViewController {
    
    lazy var listVM = DiscoveryListVM()
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            if let self = self {
                if let layoutSection = self.listVM.viewProxy.sectionVMs[sectionIndex].layoutSection {
                    return layoutSection
                }
            }
            
            //1 构造Item的NSCollectionLayoutSize
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(108.rate), heightDimension: .absolute(36.rate))
            // 2 构造NSCollectionLayoutItem
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 3 构造Group的NSCollectionLayoutSize
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .estimated(100))
            // 4 构造NSCollectionLayoutGroup
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(floor(10.5.rate))
            group.contentInsets = .init(top: 0, leading: 15.rate, bottom: 0, trailing: 15.rate)
            
            // 5 构造 header / footer
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(48.rate))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)

            // 6 构造NSCollectionLayoutSection
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 15.rate
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        return layout
    }
    
    lazy var collectionView:UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        v.backgroundColor = UIColor.clear
        v.backgroundColor = .random
        v.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        v.contentInsetAdjustmentBehavior = .never
        v.config(listVM: listVM)
        v.config(viewProxy: listVM.viewProxy)
        return v
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setupData() {
        super.setupData()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.backgroundColor = .random
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listVM.createData()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.listVM.reloadData()
//        }
//        listVM.delegate = self
        listVM.viewProxy.delegate = self
    }
}

extension DiscoveryViewController: ATListViewProxyDelegate {
    func listViewProxy(collectionView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        print("listViewProxy: cell: indexPath:\(indexPath.section),\(indexPath.item)")
    }
    func listViewProxy(collectionView: UICollectionView, footer: UICollectionReusableView, kind: String, indexPath: IndexPath) {
        
    }
}
