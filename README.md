## Welcome to the Diaspora Project!

**THIS IS ALPHA SOFTWARE AND SHOULD BE TREATED ACCORDINGLY.**
**IT IS FUN TO GET RUNNING, BUT EXPECT THINGS TO BE BROKEN.**

[![Build Status](https://secure.travis-ci.org/diasporg/diaspora.png)](http://travis-ci.org/diasporg/diaspora)
[![Dependency Status](https://gemnasium.com/diasporg/diaspora.png?travis)](https://gemnasium.com/diasporg/diaspora)


With Diaspora you can:

- Run and host your own pod and have control over your own social experience.
- Own your own data.
- Make friends across other pods seamlessly.

Documentation is available on our [wiki](https://github.com/diaspora/diaspora/wiki)

## Quick Start:

Here's how you can get a development environment up and running. You can check out system-specific guides [here](https://github.com/diaspora/diaspora/wiki/Installation-Guides).

### Step 1: Clone the repo in your working directory
```git clone git@github.com:diaspora/diaspora.git
```

### Step 2: Navigate to your cloned repository
```cd diaspora
```

### Step 3: Install Bundler and gems (depending on [OS Vendor](https://github.com/diaspora/diaspora/wiki/Installation-Guides))
``` gem install bundler && bundle install
```

### Step 4: Edit database.yml, and rename application.yml.example to just application.yml
``` cp application.yml.example application.yml 
    cp database.yml.example database.yml
```

### Step 5: Create and migrate the database (make sure your database of choice is started!)
```rake db:create && rake db:migrate
```

### Step 6: Start the test server
```rails s
```

## Resources:

- [Wiki](https://github.com/diaspora/diaspora/wiki)
- [Podmin Resources](https://github.com/diaspora/diaspora/wiki/Podmin-Resources)
- [Contributing](https://github.com/diaspora/diaspora/wiki/Getting-Started-With-Contributing)
- [Dev List](https://groups.google.com/forum/?fromgroups#!forum/diaspora-dev)
- [Discuss List](https://groups.google.com/forum/?fromgroups#!forum/diaspora-discuss)
- [IRC](http://webchat.freenode.net?channels=diaspora-dev)
