# Designer Dashboard
This program is intended for use by designers as a means of managing portfolio designs with images and creating partnerships with admin created industry contacts. 

## Getting Started

### Prerequisites

Run this program on the latest version of Rails.

This program is dependent on ImageMagick to render images to the server properly.

Setup terminal commands for ImageMagick:
```brew install imagemagick```

Setup environment with:
```bundle install```

### Prepping the Database

To run migration and create database: ```rails db:setup```.

### Running Tests

Program runs on the latest version of RSpec.
To run test suite, in your terminal: ```rspec```

### Deployment

To deploy to server run: ```rails s``` and load url: ```localhost:3000``` in browser.
