import UIKit
import ATListVM

struct Discovery {
    
}

extension Discovery {
    
    class BannerCell: ATListCell {
        
        lazy var imageView = UIImageView().then { v in
            v.backgroundColor = .random
        }
        override func setupData() {
            
        }
        override func setupSubviews() {
            contentView.addSubview(imageView)
        }
        override func setupLayout() {
            imageView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.bottom.equalToSuperview()
            }
        }
    }
    
    class TopicsCell: ATListCell, Community.RolllingBatchView.Delegate{
        //Community.RolllingBatchView.Delegate
        func rollingBatchViewForDatas() -> [any Community.RolllingBatchView.RowDataProtocol] {
            guard let vm = itemVM as? TopicsItemVM else {
                return []
            }
            return vm.datas
        }
        
        func rollingBatchViewDidClick(index: Int, data: any Community.RolllingBatchView.RowDataProtocol) {
            
        }
        //----
        lazy var rollingView = Community.RolllingBatchView().then { v in
            v.delegate = self
        }
        override func setupSubviews() {
            contentView.backgroundColor = .random
            contentView.addSubview(rollingView)
        }
        override func setupLayout() {
            rollingView.snp.makeConstraints { make in
                make.leading.top.bottom.trailing.equalToSuperview().inset(0)
            }
        }
        override func refreshSubviews(isFromVM: Bool) {
            super.refreshSubviews(isFromVM: isFromVM)
            guard let itemVM = itemVM as? TopicsItemVM else {
                return
            }
            rollingView.config(datas: itemVM.datas)
        }
    }
    
    class SearchCell: ATListCell {
        override func setupData() {
            
        }
        override func setupSubviews() {
            contentView.backgroundColor = .random
        }
        override func setupLayout() {
            
        }
    }
    
    class GuidelineCell: ATListCell {
        override func setupData() {
            
        }
        override func setupSubviews() {
            contentView.backgroundColor = .random
        }
        override func setupLayout() {
            
        }
    }
    class PostCell: ATListCell {
        override func setupData() {
            
        }
        override func setupSubviews() {
            contentView.backgroundColor = .random
        }
        override func setupLayout() {
            
        }
    }
        
    class BannerItemVM: ATListItemVM {
        override func setupData() {
            super.setupData()
            cellId = "BannerCell"
        }
    }
    class TopicsItemVM: ATListItemVM {
        override func setupData() {
            super.setupData()
            cellId = "TopicsCell"
        }
        override func createLayout() {
            var datas:[TopicData] = []
            for i in 0...3 {
                let data = TopicData()
                data.title = "推荐话题 - 标题\(i)"
                datas.append(data)
            }
            self.datas = datas
        }
        func createLayout1() {
            cellId = "TopicsCell"
            var datas:[TopicData] = []
            for i in 0...3 {
                let data = TopicData()
                data.title = "推荐话题 - 标题\(i)"
                datas.append(data)
            }
            self.datas = datas
        }
        func createLayout2() {
            cellId = "TopicsCell"
            var datas:[TopicData] = []
            for i in 0...1 {
                let data = TopicData()
                data.title = "推荐话题 - 标题\(i)"
                datas.append(data)
            }
            self.datas = datas
        }
        var datas:[TopicData] = []
        class TopicData: Community.RolllingBatchView.RowDataProtocol {
            var icon: String = ""
            var title: String = ""
            var numIcon: String = ""
            var num: Int = 0
        }
    }
    class SearchItemVM: ATListItemVM {
        override func setupData() {
            super.setupData()
            cellId = "SearchCell"
        }
    }
    class GuidelineItemVM: ATListItemVM {
        override func setupData() {
            super.setupData()
            cellId = "GuidelineCell"
        }
    }
    class PostItemVM: ATListItemVM {
        override func setupData() {
            super.setupData()
            cellId = "PostCell"
        }
    }
}

extension ATListSectionVM {
    fileprivate static func createBannerLlayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(305.rate),heightDimension: .absolute(140.rate))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = floor(15.rate)
        section.contentInsets = .init(top: 10, leading: floor(15.rate), bottom: 10, trailing: floor(15.rate))
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    static func createTopicsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(10))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .estimated(10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = .init(top: 15, leading: 15.rate, bottom: 25, trailing: 15.rate)
        return section
    }
    fileprivate static func createSearchLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35.rate))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(35.rate))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 15.rate, bottom: 0, trailing: 15.rate)
        return section
    }
    fileprivate static func createGuidelineLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(27.rate))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(27.rate))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 12, leading: 15.rate, bottom: 0, trailing: 15.rate)
        return section
    }
    fileprivate static func createPostLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300.rate))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .estimated(300.rate))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

class DiscoveryListVM: ATListVM{
    
    override func register(collectionView: UICollectionView) {
        super.register(collectionView: collectionView)
        collectionView.register(Discovery.BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.register(Discovery.TopicsCell.self, forCellWithReuseIdentifier: "TopicsCell")
        collectionView.register(Discovery.TopicsCell.self, forCellWithReuseIdentifier: "TopicsCell3")
        collectionView.register(Discovery.TopicsCell.self, forCellWithReuseIdentifier: "TopicsCell4")
        collectionView.register(Discovery.SearchCell.self, forCellWithReuseIdentifier: "SearchCell")
        collectionView.register(Discovery.GuidelineCell.self, forCellWithReuseIdentifier: "GuidelineCell")
        collectionView.register(Discovery.PostCell.self, forCellWithReuseIdentifier: "PostCell")
    }
    
    override func setupData() {
        
    }
    
    override func createData() {
        var sectionVMs:[ATListSectionVM] = []
        do {
            let sectionVM = ATListSectionVM()
            sectionVM.layoutSection = ATListSectionVM.createBannerLlayoutSection()
            for i in 0...1 {
                let itemVM = Discovery.BannerItemVM()
                sectionVM.itemVMs.append(itemVM)
            }
            sectionVMs.append(sectionVM)
        }
        do {
            let sectionVM = ATListSectionVM()
            sectionVM.layoutSection = ATListSectionVM.createTopicsLayoutSection()
            sectionVMs.append(sectionVM)
            
            for i in 0...10 {
                let itemVM = Discovery.TopicsItemVM()
                if i % 2 == 0 {
                    itemVM.createLayout1()
                }else{
                    itemVM.createLayout2()
                }
                sectionVM.itemVMs.append(itemVM)
            }
            
//            let itemVM = Discovery.TopicsItemVM()
//            itemVM.createLayout()
//            sectionVM.itemVMs.append(itemVM)
        }
        do {
            let sectionVM = ATListSectionVM()
            sectionVM.layoutSection = ATListSectionVM.createSearchLayoutSection()
            sectionVMs.append(sectionVM)
            
            let itemVM = Discovery.SearchItemVM()
            sectionVM.itemVMs.append(itemVM)
        }
        do {
            let sectionVM = ATListSectionVM()
            sectionVM.layoutSection = ATListSectionVM.createGuidelineLayoutSection()
            sectionVMs.append(sectionVM)
            
            let itemVM = Discovery.GuidelineItemVM()
            sectionVM.itemVMs.append(itemVM)
        }
        do {
            let sectionVM = ATListSectionVM()
            sectionVM.layoutSection = ATListSectionVM.createPostLayoutSection()
            for i in 0...20 {
                let itemVM = Discovery.PostItemVM()
                sectionVM.itemVMs.append(itemVM)
            }
            sectionVMs.append(sectionVM)
        }
        viewProxy.sectionVMs = sectionVMs
    }
    
}
