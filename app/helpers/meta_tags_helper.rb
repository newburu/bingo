module MetaTagsHelper
  def default_meta_tags
    {
      site: "Bingo Machine",
      title: "Simple Bingo",
      reverse: true,
      separator: "|",
      description: "A simple and easy-to-use Bingo Machine application.",
      keywords: "bingo, machine, game, party, rails",
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: "/icon.png", type: "image/png" },
        { href: "/icon.svg", type: "image/svg+xml" },
        { href: "/icon.png", rel: "apple-touch-icon", sizes: "180x180", type: "image/png" }
      ],
      og: {
        site_name: "Bingo Machine",
        title: "Simple Bingo",
        description: "A simple and easy-to-use Bingo Machine application.",
        type: "website",
        url: request.original_url,
        image: request.base_url + "/icon.png",
        locale: "ja_JP"
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account"
      }
    }
  end
end
