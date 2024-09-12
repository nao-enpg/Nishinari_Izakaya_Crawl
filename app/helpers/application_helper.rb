module ApplicationHelper
  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def default_meta_tags
    def default_meta_tags
    {
      site: '西成泥酔旅行',
      title: '西成泥酔旅行',
      reverse: true,
      separator: '|',
      description: '',
      keywords: '',   #「,」区切りで設定
      canonical: request.original_url,
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        image: image_url('ogp.png')
      }
    }
    end
  end
end
