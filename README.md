# 西成泥酔旅行（Nishinari Izakaya Crawl）
<img src="app/assets/images/eyecatch.gif">

サービスURL: https://nishinari-izakaya.net

## サービス概要

西成泥酔旅行（英題：Nishinari Izakaya Crawl）は、大阪市西成区で居酒屋巡りをするためのサービスです。

## サービス開発の背景

サービス名にある「西成」は、大阪市西成区の「新今宮エリア」を指しています。（参考: [大阪市西成区役所「新今宮ワンダーランド」Web サイト](https://shin-imamiya-osaka.com/)）

私はこのエリアで 8 年前から飲み歩きを始め、100 店舗以上の居酒屋を巡ってきました。

安くておいしい上に、人情味を感じるあたたかい雰囲気のお店がたくさんあり、いわゆる「ハシゴ酒」をするのにぴったりなエリアです。

今までは私自身が友人などを案内し、その魅力を細々と伝えていましたが、私が培った知識を全て落とし込んだサービスを開発し、より多くの人に西成で居酒屋巡りをする楽しさを伝えたいと考えました。

## ターゲットユーザー

### 西成に訪れる全国の観光客および外国人観光客

かつては西成といえば「治安の悪い街」というイメージが色濃くありましたが、近年は主要観光地へのアクセスの良さから、若者や外国人観光客が多く訪れるスポットになっています。

西成が単なる交通の乗り換え地や宿泊地ではなく、「旅の目的地」になるということをサービスを通して知っていただき、居酒屋巡りを楽しんでほしいと考えています。

## 機能一覧

| 居酒屋検索 |
| :---: |
| <img src="https://i.gyazo.com/49407920ec5938cd21e2fe028ba1de9d.png" alt="izakaya_search" width="450" /> |

<p align="left">ログイン不要で、DBに登録されている珠玉の居酒屋を検索できます。主に居酒屋に紐づくタグで絞り込みを行い、ユーザーのニーズに合った居酒屋を探していただくことを想定しています。タグは複数指定可能です。</p>
<br>

| マップ検索（Google Maps API） |
| :---: |
| <img src="https://i.gyazo.com/55dbb8eb49b785ba9fa4593aad2188fd.png" alt="map_search" width="450" /> |

<p align="left">Google Mapから居酒屋を探すことも可能です。また、ユーザーの現在地から近い居酒屋を10件絞り込みする機能を実装しています。</p>
<br>

| 居酒屋詳細情報 |
| :---: |
| <img src="https://i.gyazo.com/1f5a7d4577bd237415a851a787276e20.png" alt="izakaya_show" width="450" /> |

<p align="left">詳細画面では、店名を基にしたYouTube検索に加え、Google Mapへの遷移及び現在地からの行程検索のリンクを配置しています。ユーザーが気になった居酒屋に対してより多くの情報を得ていただけます。</p>
<br>

| 旅程表の作成 |
| :---: |
| <img src="https://i.gyazo.com/cd306f09fe11c94bba2fd640c370b2b0.jpg" alt="plan_show" width="450" /> |

<p align="left">ログインユーザーは飲み歩きの旅程表を作成し、行きたい居酒屋をリストとして登録することができます。登録した居酒屋はドラック&ドロップで行きたい順に並べ替えができます。また、他のユーザーに対して旅程表の公開・非公開を選択でき、公開している旅程表はXでシェアすることができます。</p>
<br>

| マイページ |
| :---: |
| <img src="https://i.gyazo.com/bccd3546a02cb1de6c6d111a385c3cca.png" alt="mypage" width="450" /> |

<p align="left">マイページではユーザーがお気に入り登録した居酒屋と作成した旅程表を確認することができます。</p>
<br>

| 英語への切り替え |
| :---: |
| <img src="https://i.gyazo.com/56c0920c3e286a35e436445eb3848ed2.jpg" alt="English_view" width="450" /> |

<p align="left">外国人観光客にも使っていただけるよう英語ビューに対応しています。</p>
<br>

## 技術スタック

- フロントエンド: Tailwind CSS (v3.4.3), DaisyUI (v4.11.1), Hotwire
- バックエンド: Ruby (v3.2.3), Ruby on Rails (v7.0.4)
- データベース: PostgreSQL (v16.2)
- 認証: Google OAuth
- インフラ: Docker (v20.10.8), Koyeb
- API: Google Maps API

## 画面遷移図

[こちらをご確認ください（Figma リンク）](https://www.figma.com/design/7HnO9Pu5IqJVVStRWN1Ehm/Nishinari-Izakaya-Crawl?m=dev&node-id=0%3A1&t=D6XPauzNMDk5uAM0-1)

## ER 図

```mermaid
erDiagram
  users ||--o{ favorites : "1人のユーザーは0以上のお気に入りを持つ"
  users ||--o{ plans : "1人のユーザーは0以上の旅程表を持つ"
  izakayas ||--o{ favorites : "1つの居酒屋は0以上のお気に入りを持つ"
  izakayas ||--o{ izakaya_tags : "1つの居酒屋は0以上のタグを持つ"
  tags ||--o{ izakaya_tags : "1つのタグは0以上の居酒屋を持つ"
  plans ||--|{ izakaya_plans : "1つの旅程表は複数の居酒屋を持つ"
  izakayas ||--o{ izakaya_plans : "1つの居酒屋は0以上の旅程表を持つ"

  users {
    bigint id PK
    string uid "UID"
    string name "ユーザー名"
    string email
    string crypted_password
    string salt
    timestamp created_at
    timestamp updated_at
  }

  izakayas {
    bigint id PK
    string name "居酒屋名"
    string formatted_address
    float lat "緯度"
    float lng "経度"
    string photo_reference "画像リファレンス"
    string photo_reference "画像"
    string opening_hours "営業時間"
    string description "説明"
    string url "Google Places ID"
    timestamp created_at
    timestamp updated_at
  }

  tags {
    bigint id PK
    string name "タグ名"
    timestamp created_at
    timestamp updated_at
  }

  favorites {
    bigint id PK
    references user FK
    references izakaya FK
    timestamp created_at
    timestamp updated_at
  }

  plans {
    bigint id PK
    references user FK
    string name "旅程表名"
    string description "説明"
    boolean public
    timestamp created_at
    timestamp updated_at
  }

  izakaya_tags {
    bigint id PK
    references izakaya FK
    references tag FK
    timestamp created_at
    timestamp updated_at
  }

  izakaya_plans {
    bigint id PK
    references plan FK
    references izakaya FK
    timestamp created_at
    timestamp updated_at
  }
```
