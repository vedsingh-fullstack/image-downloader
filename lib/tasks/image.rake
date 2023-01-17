# frozen_string_literal: true

require_relative "../../app/services/image_downloader"

namespace :images do
  desc "Download images from a list of URLs in a text file"
  task :download, [:file_path] => :environment do |_t, args|
    Services::ImageDownloader.download(args[:file_path])
  end
end
