# frozen_string_literal: true

require_relative "../../app/services/image_downloader"

namespace :images do
  desc "Download images from a list of URLs in a text file"
  task :download, %i[file_path batch_size] => :environment do |_t, args|
    Services::ImageDownloader.download(args[:file_path], args[:batch_size].to_i)
  end
end
