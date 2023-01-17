# frozen_string_literal: true

require "fileutils"

RSpec.describe Services::ImageDownloader do
  describe ".download" do
    let(:file_path) { File.join(Dir.pwd, "spec", "fixtures", "urls.txt") }
    let(:batch_size) { 2 }
    let(:image_folder) { File.join(Dir.pwd, "images") }

    before(:each) do
      FileUtils.rm_rf(image_folder) if File.directory?(image_folder)
    end

    context "when file path is invalid" do
      it "raises an error" do
        expect do
          Services::ImageDownloader.download("invalid_path", batch_size, image_folder)
        end.to raise_error(ArgumentError, "Invalid file path: invalid_path")
      end
    end

    context "when file is not found" do
      before do
        allow(File).to receive(:foreach).and_raise(Errno::ENOENT)
      end

      it "raises an error" do
        expect { Services::ImageDownloader.download(file_path, batch_size, image_folder) }.to raise_error(Errno::ENOENT)
      end
    end

    context "when file path and batch size are valid" do
      it "creates the image folder" do
        expect(File.directory?(image_folder)).to be false
        Services::ImageDownloader.download(file_path, batch_size, image_folder)
        expect(File.directory?(image_folder)).to be true
      end

      it "downloads images from file" do
        Services::ImageDownloader.download(file_path, batch_size, image_folder)
        expect(Dir.entries(image_folder).count).to be > 2
      end
    end
  end
end
