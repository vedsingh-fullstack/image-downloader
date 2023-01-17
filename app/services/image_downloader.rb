# frozen_string_literal: true

require "open-uri"

module Services
  class ImageDownloader
    def self.download(file_path, batch_size = 10)
      image_urls = []

      File.foreach(file_path) do |line|
        image_urls.concat(line.strip.split)
      end

      image_urls.each_slice(batch_size) do |batch|
        batch.each do |url|
          uri = URI(url)
          image = uri.open

          file_name = File.basename(uri.path)
          folder_path = File.join(Dir.pwd, "images") # download the images inside images folder
          file_path = File.join(folder_path, file_name)

          File.open(file_path, "wb") do |file|
            file.write(image.read)
          end
          puts "Successfully downloaded #{url}"
        rescue OpenURI::HTTPError => e
          puts "Error downloading #{url}: #{e}"
        end
      end
    end
  end
end
