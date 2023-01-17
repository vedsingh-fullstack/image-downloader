# Image Downloader

This project is a simple rake task to download images from a file containing a list of URLs. The task uses the ImageDownloader service to download the images, and it saves the images in a folder passed with rake task in the root directory of the project.

## Installation

To use this project, you need to have Ruby installed on your machine. You can check if Ruby is installed by running the following command in your terminal:

```bash
ruby -v
```

You also need to have bundler installed to install the dependencies, you can check if bundler is installed by running the following command in your terminal:

```bash
bundle -v
```

Once you have Ruby and bundler installed, you can clone this repository and install the dependencies by running the following commands:


```bash

git clone https://github.com/vedsingh-fullstack/image_downloader.git
cd image-downloader
bundle install
```

## Usage

To download the images, you need to provide the path of the file containing the URLs and the batch size as arguments to the rake task.

Command to run the rake task, 

```bash
rake images:download[/path_to_urls.txt, batch_size, /path_for_image_folder]
```

replace path_to_urls.txt with path of the given text file. The above rake task will download the image inside images folder. 

Command to run the spec

```bash
rake spec
```




