//
//  InformationPhotoViewController.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit
import SDWebImage

class InformationPhotoViewController: BaseViewController {
    private let unsplush: UnsplashResult
    private let profileImageView: UIImageView = .init()
    private let nameLabel: UILabel = .init()
    private let instagramName: UILabel = .init()
    private let imageView: UIImageView = .init()
    
    
    init(unsplush data: UnsplashResult) {
        self.unsplush = data
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupConstraints()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupView()
        view.backgroundColor = .systemGray6
        setupData()
    }
    
    
    private func setupConstraints() {
        view.addSubviews(profileImageView, nameLabel, instagramName, imageView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            instagramName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            instagramName.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            instagramName.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            imageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
    
    private func setupView() {
        profileImageView.backgroundColor = .red
        profileImageView.cornerRadius = 30
        profileImageView.borderColor = .white
        profileImageView.borderWidth = 2
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        instagramName.font = .systemFont(ofSize: 14, weight: .medium)
        instagramName.textColor = .systemPink
        
        imageView.cornerRadius = 20
        imageView.borderColor = .white
        imageView.layer.borderWidth = 5
        imageView.backgroundColor = .systemGray4
    }
    
    private func setupData() {
        if let images = unsplush.user?.profile_image, let string = images.small,
            let url = URL(string: string) {
            
            profileImageView.sd_setImage(with: url)
        }
        
        if let images = unsplush.urls, let string = images.small ?? images.regular,
            let url = URL(string: string) {
            
            imageView.sd_setImage(with: url)
        }
        
        nameLabel.text = unsplush.user?.name ?? "No name"
        instagramName.text = unsplush.user?.instagram_username
    }
    
    private func setupItems() {
        
        let button = UIBarButtonItem(image: .init(systemName: "heart.fill"), style: .done, target: self, action: #selector(heartSelectAction(_:)))
        
        let id  = unsplush.id ?? ""
        let isLike = FavoriteDataModel.shared.isOnFavorite(id)
        
        button.tintColor = isLike ? .red : .systemGray3
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func heartSelectAction(_ sender: UIBarButtonItem) {
        
        let isLike = FavoriteDataModel.shared.didSelect(unsplush)
        
        sender.tintColor = isLike ?  .red : .systemGray3
        
    }
}





//MARK: - Test
struct TestData {
    
    static var result: UnsplashResult {
        guard let data = string.data(using: .utf8),
              let json = try? JSONDecoder().decode(UnsplashResult.self, from: data)
        else { return .init(id: "dwasdasddsa", urls: .init(raw: "https://images.unsplash.com/photo-1518780664697-55e3ad937233?ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA&ixlib=rb-4.0.3",
                                        full: "https://images.unsplash.com/photo-1518780664697-55e3ad937233?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA&ixlib=rb-4.0.3&q=85",
                                        regular: "https://images.unsplash.com/photo-1518780664697-55e3ad937233?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA&ixlib=rb-4.0.3&q=80&w=1080",
                                        small: nil,
                                        thumb: nil,
                                        small_s3: nil),
                            description: nil, likes: nil, liked_by_user: true, user:
                .init(name: "Luke Stackpoole", instagram_username: "withluke", profile_image: .init(raw: nil,
                                                                                                    full: nil,
                                                                                                    regular: nil,
                                                                                                    small: "https://images.unsplash.com/profile-1606730560655-b1b7d2b39c90image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
                                                                                                    thumb: nil,
                                                                                                    small_s3: nil)))}
        
        return json
    }
    
    static var string: String = """
{
            "id": "eWqOgJ-lfiI",
            "slug": "red-and-white-house-surround-green-grass-field-eWqOgJ-lfiI",
            "alternative_slugs": {
                "en": "red-and-white-house-surround-green-grass-field-eWqOgJ-lfiI",
                "es": "la-casa-roja-y-blanca-rodean-el-campo-de-hierba-verde-eWqOgJ-lfiI",
                "ja": "赤と白の家が緑の芝生を囲む-eWqOgJ-lfiI",
                "fr": "la-maison-rouge-et-blanche-entoure-le-champ-dherbe-verte-eWqOgJ-lfiI",
                "it": "la-casa-rossa-e-bianca-circonda-il-campo-di-erba-verde-eWqOgJ-lfiI",
                "ko": "붉은-집과-흰-집이-푸른-잔디밭을-둘러싸고-있습니다-eWqOgJ-lfiI",
                "de": "rotes-und-weisses-haus-umgeben-grune-rasenflache-eWqOgJ-lfiI",
                "pt": "casa-vermelha-e-branca-cercam-campo-de-grama-verde-eWqOgJ-lfiI"
            },
            "created_at": "2018-02-16T11:32:19Z",
            "updated_at": "2024-04-26T02:30:39Z",
            "promoted_at": "2018-02-16T15:12:42Z",
            "width": 5105,
            "height": 6381,
            "color": "#f3f3f3",
            "blur_hash": "L_L4g6fko#oL~qj[ofaytRj[Rjj[",
            "description": "Cute Cabin | Check out my Instagram - @WithLuke",
            "alt_description": "red and white house surround green grass field",
            "breadcrumbs": [
                {
                    "slug": "images",
                    "title": "1,000,000+ Free Images",
                    "index": 0,
                    "type": "landing_page"
                },
                {
                    "slug": "things",
                    "title": "Things Images",
                    "index": 1,
                    "type": "landing_page"
                },
                {
                    "slug": "house",
                    "title": "House Images",
                    "index": 2,
                    "type": "landing_page"
                }
            ],
            "urls": {
                "raw": "https://images.unsplash.com/photo-1518780664697-55e3ad937233?ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA&ixlib=rb-4.0.3",
                "full": "https://images.unsplash.com/photo-1518780664697-55e3ad937233?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA&ixlib=rb-4.0.3&q=85",
                "regular": "https://images.unsplash.com/photo-1518780664697-55e3ad937233?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA&ixlib=rb-4.0.3&q=80&w=1080",
                "small": "https://images.unsplash.com/photo-1518780664697-55e3ad937233?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA&ixlib=rb-4.0.3&q=80&w=400",
                "thumb": "https://images.unsplash.com/photo-1518780664697-55e3ad937233?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA&ixlib=rb-4.0.3&q=80&w=200",
                "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1518780664697-55e3ad937233"
            },
            "links": {
                "self": "https://api.unsplash.com/photos/red-and-white-house-surround-green-grass-field-eWqOgJ-lfiI",
                "html": "https://unsplash.com/photos/red-and-white-house-surround-green-grass-field-eWqOgJ-lfiI",
                "download": "https://unsplash.com/photos/eWqOgJ-lfiI/download?ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA",
                "download_location": "https://api.unsplash.com/photos/eWqOgJ-lfiI/download?ixid=M3w0NjcyMzd8MHwxfHNlYXJjaHwxfHwlRDAlQjQlRDAlQkUlRDAlQkN8cnV8MHx8fHwxNzE0MjE1Mzg0fDA"
            },
            "likes": 3618,
            "liked_by_user": false,
            "current_user_collections": [],
            "sponsorship": null,
            "topic_submissions": {
                "color-of-water": {
                    "status": "approved",
                    "approved_on": "2022-04-21T15:21:33Z"
                }
            },
            "asset_type": "photo",
            "user": {
                "id": "7DedRhPGJw8",
                "updated_at": "2024-04-25T03:32:03Z",
                "username": "withluke",
                "name": "Luke Stackpoole",
                "first_name": "Luke",
                "last_name": "Stackpoole",
                "twitter_username": null,
                "portfolio_url": "http://www.withluke.com",
                "bio": "Instagram: @WithLuke \r\nFreelance photographer, London || Available worldwide  ✉ - info@withluke.com   ||   Lightroom Presets - www.withlukestudios.com",
                "location": "London",
                "links": {
                    "self": "https://api.unsplash.com/users/withluke",
                    "html": "https://unsplash.com/@withluke",
                    "photos": "https://api.unsplash.com/users/withluke/photos",
                    "likes": "https://api.unsplash.com/users/withluke/likes",
                    "portfolio": "https://api.unsplash.com/users/withluke/portfolio",
                    "following": "https://api.unsplash.com/users/withluke/following",
                    "followers": "https://api.unsplash.com/users/withluke/followers"
                },
                "profile_image": {
                    "small": "https://images.unsplash.com/profile-1606730560655-b1b7d2b39c90image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
                    "medium": "https://images.unsplash.com/profile-1606730560655-b1b7d2b39c90image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
                    "large": "https://images.unsplash.com/profile-1606730560655-b1b7d2b39c90image?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
                },
                "instagram_username": "withluke",
                "total_collections": 0,
                "total_likes": 7,
                "total_photos": 97,
                "total_promoted_photos": 85,
                "total_illustrations": 0,
                "total_promoted_illustrations": 0,
                "accepted_tos": true,
                "for_hire": true,
                "social": {
                    "instagram_username": "withluke",
                    "portfolio_url": "http://www.withluke.com",
                    "twitter_username": null,
                    "paypal_email": null
                }
            }
"""
}

