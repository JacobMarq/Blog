
Cloudinary.config do |config|
    config.cloud_name = "dapbkfu56"
    config.api_key = "527625893889414"
    config.api_secret = Rails.application.credentials.dig(:cloudinary_api_secret)
    config.secure = true
end  