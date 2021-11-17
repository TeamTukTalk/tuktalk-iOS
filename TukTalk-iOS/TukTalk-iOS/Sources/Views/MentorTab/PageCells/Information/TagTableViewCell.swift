//
//  TagTableViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/18.
//

import RxSwift

class TagTableViewCell: UITableViewCell {
    
    public static let identifier : String = "TagTableViewCell"
    private lazy var viewModel = InformationViewModel()
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel().then {
        $0.text = "태그 💬"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    var tagListCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setColectionView()
        bindingCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.equalToSuperview()
        }
        
        contentView.addSubview(tagListCV)
        tagListCV.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setColectionView() {
        tagListCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        let layout: UICollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .vertical
        tagListCV.setCollectionViewLayout(layout, animated: false)
        tagListCV.backgroundColor = .white
        tagListCV.showsHorizontalScrollIndicator = false
        tagListCV.allowsMultipleSelection = true
        tagListCV.register(TagListCollectionViewCell.self, forCellWithReuseIdentifier: "TagListCollectionViewCell")
    }
    private func bindingCollectionView() {
        
        viewModel.output.tagCellData
            .bind(to: tagListCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.tagListCV.dequeueReusableCell(withReuseIdentifier: "TagListCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? TagListCollectionViewCell {

                    cell.configure(title: item.title)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }

}

extension TagTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items: [TagCollectionViewDataModel] = []
        viewModel.output.tagCellData
            .subscribe(onNext: {data in
                items = data
            })
            .disposed(by: disposeBag)
        
        return TagListCollectionViewCell.fittingSize(availableHeight: 26, title: items[indexPath.row].title)
    }
}
