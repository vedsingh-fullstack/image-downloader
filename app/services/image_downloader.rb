# frozen_string_literal: true

require "open-uri"
require "fileutils"
require "logger"

module Services
  class ImageDownloader
    def self.download(file_path, batch_size = 10, image_folder = "./images")
      validate_file_path(file_path)
      create_image_folder(image_folder)

      @logger = Logger.new("./log/image_downloader.log")
      @invalid_urls = []
      @downloaded_images = 0

      download_images(file_path, batch_size, image_folder)
      log_download_statistics
    end

    def self.validate_file_path(file_path)
      raise ArgumentError, "Invalid file path: #{file_path}" unless File.file?(file_path)
    end

    def self.create_image_folder(image_folder)
      FileUtils.mkdir_p(image_folder) unless File.directory?(image_folder)
    end

    def self.download_images(file_path, batch_size, image_folder)
      image_urls = []

      File.foreach(file_path) do |line|
        image_urls.concat(line.strip.split)
      end

      image_urls.each_slice(batch_size) do |batch|
        batch.each do |url|
          uri = URI(url)
          image = uri.open

          File.open(File.join(image_folder, File.basename(uri.path)), "wb") do |file|
            file.write(image.read)
            @downloaded_images += 1
          end
        rescue OpenURI::HTTPError => e
          @invalid_urls << url
          @logger.error("Error while downloading #{url} with error: #{e.message}")
        end
      end
    end

    def self.log_download_statistics
      @logger.info("Total downloaded images: #{@downloaded_images}")
      @logger.info("Total invalid urls: #{@invalid_urls.count}")
    end
  end
end
