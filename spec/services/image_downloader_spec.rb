# frozen_string_literal: true

require "fileutils"

RSpec.describe Services::ImageDownloader do
  describe ".download" do
    let(:file_path) { File.join(Dir.pwd, "spec", "fixtures", "urls.txt") }
    let(:batch_size) { 2 }
    let(:image_folder) { File.join(Dir.pwd, "images") }

    before(:each) do
      FileUtils.rm_rf(Dir["#{image_folder}/*"])  
    end

    it "downloads images from file" do
      Services::ImageDownloader.download(file_path, batch_size)
      expect(Dir.entries(image_folder).count).to be > 2
    end

    context "when file is not found" do
      before do
        allow(File).to receive(:foreach).and_raise(Errno::ENOENT)
      end

      it "raises an error" do
        expect { Services::ImageDownloader.download(file_path, batch_size) }.to raise_error(Errno::ENOENT)
      end
    end
  end
end
