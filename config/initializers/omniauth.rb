Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '250290583722-eufr03g5u0gglcgf0thjg4c9589jbijf.apps.googleusercontent.com', 'cL4LZNTqoZxi0lNoBK3AInxn'
    {
      :image_aspect_ratio => "square",
      :image_size => 50
    }
end